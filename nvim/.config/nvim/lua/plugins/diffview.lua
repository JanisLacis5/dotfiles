require("diffview").setup({
  enhanced_diff_hl = false,

  hooks = {
    diff_buf_win_enter = function()
      vim.wo.foldenable = false
    end,
  },

  view = {
    default = {
      disable_diagnostics = true,
      winbar_info = true,
    },
    file_history = {
      disable_diagnostics = true,
      winbar_info = true,
    },
  },
})
