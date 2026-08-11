-- This file can be loaded by calling `lua require('plugins')` from your init.vim

--
-- Only required if you have packer configured as `opt`
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use("lervag/vimtex")
	use("nvim-lua/plenary.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("nvim-tree/nvim-web-devicons")
	use("ray-x/go.nvim")
	use("ray-x/guihua.lua")
	use("michaelrommel/nvim-silicon")
	use("christoomey/vim-tmux-navigator")

	-- Essential for writing React components. Auto-closes and auto-renames HTML/JSX tags.
	use("windwp/nvim-ts-autotag")

	-- Automatically pairs parentheses, brackets, and quotes. Integrates well with nvim-cmp.
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Smart commenting that understands context (e.g., knowing when to use {/* */} inside JSX vs // outside).
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Lightweight, lightning-fast formatter plugin.
	-- You can easily configure this to run Prettier for TS/JS and gofmt/goimports for Go on save.
	use("stevearc/conform.nvim")

	-- The standard for Neovim status lines. Highly customizable to match your specific terminal colors.
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- Since you use Fugitive for heavy Git operations, Gitsigns gives you the fast, inline gutter highlights for added/removed/modified lines.
	use("lewis6991/gitsigns.nvim")

	-- Recommended Productivity Plugins
	use({ "ThePrimeagen/harpoon", branch = "harpoon2", requires = { { "nvim-lua/plenary.nvim" } } })
	use("folke/trouble.nvim")
	use("j-hui/fidget.nvim")
	use("stevearc/oil.nvim")
	use("lukas-reineke/indent-blankline.nvim")

	--  use({
	--"L3MON4D3/LuaSnip",
	-- follow latest release.
	--tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!:).
	--run = "make install_jsregexp"
	--})

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
	})
	if packer_bootstrap then
		require("packer").sync()
	end
end)
