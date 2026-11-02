-- lsp.lua
local lsp_zero = require('lsp-zero')

-- Get capabilities from blink.cmp if available
local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_blink, blink = pcall(require, 'blink.cmp')
if has_blink then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

-- Enable default keymaps & pass blink capabilities to lspconfig
lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })

    -- Toggle Inlay Hints (Neovim 0.10+)
    vim.keymap.set("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, { buffer = bufnr, desc = "Toggle Inlay Hints" })
  end,
  capabilities = capabilities,
})

-- Setup Mason & Mason-LSPConfig
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'ts_ls', 'gopls', 'html', 'clangd', 'texlab', 'pyright', 'dockerls', 'yamlls' },
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

-- Configure diagnostics:
-- virtual_text is disabled here because tiny-inline-diagnostic handles rich inline display
vim.diagnostic.config({
  virtual_text = false,
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
    max_width = 80,
  },
})

-- Diagnostic navigation & manual inspection keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })

-- Auto-insert package header for new Go files to prevent gopls blank file errors
vim.api.nvim_create_autocmd("BufNewFile", {
  group = vim.api.nvim_create_augroup("GoBufNewFile", { clear = true }),
  pattern = "*.go",
  callback = function()
    local dir_name = vim.fn.expand("%:p:h:t")
    local pkg_name = dir_name
    if pkg_name == "" or pkg_name == "." or pkg_name == "/" then
      pkg_name = "main"
    end
    vim.api.nvim_buf_set_lines(0, 0, -1, false, { "package " .. pkg_name, "" })
  end,
})
