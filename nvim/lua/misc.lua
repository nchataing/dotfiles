-- numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.scrolloff = 15

-- spaces & tabs
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth=4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"

-- visual
vim.opt.colorcolumn = "100"
vim.opt.cursorline = true

-- terminal
vim.cmd([[autocmd TermOpen * setlocal nonumber]])
vim.cmd([[autocmd TermOpen * setlocal norelativenumber]])
