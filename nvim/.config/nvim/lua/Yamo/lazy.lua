-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone",
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
      { "<C-p>",      "<cmd>Telescope git_files<cr>",  desc = "Git Files" },
      { "<leader>pg", desc = "Grep String" },
      { "<leader>pm", desc = "Find in ~/Main" },
      { "<leader>pe", desc = "Find in ~/EDU" },
    },
    config = function()
      local builtin = require("telescope.builtin")
      -- fzf extension
      require("telescope").load_extension("fzf")
      -- keymaps that need the builtin reference
      vim.keymap.set("n", "<leader>pg", function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end, { desc = "Grep String" })
      vim.keymap.set("n", "<leader>pm", function()
        builtin.find_files({ shorten_path = true, cwd = "/run/media/yamo/Main", prompt = "~ Main ~" })
      end, { desc = "Find in ~/Main" })
      vim.keymap.set("n", "<leader>pe", function()
        builtin.find_files({ shorten_path = true, cwd = "/run/media/yamo/EDU", prompt = "~ EDU ~" })
      end, { desc = "Find in ~/EDU" })
    end,
  },

  -- ─── Treesitter ───────────────────────────────────────────────────────
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "rust", "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "cpp" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

  -- ─── LSP + Mason + Completion (via lsp-zero) ─────────────────────────
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      -- LSP
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Completion
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      -- Snippets
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    lazy = false,
  },

  -- ─── Formatting ──────────────────────────────────────────────────────
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = { { "<leader>f", mode = { "n", "v" }, desc = "Format buffer" } },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          go              = { "goimports", "gofmt" },
          javascript      = { "prettier" },
          typescript      = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          html            = { "prettier" },
          css             = { "prettier" },
          scss            = { "prettier" },
          json            = { "prettier" },
          yaml            = { "prettier" },
          markdown        = { "prettier" },
          lua             = { "stylua" },
        },
        format_on_save = {
          timeout_ms   = 2000,
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
        { "<leader>p",  group = "Telescope" },
        { "<leader>h",  group = "Git Hunks" },
        { "<leader>x",  group = "Trouble / chmod" },
        { "<leader>c",  group = "Code" },
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
          enable_close          = true,
          enable_rename         = true,
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
        scope  = { enabled = true },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",      desc = "Symbols (Trouble)" },
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
      { "<leader>a", desc = "Harpoon Add" },
      { "<C-e>",     desc = "Harpoon Menu" },
      { "<C-h>",     desc = "Harpoon 1" },
      { "<C-t>",     desc = "Harpoon 2" },
      { "<C-n>",     desc = "Harpoon 3" },
      { "<C-s>",     desc = "Harpoon 4" },
    },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,                    { desc = "Harpoon Add File" })
      vim.keymap.set("n", "<C-e>",     function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })
      vim.keymap.set("n", "<C-h>",     function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-t>",     function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-n>",     function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-s>",     function() harpoon:list():select(4) end)
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
        go                  = "go",
        gofmt               = "gofumpt",
        max_line_len        = 120,
        tag_transform       = false,
        test_template       = "",
        test_template_dir   = "",
        comment_placeholder = "",
        verbose             = false,
        lsp_cfg             = false, -- lsp-zero/mason manages LSP
        lsp_gofumpt         = true,
        lsp_on_attach       = nil,
        dap_debug           = true,
      })
    end,
  },
  { "ray-x/guihua.lua", lazy = true },
  { "lervag/vimtex",    ft = { "tex", "latex" } },

  -- ─── Code Screenshot ─────────────────────────────────────────────────
  {
    "michaelrommel/nvim-silicon",
    cmd = "Silicon",
    config = function()
      require("silicon").setup({
        font         = "Fira Code=16",
        theme        = "ZenBlue",
        background   = "#000520",
        shadow_color = "#00000080",
        line_number  = true,
        pad_horiz    = 20,
        pad_vert     = 20,
        watermark    = { text = "ZenBlue" },
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
        "gzip", "matchit", "matchparen",
        "netrwPlugin", "tarPlugin", "tohtml",
        "tutor", "zipPlugin",
      },
    },
  },
})
