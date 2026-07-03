require('Yamo.packer')
require('Yamo.set')
require('Yamo.remap')
require('Yamo.zenblue')

vim.cmd.colorscheme("zenblue")
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.clipboard = {
  name = 'wl-clipboard',
  copy = {
    ['+'] = 'wl-copy --foreground',
    ['*'] = 'wl-copy --foreground --primary',
  },
  paste = {
    ['+'] = 'wl-paste --no-newline',
    ['*'] = 'wl-paste --no-newline --primary',
  },
  cache_enabled = true,
}

