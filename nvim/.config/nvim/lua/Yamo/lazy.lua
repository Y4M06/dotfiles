-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	-- ─── Core Dependencies ──────────────────────────────────────────────
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- ─── Fuzzy Finder ────────────────────────────────────────────────────
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = "Telescope",
		keys = {
			{ "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
			{
				"<leader>pg",
				function()
					require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
				end,
				desc = "Grep String",
			},
			{
				"<leader>pd",
				function()
					require("telescope.builtin").find_files({
						shorten_path = true,
						cwd = "/run/media/yamo/dev",
						prompt = "~ dev ~",
					})
				end,
				desc = "Find in ~/dev",
			},
			{
				"<leader>ps",
				function()
					require("telescope.builtin").find_files({
						shorten_path = true,
						cwd = "/run/media/yamo/storage",
						prompt = "~ storage ~",
					})
				end,
				desc = "Find in ~/storage",
			},
			{
				"<leader>pe",
				function()
					require("telescope.builtin").find_files({
						shorten_path = true,
						cwd = "/run/media/yamo/edu",
						prompt = "~ edu ~",
					})
				end,
				desc = "Find in ~/edu",
			},
		},
		config = function()
			-- fzf extension
			require("telescope").load_extension("fzf")
		end,
	},

	-- ─── Treesitter ───────────────────────────────────────────────────────
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts_install = require("nvim-treesitter.install")
			ts_install.prefer_git = true
			ts_install.ts_generate_args = { "generate", "--abi", tostring(vim.treesitter.language_version) }
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = {
					"javascript",
					"typescript",
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"cpp",
					"latex",
					"markdown",
					"markdown_inline",
					"bash",
					"html",
					"css",
					"sql",
					"go",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				auto_install = true,

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

	-- ─── LSP + Mason ─────────────────────────────────────────────────────
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		lazy = false,
	},

	-- ─── Autocomplete (blink.cmp) ────────────────────────────────────────
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "*",
		opts = {
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-y>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},

	-- ─── Diagnostics & Code Actions ─────────────────────────────────────
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "modern",
				options = {
					show_source = true,
					multilines = {
						enabled = true,
						always_show = false,
					},
				},
			})
		end,
	},
	{
		"aznhe21/actions-preview.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{
				"<leader>ca",
				function()
					require("actions-preview").code_actions()
				end,
				mode = { "n", "v" },
				desc = "Code Actions (Preview)",
			},
		},
	},

	-- ─── Formatting ──────────────────────────────────────────────────────
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		keys = { { "<leader>f", mode = { "n", "v" }, desc = "Format buffer" } },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					go = { "goimports", "gofmt" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					lua = { "stylua" },
				},
				format_on_save = {
					timeout_ms = 2000,
					lsp_fallback = true,
				},
			})
			vim.keymap.set({ "n", "v" }, "<leader>f", function()
				require("conform").format({ async = true, lsp_fallback = true })
			end, { desc = "Format buffer" })
		end,
	},

	-- ─── Git ─────────────────────────────────────────────────────────────
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gstatus", "Gdiff", "Gcommit", "Gblame", "Gpush", "Gpull" },
		keys = { { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" } },
	},

	-- ─── File Explorer ───────────────────────────────────────────────────
	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent dir (Oil)" } },
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				view_options = { show_hidden = true },
			})
		end,
	},

	-- ─── Status Line ─────────────────────────────────────────────────────
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
	},

	-- ─── Tmux Navigation ────────────────────────────────────────────────
	{
		"christoomey/vim-tmux-navigator",
		event = "VeryLazy",
	},

	-- ─── Quality of Life ─────────────────────────────────────────────────
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			delay = 300,
			spec = {
				{ "<leader>p", group = "Telescope" },
				{ "<leader>h", group = "Git Hunks" },
				{ "<leader>x", group = "Trouble / chmod" },
				{ "<leader>c", group = "Code" },
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gc", mode = { "n", "v" }, desc = "Toggle comment" },
			{ "gb", mode = { "n", "v" }, desc = "Toggle block comment" },
		},
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("ibl").setup({
				indent = { char = "│" },
				scope = { enabled = true },
			})
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
		},
		config = function()
			require("trouble").setup({})
		end,
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		config = function()
			require("fidget").setup({
				notification = { window = { winblend = 0 } },
			})
		end,
	},

	-- ─── Navigation ──────────────────────────────────────────────────────
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>a",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Harpoon Add File",
			},
			{
				"<C-e>",
				function()
					local h = require("harpoon")
					h.ui:toggle_quick_menu(h:list())
				end,
				desc = "Harpoon Menu",
			},
			{
				"<C-h>",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Harpoon File 1",
			},
			{
				"<C-t>",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Harpoon File 2",
			},
			{
				"<C-n>",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Harpoon File 3",
			},
			{
				"<C-s>",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Harpoon File 4",
			},
		},
		config = function()
			require("harpoon"):setup()
		end,
	},
	{ "mbbill/undotree", keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" } } },

	-- ─── Language-specific ───────────────────────────────────────────────
	{
		"ray-x/go.nvim",
		dependencies = { "ray-x/guihua.lua" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
		config = function()
			require("go").setup({
				go = "go",
				gofmt = "gofumpt",
				max_line_len = 120,
				tag_transform = false,
				test_template = "",
				test_template_dir = "",
				comment_placeholder = "",
				verbose = false,
				lsp_cfg = false, -- lsp-zero/mason manages LSP
				lsp_gofumpt = true,
				lsp_on_attach = nil,
				dap_debug = true,
			})
		end,
	},
	{ "ray-x/guihua.lua", lazy = true },
	{ "lervag/vimtex", ft = { "tex", "latex" } },

	-- ─── Code Screenshot ─────────────────────────────────────────────────
	{
		"michaelrommel/nvim-silicon",
		cmd = "Silicon",
		config = function()
			require("silicon").setup({
				font = "Fira Code=16",
				theme = "ZenBlue",
				background = "#000520",
				shadow_color = "#00000080",
				line_number = true,
				pad_horiz = 20,
				pad_vert = 20,
				watermark = { text = "ZenBlue" },
			})
		end,
	},
}, {
	-- lazy.nvim UI options
	ui = {
		border = "rounded",
		title = " lazy.nvim ",
		title_pos = "center",
	},
	performance = {
		rtp = {
			-- Disable built-in plugins we don't use
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
