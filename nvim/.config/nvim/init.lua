local vim = vim
local plug = vim.fn['plug#']

-- vim.g.UltiSnipsExpandTrigger = '<tab>'
-- vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
-- vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
-- vim.g.UltiSnipsSnippetDirectories = { "lua/plugins/ultisnips" }

vim.g.vimtex_compiler_latexmk = {
  options = {
    '-shell-escape',
    '-verbose',
    '-file-line-error',
    '-interaction=nonstopmode',
    '-synctex=1',
  },
}

vim.g.start_time = vim.fn.reltime()
vim.g.mapleader = " "
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')
vim.loader.enable()
vim.call('plug#begin')

plug('catppuccin/nvim', { ['as'] = 'catppuccin' })
plug('Mofiqul/dracula.nvim')
plug('nvim-tree/nvim-tree.lua')
plug('windwp/nvim-autopairs')
plug('numToStr/Comment.nvim')
plug('nvim-tree/nvim-web-devicons')
plug('nvim-lualine/lualine.nvim') --statusline
plug('folke/which-key.nvim') --mappings popup
plug('romgrk/barbar.nvim') --bufferline
plug('goolord/alpha-nvim') --pretty startup
plug('nvim-treesitter/nvim-treesitter') --improved syntax
plug('mfussenegger/nvim-lint') --async linter
plug('lewis6991/gitsigns.nvim') --git
plug('ibhagwan/fzf-lua') --fuzzy finder and grep
plug('numToStr/FTerm.nvim') --floating terminal
plug('ron-rs/ron.vim') --ron syntax highlighting
plug('MeanderingProgrammer/render-markdown.nvim') --render md inline
-- plug('nvim-telescope/telescope.nvim')
-- plug('nvim-lua/plenary.nvim')
-- plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
-- plug('nvim-telescope/telescope-file-browser.nvim')

-- LSP + completion
plug('neovim/nvim-lspconfig')
plug('hrsh7th/nvim-cmp')
plug('hrsh7th/cmp-nvim-lsp')
plug('hrsh7th/cmp-buffer')
plug('hrsh7th/cmp-path')
plug('williamboman/mason.nvim')
plug('williamboman/mason-lspconfig.nvim')
plug('mg979/vim-visual-multi', { branch = 'master' })

-- Debug 
plug('mfussenegger/nvim-dap')
plug('rcarriga/nvim-dap-ui')
plug('theHamsta/nvim-dap-virtual-text')
plug('nvim-neotest/nvim-nio')
plug('jay-babu/mason-nvim-dap.nvim')


-- Snippets (optional but recommended)
-- plug('SirVer/ultisnips')
-- plug('quangnguyen30192/cmp-nvim-ultisnips')
plug('L3MON4D3/LuaSnip')
plug('saadparwaiz1/cmp_luasnip')

-- Optional snippet collection
plug('rafamadriz/friendly-snippets')

-- LaTeX
plug('lervag/vimtex')

vim.call('plug#end')

require('config.keymap')
require('config.options')
require('config.vimtex')
require('plugins.autopairs')
require('plugins.tree')
require('plugins.colorscheme')
require('plugins.comment')
require('plugins.barbar')
require('plugins.fterm')
-- require('plugins.fzf')
require('plugins.gitsigns')
require('plugins.lualine')
require('plugins.nvimlint')
require('plugins.rendermd')
require('plugins.ron')
require('plugins.treesitter')
require('plugins.whichkey')
require('plugins.cmp_nvim_lsp')
require('plugins.nvim_cmp')
require('plugins.lspconfig')
require('plugins.luasnip')
require('plugins.debugger')
-- require('plugins.telescope')

vim.cmd.colorscheme("catppuccin") -- dracula | catppuccin

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.cpp",
    callback = function()
        vim.system({"make", "-C", "build", "format"})
    end,
})
