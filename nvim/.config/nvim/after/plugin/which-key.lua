-- which-key group and keymap registrations
local status_ok, wk = pcall(require, "which-key")
if not status_ok then return end

wk.add({
  -- Groups
  { "<leader>p",  group = "Telescope" },
  { "<leader>h",  group = "Git Hunks" },
  { "<leader>x",  group = "Execution / Diagnostics" },
  { "<leader>c",  group = "Code Actions" },
  { "<leader>t",  group = "Toggle" },

  -- Code & Actions
  { "<leader>ca", desc = "Code Actions (Preview)", mode = { "n", "v" } },
  { "<leader>th", desc = "Toggle Inlay Hints" },

  -- Telescope
  { "<leader>pf", desc = "Find Files" },
  { "<leader>pg", desc = "Grep String" },
  { "<leader>pm", desc = "Find in ~/Main" },
  { "<leader>pe", desc = "Find in ~/EDU" },

  -- Git (gitsigns / fugitive)
  { "<leader>hs", desc = "Stage hunk" },
  { "<leader>hr", desc = "Reset hunk" },
  { "<leader>hp", desc = "Preview hunk" },
  { "<leader>hb", desc = "Blame line" },
  { "<leader>hd", desc = "Diff this" },
  { "<leader>gs", desc = "Git Status (fugitive)" },

  -- Navigation & Explorer
  { "<leader>e",  desc = "File explorer (Oil)" },
  { "<leader>a",  desc = "Harpoon Add File" },
  { "<leader>ff", desc = "Find file (cmd)" },
  { "<leader>fb", desc = "Switch buffer (cmd)" },

  -- Clipboard
  { "<leader>y",  desc = "Yank → clipboard",  mode = { "n", "v" } },
  { "<leader>Y",  desc = "Yank line → clipboard" },

  -- Formatting / Undo / Execution
  { "<leader>f",  desc = "Format buffer",      mode = { "n", "v" } },
  { "<leader>u",  desc = "Undo Tree" },
  { "<leader>xc", desc = "Make file executable (chmod +x)" },
  { "<leader>xx", desc = "Diagnostics (Trouble)" },
  { "<leader>xd", desc = "Buffer Diagnostics (Trouble)" },
})
