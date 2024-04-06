-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- misc vim options
require 'misc'

-- custom mappings
require 'mapping'

-- try lazy here for now
require('lazy').setup({
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "c", "lua", "rust" },
                disable = { "fugitive", "vimdoc" },
                highlight = { enable = true, }
            }
        end
    },
    {
        'nchataing/nvim-grey',
        lazy = false,
        priority = 1000,
         config = function()
             vim.opt.termguicolors = true
             vim.cmd.colorscheme('grey')
        end
    },
    {
        'vim-airline/vim-airline'
    },
    {
        'vim-airline/vim-airline-themes',
        config = function()
            vim.g.airline_theme = 'papercolor'
        end
    },
    {
        'junegunn/fzf.vim',
        dependencies = { 'junegunn/fzf' },
        config = function()
            vim.keymap.set('n', '<Leader>p', ':FZF<CR>')
        end
    },
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<Leader>.', ':Git grep -q -w <c-r><c-w><CR>')
            vim.keymap.set('n', '<Leader>fo', ':Git fetch origin<CR>')
            vim.keymap.set('n', '<Leader>fc', [[:call fzf#run({'source': "git branch --format='%(refname:short)'", 'window': {'width': 0.8, 'height':0.6}, 'sink': ':Git checkout'})<CR>]])
            vim.keymap.set('n', '<Leader>fu', ':Git submodule update --recursive<CR>')
        end
    },
    {
        'rhysd/vim-clang-format',
        config = function()
            vim.cmd("let g:clang_format#command = 'clang-format-11'")
            vim.cmd("let g:clang_format#auto_format = 1")
            vim.cmd("let g:clang_format#auto_filetypes = [ 'c', 'cpp', 'proto' ]")
        end
    },
    { "prisma/vim-prisma" }
})

