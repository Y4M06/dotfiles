-- lsp.lua
local lsp_zero = require('lsp-zero')

-- Enable default keymaps & pass cmp capabilities to lspconfig
lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_zero.default_keymaps,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Setup Mason & Mason-LSPConfig
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'ts_ls', 'gopls', 'html' },
  handlers = {
    -- Default handler for installed servers
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

    -- Specific handler for lua_ls
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,

    -- Specific handler for gopls
    gopls = function()
      require('lspconfig').gopls.setup({
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })
    end,

    -- Specific handler for ts_ls
    ts_ls = function()
      require('lspconfig').ts_ls.setup({})
    end,
  },
})

-- Load VSCode snippet definitions (e.g. friendly-snippets for HTML, Go, etc.)
require('luasnip.loaders.from_vscode').lazy_load()

-- Setup nvim-cmp for autocomplete
local cmp = require('cmp')

cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lua' },
  },
  mapping = cmp.mapping.preset.insert({
    -- Confirm selection with Enter or Ctrl-y
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),

    -- Trigger completion menu manually
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate completion items with Tab / Shift-Tab
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

    -- Scroll documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

-- Configure diagnostics: enable virtual_text for inline error messages and custom sign icons
vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN]  = '▲',
      [vim.diagnostic.severity.INFO]  = 'ℹ',
      [vim.diagnostic.severity.HINT]  = '💡',
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})
