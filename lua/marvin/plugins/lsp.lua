return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "j-hui/fidget.nvim",
    "mfussenegger/nvim-jdtls",
    "mfussenegger/nvim-dap",
    { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 5000,
      },
    })
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )
    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_enable = true,
      ensure_installed = {
        "html",
        "cssls",
        "jsonls",
        "tailwindcss",
        "ts_ls",
        "docker_compose_language_service",
        "dockerls",
        "lua_ls",
        "pyright",
        "clangd",
        "rust_analyzer",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["ts_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig["ts_ls"].setup({
            settings = {
              completions = {
                completeFunctionCalls = true,
              },
            },
          })
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
                format = {
                  enable = true,
                  -- Put format options here
                  -- NOTE: the value should be STRING!!
                  defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                  },
                },
              },
            },
          })
        end,
        ["pyright"] = function()
          local lspconfig = require("lspconfig")
          lspconfig["pyright"].setup({
            capabilities = capabilities,
            settings = {
              python = {
                analysis = {
                  diagnosticMode = "workspace",
                  typeCheckingMode = "basic",
                },
              },
            },
          })
        end,
      },
    })
    require('mason-tool-installer').setup {
      ensure_installed = {
        'prettier',
        'clang-format',
        'biome',
        'black',
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 5,
      integrations = {
        ['mason-lspconfig'] = true,
        ['mason-null-ls'] = false,
        ['mason-nvim-dap'] = false,
      },
    }
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { silent = true, desc = "Show line diagnostics" })
  end,
}
