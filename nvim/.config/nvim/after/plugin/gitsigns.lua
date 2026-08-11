require("gitsigns").setup({
    signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "▁" },
        topdelete    = { text = "▔" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
    },
    signs_staged = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "▁" },
        topdelete    = { text = "▔" },
        changedelete = { text = "▎" },
    },
    -- ZenBlue colors
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]h", gs.next_hunk,        "Next hunk")
        map("n", "[h", gs.prev_hunk,        "Prev hunk")

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk,   "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk,   "Reset hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>hd", gs.diffthis,     "Diff this")
    end,
})

-- Apply ZenBlue gutter colors
vim.api.nvim_set_hl(0, "GitSignsAdd",    { fg = "#4EC994" }) -- okGreen
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#FFCB6B" }) -- warnYellow
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff6b6b" }) -- errorRed
