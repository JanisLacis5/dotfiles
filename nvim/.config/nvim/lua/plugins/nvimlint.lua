require('lint').linters_by_ft = vim.tbl_extend('force', 
    require('lint').linters_by_ft, {
      lua = {'luac'},
      python = {},
      sh = {'bash'},
      c = {'cppcheck'},
      rust = {'clippy'},
      css = {'stylelint'},
      html = {'htmlhint'},
    }
)

