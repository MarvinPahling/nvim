return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
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
    -- this is a change
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
        "jdtls",
        "kotlin_language_server",
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
-- 	{
-- 		"mason-org/mason.nvim",
-- 		dependencies = {
-- 			{ "mason-org/mason-lspconfig.nvim" },
-- 			"WhoIsSethDaniel/mason-tool-installer.nvim",
-- 		},
-- 		config = function()
-- 			local mason = require("mason")
-- 			local mason_lspconfig = require("mason-lspconfig")
-- 			local mason_tool_installer = require("mason-tool-installer")
--
-- 			mason.setup({})
--
-- 			mason_lspconfig.setup({
-- 				automatic_installation = true,
-- 				ensure_installed = {
-- 					"html",
-- 					"cssls",
-- 					"jsonls",
-- 					"tailwindcss",
-- 					"ts_ls",
-- 					"docker_compose_language_service",
-- 					"dockerls",
-- 					"lua_ls",
-- 					"pyright",
-- 					"clangd",
-- 					"rust_analyzer",
-- 					"zls",
-- 				},
-- 				handler = {
-- 					function(server_name) -- default handler (optional)
-- 						require("lspconfig")[server_name].setup({
-- 							capabilities = capabilities,
-- 						})
-- 					end,
-- 				},
-- 			})
--
-- 			mason_tool_installer.setup({
-- 				ensure_installed = {
-- 					"prettier",
-- 					"stylua",
-- 					"isort",
-- 					"black",
-- 					"flake8",
-- 					"eslint_d",
-- 				},
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		event = { "BufReadPre", "BufNewFile" },
-- 		dependencies = {
-- 			"hrsh7th/cmp-nvim-lsp",
-- 			"nvim-telescope/telescope.nvim",
-- 			{ "mason-org/mason.nvim" },
-- 			{ "mason-org/mason-lspconfig.nvim" },
-- 			{ "antosha417/nvim-lsp-file-operations", config = true },
-- 			{ "folke/neodev.nvim", opts = {} },
-- 		},
-- 		config = function()
-- 			local lspconfig = require("lspconfig")
-- 			local mason_lspconfig = require("mason-lspconfig")
-- 			local cmp_nvim_lsp = require("cmp_nvim_lsp")
--
-- 			vim.api.nvim_create_autocmd("LspAttach", {
-- 				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
-- 				callback = function(ev)
-- 					-- Buffer local mappings.
-- 					-- See `:help vim.lsp.*` for documentation on any of the below functions
-- 					local opts = { buffer = ev.buf, silent = true }
-- 					local telescope_lsp = require("telescope.builtin")
--
-- 					opts.desc = "Go to declaration"
-- 					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
--
-- 					opts.desc = "Show LSP references"
-- 					vim.keymap.set("n", "gR", function()
-- 						telescope_lsp.lsp_references()
-- 					end, opts)
--
-- 					opts.desc = "Show LSP definitions"
-- 					vim.keymap.set("n", "gd", function()
-- 						telescope_lsp.lsp_definitions()
-- 					end, opts)
--
-- 					opts.desc = "Show LSP implementations"
-- 					vim.keymap.set("n", "gi", function()
-- 						telescope_lsp.lsp<ScrollWheelUp>implementations()
-- 					end, opts)
--
-- 					opts.desc = "Show LSP type definitions"
-- 					vim.keymap.set("n", "gt", function()
-- 						telescope_lsp.lsp_definitions()
-- 					end, opts)
--
-- 					opts.desc = "Show LSP type definitions"
-- 					vim.keymap.set("n", "gt", function()
-- 						telescope_lsp.lsp_type_definitions()
-- 					end, opts)
--
-- 					opts.desc = "See available code actions"
-- 					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
--
-- 					opts.desc = "Smart rename"
-- 					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
--
-- 					opts.desc = "Show buffer diagnostics"
-- 					vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
--
-- 					opts.desc = "Show line diagnostics"
-- 					vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
--
-- 					-- opts.desc = "Go to previous diagnostic"
-- 					-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- 					--
-- 					-- opts.desc = "Go to next diagnostic"
-- 					-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
--
-- 					opts.desc = "Show documentation for what is under cursor"
-- 					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--
-- 					opts.desc = "Restart LSP"
-- 					vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
-- 				end,
-- 			})
--
-- 			-- used to enable autocompletion (assign to every lsp server config)
-- 			local capabilities = cmp_nvim_lsp.default_capabilities()
-- 			mason_lspconfig.setup_handlers({
-- 				-- default handler for installed servers
-- 				function(server_name)
-- 					lspconfig[server_name].setup({
-- 						capabilities = capabilities,
-- 					})
-- 				end,
-- 				["ts_ls"] = function()
-- 					lspconfig["ts_ls"].setup({
-- 						settings = {
-- 							completions = {
-- 								completeFunctionCalls = true,
-- 							},
-- 						},
-- 					})
-- 				end,
-- 				["lua_ls"] = function()
-- 					-- configure lua server (with special settings)
-- 					lspconfig["lua_ls"].setup({
-- 						capabilities = capabilities,
-- 						settings = {
-- 							Lua = {
-- 								-- make the language server recognize "vim" global
-- 								diagnostics = {
-- 									globals = { "vim" },
-- 								},
-- 								completion = {
-- 									callSnippet = "Replace",
-- 								},
-- 							},
-- 						},
-- 					})
-- 				end,
-- 				["rust_analyzer"] = function()
-- 					lspconfig["rust_analyzer"].setup({
-- 						capabilities = capabilities,
-- 					})
-- 				end,
-- 				["pyright"] = function()
-- 					lspconfig["pyright"].setup({
-- 						capabilities = capabilities,
-- 						settings = {
-- 							python = {
-- 								analysis = {
-- 									-- Disable pylint
-- 									diagnosticMode = "workspace",
-- 									typeCheckingMode = "basic",
-- 								},
-- 							},
-- 						},
-- 					})
-- 				end,
-- 				["zls"] = function()
-- 					lspconfig["zls"].setup({
-- 						capabilities = capabilities,
-- 					})
-- 				end,
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"stevearc/conform.nvim",
-- 		event = { "BufReadPre", "BufNewFile" },
-- 		config = function()
-- 			local conform = require("conform")
--
-- 			conform.setup({
-- 				formatters_by_ft = {
-- 					javascript = { "prettier" },
-- 					typescript = { "prettier" },
-- 					javascriptreact = { "prettier" },
-- 					typescriptreact = { "prettier" },
-- 					svelte = { "prettier" },
-- 					css = { "prettier" },
-- 					html = { "prettier" },
-- 					json = { "prettier" },
-- 					yaml = { "prettier" },
-- 					markdown = { "prettier" },
-- 					graphql = { "prettier" },
-- 					liquid = { "prettier" },
-- 					lua = { "stylua" },
-- 					python = { "isort", "black" },
-- 				},
-- 				format_on_save = {
-- 					lsp_fallback = true,
-- 					async = false,
-- 					timeout_ms = 5000,
-- 				},
-- 			})
--
-- 			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
-- 				conform.format({
-- 					lsp_fallback = true,
-- 					async = false,
-- 					timeout_ms = 5000,
-- 				})
-- 			end, { desc = "Format file or range (in visual mode)" })
-- 		end,
-- 	},
-- 	{
-- 		"mfussenegger/nvim-lint",
-- 		event = { "BufReadPre", "BufNewFile" },
-- 		config = function()
-- 			local lint = require("lint")
--
-- 			lint.linters_by_ft = {
-- 				javascript = { "eslint_d" },
-- 				typescript = { "eslint_d" },
-- 				javascriptreact = { "eslint_d" },
-- 				typescriptreact = { "eslint_d" },
-- 				python = { "flake8" },
-- 			}
--
-- 			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
--
-- 			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
-- 				group = lint_augroup,
-- 				callback = function()
-- 					lint.try_lint()
-- 				end,
-- 			})
--
-- 			vim.keymap.set("n", "<leader>l", function()
-- 				lint.try_lint()
-- 			end, { desc = "Trigger linting for current file" })
-- 		end,
-- 	},
-- }

