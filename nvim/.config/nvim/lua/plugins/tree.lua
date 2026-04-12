require("nvim-tree").setup({
    git = {
        enable = true,
        ignore = false
    },
    renderer = {
        icons = {
            show = {
            file = false,
            folder = false,
            folder_arrow = true,
            git = true,
            },
        },
    },
    view = {
        width = 25,
        side = 'left',
    },
    sync_root_with_cwd = true, --fix to open cwd with tree
    respect_buf_cwd = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
        update_root = true,
    },
})

vim.g.nvim_tree_respect_buf_cwd = 1
