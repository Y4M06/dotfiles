if vim.g.colors_name then
  vim.cmd("highlight clear")
end

if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "zenblue"
vim.o.background = "dark"

require("zenblue").setup()