-- return {
--   "hrsh7th/nvim-cmp",
--   event = "InsertEnter",
--   dependencies = {
--     "hrsh7th/cmp-buffer", -- source for text in buffer
--     "hrsh7th/cmp-path", -- source for file system paths
--     {
--       "L3MON4D3/LuaSnip",
--       version = "v2.*",
--       -- install jsregexp (optional!).
--       build = "make install_jsregexp",
--     },
--     "rafamadriz/friendly-snippets",
--     "onsails/lspkind.nvim", -- vs-code like pictograms
--   },
--   config = function()
--     local cmp = require("cmp")
--     local lspkind = require("lspkind")
--     local luasnip = require("luasnip")
--
--     require("luasnip.loaders.from_vscode").lazy_load()
--
--     cmp.setup({
--       snippet = {
--         expand = function(args)
--           luasnip.lsp_expand(args.body)
--         end,
--       },
--       mapping = cmp.mapping.preset.insert({
--         ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-f>"] = cmp.mapping.scroll_docs(4),
--         ["<C-Space>"] = cmp.mapping.complete(),
--         ["<C-e>"] = cmp.mapping.close(),
--         ["<CR>"] = cmp.mapping.confirm({
--           behavior = cmp.ConfirmBehavior.Replace,
--           select = true,
--         }),
--         ["<Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.confirm({ select = true })
--           else
--             fallback()
--           end
--         end, { "i", "s" }),
--       }),
--       sources = cmp.config.sources({
--         { name = "nvim_lsp" },
--         { name = "luasnip" },
--         { name = "buffer" },
--         { name = "path" },
--       }),
--     })
--
--     vim.cmd([[
--       set completeopt=menuone,noinsert,noselect
--       highlight! default link CmpItemKind CmpItemMenuDefault
--     ]])
--   end,
-- }
