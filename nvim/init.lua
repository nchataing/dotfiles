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

local lsp_servers = {
  'clangd',
  'efm',
  'pyright',
  'rust_analyzer',
  'ts_ls',
  'zls',
}

-- LSP attach handler
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gR', vim.lsp.buf.rename, '[G]lobal [R]ename')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>h', vim.lsp.buf.hover, 'Hover Documentation')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })
end

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
        'ziglang/zig'
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
            vim.keymap.set('n', '<Leader>fo', ':Git fetch origin --prune<CR>')
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
    { 'prisma/vim-prisma' },
    {
        'knsh14/vim-github-link',
        config = function()
            vim.keymap.set({'n', 'v'}, '<Leader>l', ':GetCommitLink<CR>')
        end
    },

    -- LSP
    {
      'lukas-reineke/lsp-format.nvim',
      config = function()
        require('lsp-format').setup()
      end
    },
    { 'williamboman/mason.nvim' },
    {
      'williamboman/mason-lspconfig.nvim',
      config = function()

        require('mason').setup()
        require('mason-lspconfig').setup({
          ensure_installed = lsp_servers,
        })
      end
    },
    {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      priority = 10,
      config = function()
        require('fidget').setup({})
      end
    },
    {
      'neovim/nvim-lspconfig',
      config = function()
        local lspconfig = require('lspconfig')


        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        local prettier = {
          formatCommand = "prettierd '${INPUT}'",
          formatStdin = true,
        }

        lspconfig.ts_ls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
          filetypes = {'typescript', 'typescriptreact', 'typescript.tsx'}
        }

        lspconfig.zls.setup {
          capabilities = capabilities
        }

        lspconfig.clangd.setup {
          capabilities = capabilities,
          filetypes = {'c', 'cpp'}
        }

        lspconfig.pyright.setup {
          capabilities = capabilities
        }

        lspconfig.efm.setup({
          on_attach = require('lsp-format').on_attach,
          init_options = { documentFormatting = true },
          settings = {
            languages = {
              json = { prettier },
              conf = { prettier },
              prisma = { prettier },
              typescript = { prettier },
              typescriptreact = { prettier },
              javascript = { prettier },
              javascriptreact = { prettier },
              yaml = { prettier },
            },
          },
        })

        lspconfig.rust_analyzer.setup {
            settings = {
                ['rust-analyzer'] = {
                    check = {
                        command = "clippy";
                    },
                    diagnostics = {
                        enable = true;
                    }
                }
            }
        }


        -- Show line diagnostics automatically in hover window
        vim.diagnostic.config({ virtual_text = false })
        vim.o.updatetime = 250
        vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
      end
    },
    { "hrsh7th/cmp-nvim-lsp" },
    {
      "hrsh7th/nvim-cmp",
      config = function()
        local cmp = require('cmp')
        cmp.setup({
          mapping = cmp.mapping.preset.insert {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end, { 'i', 's' }),
          },
          sources = {
            { name = 'nvim_lsp' },
          },
        })
      end
    },
})
