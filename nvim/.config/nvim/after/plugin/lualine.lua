-- lualine with ZenBlue palette
-- Matches: bg3 #010a3c, accent #007ce2, cyan #00eeff, fg #ffffff, comment #6289bd

local zenblue = {
    normal = {
        a = { fg = "#000520", bg = "#007ce2", gui = "bold" }, -- accent
        b = { fg = "#ffffff", bg = "#010a3c" },               -- bg3
        c = { fg = "#6289bd", bg = "#000520" },               -- comment / bg0
    },
    insert = {
        a = { fg = "#000520", bg = "#00eeff", gui = "bold" }, -- cyan
        b = { fg = "#ffffff", bg = "#010a3c" },
        c = { fg = "#6289bd", bg = "#000520" },
    },
    visual = {
        a = { fg = "#000520", bg = "#2EC0FF", gui = "bold" }, -- blue
        b = { fg = "#ffffff", bg = "#010a3c" },
        c = { fg = "#6289bd", bg = "#000520" },
    },
    replace = {
        a = { fg = "#ffffff", bg = "#438EFF", gui = "bold" }, -- blueDeep
        b = { fg = "#ffffff", bg = "#010a3c" },
        c = { fg = "#6289bd", bg = "#000520" },
    },
    command = {
        a = { fg = "#000520", bg = "#FFCB6B", gui = "bold" }, -- warnYellow
        b = { fg = "#ffffff", bg = "#010a3c" },
        c = { fg = "#6289bd", bg = "#000520" },
    },
    inactive = {
        a = { fg = "#6289bd", bg = "#010a3c", gui = "bold" },
        b = { fg = "#6289bd", bg = "#010a3c" },
        c = { fg = "#6289bd", bg = "#000520" },
    },
}

require("lualine").setup({
    options = {
        theme                = zenblue,
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
        globalstatus         = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } }, -- relative path
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
    },
})
