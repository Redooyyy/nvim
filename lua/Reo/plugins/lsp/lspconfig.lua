return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"RobertBrunhage/dart-tools.nvim",
		{ "j-hui/fidget.nvim", tag = "legacy" },
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		local util = require("lspconfig.util")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local dartExcludedFolders = {
			--vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),--
			vim.fn.expand("$HOME/.pub-cache"),
			vim.fn.expand("/opt/dart-sdk/bin/snapshots/analysis_server.dart.snapshot"),
			vim.fn.expand("$HOME/flutter/"),
		}

		lspconfig["dcmls"].setup({
			capabilities = capabilities,
			default_config = {
				cmd = { "dcm", "start-server", "--client=neovim" },
				filetypes = { "dart" },
			},
		})

		lspconfig["dartls"].setup({
			capabilities = capabilities,
			cmd = {
				"dart",
				"language-server",
				"--protocol=lsp",
				-- "--port=8123",
				-- "--instrumentation-log-file=/Users/robertbrunhage/Desktop/lsp-log.txt",
			},
			filetypes = { "dart" },
			init_options = {
				onlyAnalyzeProjectsWithOpenFiles = false,
				suggestFromUnimportedLibraries = true,
				closingLabels = true,
				outline = false,
				flutterOutline = false,
			},
			settings = {
				dart = {
					analysisExcludedFolders = dartExcludedFolders,
					updateImportsOnRename = true,
					completeFunctionCalls = true,
					showTodos = true,
				},
			},
		})

		lspconfig.astro.setup({
			capabilities = capabilities,
		})

		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
		})

		lspconfig.ts_ls.setup({
			capabilities = capabilities,
		})

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					-- runtime = {
					--   version = "LuaJIT",
					-- },
					diagnostics = {
						globals = { "vim" },
					},
					-- workspace = {
					--   checkThirdParty = false,
					--   library = {
					--     '${3rd}/luv/library',
					--     unpack(vim.api.nvim_get_runtime_rile("", true)),
					--     vim.api.nvim_get_proc,
					--   }
					-- },
				},
			},
		})

		-- Tooltip for the lsp in bottom right
		require("fidget").setup({})

		-- Hot reload :)
		require("dart-tools")
	end,
}
