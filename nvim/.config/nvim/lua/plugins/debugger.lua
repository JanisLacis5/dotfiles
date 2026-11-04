local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local dapui = require("dapui")

mason_dap.setup({
  ensure_installed = { "codelldb" },
  automatic_installation = true,
})

require("nvim-dap-virtual-text").setup({})

dapui.setup({
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.35 },
        { id = "breakpoints", size = 0.20 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.20 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        -- { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 10,
      position = "bottom",
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
local codelldb_path = mason_path .. "adapter/codelldb"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
  },
}

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--quiet", "--interpreter=dap" },
}

-- Use the kernel build's symbols regardless of Neovim's working directory.
local kernel_config = {
  name = "Attach Linux kernel (localhost:1235)",
  type = "gdb",
  request = "attach",
  program = "/home/janis/dev/builds_linux/build/vmlinux",
  target = "localhost:1235",
}


-- Initialize once per attachment, after the remote target has stopped.
-- Omit frameId: symbol loading can invalidate DAP's cached stack frames.
local kernel_symbol_sessions = setmetatable({}, { __mode = "k" })
dap.listeners.after.event_stopped["kernel_symbols"] = function(session)
  if session.config.name ~= kernel_config.name
      or session.config.type ~= kernel_config.type
      or kernel_symbol_sessions[session] then
    return
  end
  kernel_symbol_sessions[session] = true

  local commands = {
    "source /home/janis/dev/builds_linux/build/vmlinux-gdb.py",
    "lx-symbols /home/janis/dev/builds_linux/build/drivers/net/ethernet/janis",
  }
  local function run_command(index)
    session:request("evaluate", {
      context = "repl",
      expression = commands[index],
    }, function(err, response)
      if err then
        kernel_symbol_sessions[session] = nil
        vim.notify("Kernel symbol setup failed: " .. vim.inspect(err), vim.log.levels.ERROR)
        return
      end
      if response and response.result and response.result ~= "" then
        dap.repl.append(response.result)
      end
      if index < #commands then
        run_command(index + 1)
      else
        vim.notify("Kernel module symbols ready; continue before running insmod.")
      end
    end)
  end
  run_command(1)
end

local function input_executable()
  return vim.fn.input(
    "Executable: ",
    vim.fn.getcwd() .. "/build/debug/",
    "file"
  )
end

local function input_args()
  local args = vim.fn.input("Args: ")

  if args == "" then
    return {}
  end

  return vim.split(args, " ")
end

dap.configurations.cpp = {
  kernel_config,
  {
    name = "Launch debug executable",
    type = "codelldb",
    request = "launch",
    program = input_executable,
    args = input_args,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
    runInTerminal = false,
  },

    {
      name = "Debug replayexe",
      type = "codelldb",
      request = "launch",
      program = "${workspaceFolder}/build/debug/src/replay/replayexe",
      args = {},
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      initCommands = {
        "breakpoint set --name main",
      },
      runInTerminal = false,
    },

  {
    name = "Debug tests",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input(
        "Test executable: ",
        vim.fn.getcwd() .. "/build/debug/",
        "file"
      )
    end,
    args = {},
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
    runInTerminal = false,
  },
}

vim.fn.sign_define("DapStopped", {
  text = "▶",
  texthl = "DiagnosticWarn",
  linehl = "Visual",
  numhl = "DiagnosticWarn",
})

vim.fn.sign_define("DapBreakpoint", {
  text = "●",
  texthl = "DiagnosticError",
  linehl = "",
  numhl = "DiagnosticError",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "○",
  texthl = "DiagnosticError",
  linehl = "",
  numhl = "DiagnosticError",
})

dap.configurations.c = dap.configurations.cpp

vim.keymap.set("n", "<F7>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)

vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dk", function()
  dap.run(kernel_config)
end, { desc = "Attach Linux kernel" })
vim.keymap.set("n", "<leader>dd", function()
  dap.disconnect({ terminateDebuggee = false })
end, { desc = "Disconnect debugger" })
vim.keymap.set("n", "<leader>do", dap.step_over)
vim.keymap.set("n", "<leader>di", dap.step_into)
vim.keymap.set("n", "<leader>dO", dap.step_out)
vim.keymap.set("n", "<leader>dt", dap.terminate)
vim.keymap.set("n", "<leader>dl", dap.run_last)

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)

vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

vim.keymap.set("n", "<leader>dr", dap.repl.open)
vim.keymap.set("n", "<leader>du", dapui.toggle)

vim.keymap.set("n", "<leader>dh", function()
  require("dap.ui.widgets").hover()
end)
vim.keymap.set("n", "<space>?", function()
    require("dapui").eval(nil, { enter = true })
end)
