vim.g.mapleader = " "

-- Navigation
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Open file explorer (Oil)" })

vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find file (built-in)" })
vim.keymap.set("n", "<leader>fb", ":buffers<CR>:b ", { desc = "Switch buffer (built-in)" })

-- Line movement in visual mode
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered during scrolling / search
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search match (centered)" })

-- System clipboard yanking
vim.keymap.set({"n", "v"}, "<leader>y", '"+y', { desc = "Yank selection to clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })

-- File permissions
vim.keymap.set("n", "<leader>xc", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true })
