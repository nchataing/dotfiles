-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- misc vim options
require("misc")

-- custom mappings
require("mapping")

require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "typescript", "c", "lua", "rust" },
        disable = { "fugitive", "vimdoc" },
        highlight = { enable = true },
      })
    end,
  },
  {
    "nchataing/nvim-grey",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("grey")
    end,
  },
  {
    "vim-airline/vim-airline",
  },
  {
    "ziglang/zig",
  },
  {
    "vim-airline/vim-airline-themes",
    config = function()
      vim.g.airline_theme = "papercolor"
    end,
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    config = function()
      vim.keymap.set("n", "<Leader>p", ":FZF<CR>")
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<Leader>.", ":Git grep -q -w <c-r><c-w><CR>")
      vim.keymap.set("n", "<Leader>fo", ":Git fetch origin --prune<CR>")
      vim.keymap.set(
        "n",
        "<Leader>fc",
        [[:call fzf#run({'source': "git branch --format='%(refname:short)'", 'window': {'width': 0.8, 'height':0.6}, 'sink': ':Git checkout'})<CR>]]
      )
      vim.keymap.set("n", "<Leader>fu", ":Git submodule update --recursive<CR>")
    end,
  },
  --{
  --    'rhysd/vim-clang-format',
  --    config = function()
  --        vim.cmd("let g:clang_format#command = 'clang-format-11'")
  --        vim.cmd("let g:clang_format#auto_format = 1")
  --        vim.cmd("let g:clang_format#auto_filetypes = [ 'c', 'cpp', 'proto' ]")
  --    end
  --},
  { "prisma/vim-prisma" },
  {
    "knsh14/vim-github-link",
    config = function()
      vim.keymap.set({ "n", "v" }, "<Leader>l", ":GetCommitLink<CR>")
    end,
  },

  -- LSP
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    priority = 10,
    config = function()
      require("fidget").setup({})
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gR", vim.lsp.buf.rename, "[G]lobal [R]ename")
          map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
          map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
          map("<leader>A", vim.lsp.buf.code_action, "Code [A]ction")
          map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
          map("<leader>h", vim.lsp.buf.hover, "Hover Documentation")
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities =
        vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = {
        ts_ls = {},
        zls = {},
        clangd = {
          filetypes = { "c", "cpp" },
        },
        pyright = {},
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              check = {
                command = "clippy",
              },
              diagnostics = {
                enable = true,
              },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities =
              vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })

      -- Show line diagnostics automatically in hover window
      vim.diagnostic.config({ virtual_text = false })
      vim.o.updatetime = 250
      vim.cmd(
        [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
      )
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<Leader><Leader>",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", stop_after_first = true },
        javascriptreact = { "prettierd", stop_after_first = true },
        typescript = { "prettierd", stop_after_first = true },
        typescriptreact = { "prettierd", stop_after_first = true },
        json = { "prettierd", stop_after_first = true },
        markdown = { "prettierd", stop_after_first = true },
        c = { "clang-format-12" },
        cpp = { "clang-format-12" },
        proto = { "clang-format-12" },
      },
    },
  },
  {
    "github/copilot.vim",
    config = function()
      -- remap accept completion to <C-J> because <tab> is used for normal completion (e.g LSP)
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true

      -- Disable Copilot in specific git repositories
      local disabled_repos = {
        "/home/nchataing/w/hsm",
      }

      local function is_in_disabled_repo()
        local cwd = vim.fn.getcwd()
        for _, path in ipairs(disabled_repos) do
          if cwd:find(path, 1, true) then
            return true
          end
        end
        return false
      end

      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          if is_in_disabled_repo() then
            vim.b.copilot_enabled = false
          end
        end,
      })
    end,
  },
})
