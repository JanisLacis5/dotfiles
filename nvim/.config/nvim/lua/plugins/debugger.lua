local mason = require("mason")
local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local dapui = require("dapui")

mason.setup()

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
