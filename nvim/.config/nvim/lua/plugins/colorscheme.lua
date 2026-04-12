require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  integrations = { treesitter = true, nvimtree = true, cmp = true, gitsigns = true, lsp_trouble = true },
})

require('dracula').setup({
    show_end_of_buffer = true,
    transparent_bg = false
})

