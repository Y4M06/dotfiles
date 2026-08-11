-- which-key is configured via opts= in lazy.lua.
-- This file adds any extra group registrations for existing keymaps
-- that were defined outside of lazy.nvim's keys= spec.

local status_ok, wk = pcall(require, "which-key")
if not status_ok then return end

wk.add({
  -- Telescope
  { "<leader>pf", desc = "Find Files" },
  { "<leader>pg", desc = "Grep String" },
  { "<leader>pm", desc = "Find in ~/Main" },
  { "<leader>pe", desc = "Find in ~/EDU" },

  -- Git hunks (gitsigns)
  { "<leader>hs", desc = "Stage hunk" },
  { "<leader>hr", desc = "Reset hunk" },
  { "<leader>hp", desc = "Preview hunk" },
  { "<leader>hb", desc = "Blame line" },
  { "<leader>hd", desc = "Diff this" },

  -- Navigation
  { "<leader>e",  desc = "Netrw explorer" },
  { "<leader>ff", desc = "Find file (cmd)" },
  { "<leader>fb", desc = "Find buffer (cmd)" },

  -- Clipboard
  { "<leader>y",  desc = "Yank → clipboard",  mode = { "n", "v" } },
  { "<leader>Y",  desc = "Yank line → clipboard" },

  -- Misc
  { "<leader>x",  desc = "chmod +x" },
  { "<leader>f",  desc = "Format buffer",      mode = { "n", "v" } },
  { "<leader>u",  desc = "Undo Tree" },
  { "<leader>gs", desc = "Git Status (fugitive)" },
})
