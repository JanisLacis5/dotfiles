require("conform").setup({
    formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
    },

    format_on_save = {
        timeout_ms = 1000,
        lsp_format = "never",
    },

    formatters = {
        clang_format = {
            command = "clang-format-20",
            cwd = require("conform.util").root_file({
                ".clang-format",
                "_clang-format",
            }),
            require_cwd = true,
        },
    },
})
