-- ZenBlue Theme - Main module with palette and highlight setup

local M = {}

-- Color palette extracted from ZenBlue VS Code theme
local palette = {
  -- Editor base colors
  bg = "#000520",
  fg = "#ffffff",
  
  -- UI backgrounds
  ui_bg = "#01072b",
  ui_darker = "#010a3c",
  sidebar_bg = "#00031a",
  
  -- Line numbers
  line_nr = "#1e4872",
  line_nr_active = "#229bff",
  
  -- Selections and highlights
  selection_bg = "#0e3672",
  highlight_match = "#3a6090",
  cursor_color = "#FFE4C2",
  
  -- Accent colors (UI elements)
  accent = "#007ce2",
  
  -- Syntax token colors
  comment = "#6289bd",
  variable = "#EDF9B1",
  keyword = "#006EFF",
  operator = "#2EC0FF",
  function_call = "#00eeff",
  tag = "#EDF9B1",
  string = "#C8D4FF",
  constant = "#00EEFF",
  type = "#2EC0FF",
  attribute = "#00EEFF",
  html_attr = "#FFCB6B",
  invalid = "#438eff",
  
  -- Diagnostic colors
  error = "#FF6B6B",
  warning = "#FFD700",
  info = "#229bff",
  hint = "#00EEFF",
  
  -- Additional UI
  border = "#2EC0FF",
  pmenu_bg = "#010a3c",
  pmenu_sel = "#0e3672",
}

function M.setup()
  -- Base UI highlights
  vim.api.nvim_set_hl(0, "Normal", { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = palette.fg, bg = palette.ui_darker })
  vim.api.nvim_set_hl(0, "NormalNC", { fg = palette.fg, bg = palette.bg })
  
  -- Line numbers and status
  vim.api.nvim_set_hl(0, "LineNr", { fg = palette.line_nr, bg = palette.bg })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = palette.line_nr_active, bg = palette.bg, bold = true })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.selection_bg })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = palette.selection_bg })
  
  -- Selection and search
  vim.api.nvim_set_hl(0, "Visual", { bg = palette.selection_bg })
  vim.api.nvim_set_hl(0, "VisualNOS", { bg = palette.selection_bg })
  vim.api.nvim_set_hl(0, "Search", { bg = palette.highlight_match, fg = palette.fg })
  vim.api.nvim_set_hl(0, "IncSearch", { bg = palette.highlight_match, fg = palette.fg, bold = true })
  
  -- Cursor
  vim.api.nvim_set_hl(0, "Cursor", { fg = palette.bg, bg = palette.cursor_color })
  vim.api.nvim_set_hl(0, "TermCursor", { fg = palette.bg, bg = palette.cursor_color })
  
  -- UI Elements
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = palette.operator, bg = palette.bg })
  vim.api.nvim_set_hl(0, "VertSplit", { fg = palette.operator, bg = palette.bg })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.border, bg = palette.ui_darker })
  
  -- Statusline
  vim.api.nvim_set_hl(0, "StatusLine", { fg = palette.fg, bg = palette.ui_darker })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#666666", bg = palette.ui_darker })
  vim.api.nvim_set_hl(0, "ModeMsg", { fg = palette.accent, bold = true })
  
  -- Popup menu (autocomplete)
  vim.api.nvim_set_hl(0, "Pmenu", { fg = palette.fg, bg = palette.pmenu_bg })
  vim.api.nvim_set_hl(0, "PmenuSel", { fg = palette.fg, bg = palette.selection_bg, bold = true })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = palette.ui_darker })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = palette.operator })
  
  -- Error/Warning/Info
  vim.api.nvim_set_hl(0, "Error", { fg = palette.error })
  vim.api.nvim_set_hl(0, "Warning", { fg = palette.warning })
  vim.api.nvim_set_hl(0, "WarningMsg", { fg = palette.warning })
  vim.api.nvim_set_hl(0, "ErrorMsg", { fg = palette.error })
  vim.api.nvim_set_hl(0, "MoreMsg", { fg = palette.info })
  
  -- Diagnostics
  vim.api.nvim_set_hl(0, "DiagnosticError", { fg = palette.error })
  vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = palette.warning })
  vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = palette.info })
  vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = palette.hint })
  
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = palette.error })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = palette.warning })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = palette.info })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = palette.hint })
  
  -- Syntax Highlighting - Standard Vim
  vim.api.nvim_set_hl(0, "String", { fg = palette.string })
  vim.api.nvim_set_hl(0, "Function", { fg = palette.function_call })
  vim.api.nvim_set_hl(0, "Identifier", { fg = palette.variable })

  -- Syntax Highlighting - TreeSitter
  vim.api.nvim_set_hl(0, "@comment", { fg = palette.comment, italic = true })
  vim.api.nvim_set_hl(0, "@comment.documentation", { fg = palette.comment, italic = true })
  
  vim.api.nvim_set_hl(0, "@keyword", { fg = palette.keyword })
  vim.api.nvim_set_hl(0, "@keyword.function", { fg = palette.keyword })
  vim.api.nvim_set_hl(0, "@keyword.operator", { fg = palette.operator })
  vim.api.nvim_set_hl(0, "@keyword.return", { fg = palette.keyword })
  vim.api.nvim_set_hl(0, "@keyword.import", { fg = palette.keyword })
  
  vim.api.nvim_set_hl(0, "@function", { fg = palette.function_call })
  vim.api.nvim_set_hl(0, "@function.call", { fg = palette.function_call })
  vim.api.nvim_set_hl(0, "@function.builtin", { fg = palette.function_call })
  vim.api.nvim_set_hl(0, "@function.macro", { fg = palette.function_call })
  vim.api.nvim_set_hl(0, "@method", { fg = palette.function_call })
  vim.api.nvim_set_hl(0, "@method.call", { fg = palette.function_call })
  
  vim.api.nvim_set_hl(0, "@module", { fg = palette.variable })
  vim.api.nvim_set_hl(0, "@module.builtin", { fg = palette.variable })
  vim.api.nvim_set_hl(0, "@namespace", { fg = palette.variable })
  vim.api.nvim_set_hl(0, "@variable", { fg = palette.variable })
  vim.api.nvim_set_hl(0, "@variable.builtin", { fg = palette.invalid, italic = true })
  vim.api.nvim_set_hl(0, "@variable.parameter", { fg = palette.constant })
  vim.api.nvim_set_hl(0, "@variable.member", { fg = palette.operator })
  
  vim.api.nvim_set_hl(0, "@constant", { fg = palette.constant })
  vim.api.nvim_set_hl(0, "@constant.builtin", { fg = palette.constant })
  vim.api.nvim_set_hl(0, "@constant.macro", { fg = palette.constant })
  
  vim.api.nvim_set_hl(0, "@string", { fg = palette.string })
  vim.api.nvim_set_hl(0, "@string.escape", { fg = palette.operator })
  vim.api.nvim_set_hl(0, "@string.special", { fg = palette.operator })
  vim.api.nvim_set_hl(0, "@string.regexp", { fg = palette.operator })
  
  vim.api.nvim_set_hl(0, "@number", { fg = palette.constant })
  vim.api.nvim_set_hl(0, "@boolean", { fg = palette.keyword })
  vim.api.nvim_set_hl(0, "@float", { fg = palette.constant })
  
  vim.api.nvim_set_hl(0, "@operator", { fg = palette.operator })
  vim.api.nvim_set_hl(0, "@punctuation", { fg = palette.operator })
  vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = palette.operator })
  vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = palette.operator })
  
  -- Type and class
  vim.api.nvim_set_hl(0, "@type", { fg = palette.type })
  vim.api.nvim_set_hl(0, "@type.builtin", { fg = palette.keyword })
  vim.api.nvim_set_hl(0, "@type.definition", { fg = palette.type })
  vim.api.nvim_set_hl(0, "@type.qualifier", { fg = palette.keyword })
  
  vim.api.nvim_set_hl(0, "@class", { fg = palette.type })
  vim.api.nvim_set_hl(0, "@structure", { fg = palette.type })
  vim.api.nvim_set_hl(0, "@interface", { fg = palette.type })
  vim.api.nvim_set_hl(0, "@enum", { fg = palette.type })
  
  -- Markup and tags
  vim.api.nvim_set_hl(0, "@tag", { fg = palette.keyword })
  vim.api.nvim_set_hl(0, "@tag.builtin", { fg = palette.keyword })
  vim.api.nvim_set_hl(0, "@tag.attribute", { fg = palette.html_attr, italic = true })
  vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = palette.keyword })
  
  vim.api.nvim_set_hl(0, "@property", { fg = palette.operator })
  vim.api.nvim_set_hl(0, "@property.builtin", { fg = palette.constant })
  
  vim.api.nvim_set_hl(0, "@attribute", { fg = palette.attribute })
  
  vim.api.nvim_set_hl(0, "@constructor", { fg = palette.function_call })
  vim.api.nvim_set_hl(0, "@parameter", { fg = palette.constant })
  
  -- Markup
  vim.api.nvim_set_hl(0, "@markup.strong", { bold = true, fg = palette.string })
  vim.api.nvim_set_hl(0, "@markup.italic", { italic = true, fg = palette.string })
  vim.api.nvim_set_hl(0, "@markup.link", { fg = palette.function_call, underline = true })
  vim.api.nvim_set_hl(0, "@markup.link.url", { fg = palette.function_call, underline = true })
  vim.api.nvim_set_hl(0, "@markup.heading", { fg = palette.string, bold = true })
  vim.api.nvim_set_hl(0, "@markup.list", { fg = palette.operator })
  vim.api.nvim_set_hl(0, "@markup.raw", { fg = palette.operator })
  
  -- JSX/TSX specific
  vim.api.nvim_set_hl(0, "@component", { fg = palette.tag })
  vim.api.nvim_set_hl(0, "@component.builtin", { fg = palette.keyword })
  
  -- Diff
  vim.api.nvim_set_hl(0, "@diff.plus", { fg = "#00cc00" })
  vim.api.nvim_set_hl(0, "@diff.minus", { fg = palette.error })
  vim.api.nvim_set_hl(0, "@diff.delta", { fg = palette.warning })
  
  -- Spell check
  vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = palette.error })
  vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = palette.warning })
  vim.api.nvim_set_hl(0, "SpellLocal", { undercurl = true, sp = palette.info })
  vim.api.nvim_set_hl(0, "SpellRare", { undercurl = true, sp = palette.hint })
  
  -- Folding
  vim.api.nvim_set_hl(0, "Folded", { fg = palette.comment, bg = palette.selection_bg })
  vim.api.nvim_set_hl(0, "FoldColumn", { fg = palette.line_nr, bg = palette.bg })
  
  -- Misc
  vim.api.nvim_set_hl(0, "Todo", { fg = palette.warning, bold = true })
  vim.api.nvim_set_hl(0, "SpecialKey", { fg = palette.operator })
  vim.api.nvim_set_hl(0, "NonText", { fg = palette.line_nr })
  vim.api.nvim_set_hl(0, "Whitespace", { fg = palette.line_nr })
  vim.api.nvim_set_hl(0, "Directory", { fg = palette.operator, bold = true })
  vim.api.nvim_set_hl(0, "Title", { fg = palette.fg, bold = true })

  -- netrw file explorer
  vim.api.nvim_set_hl(0, "netrwDir", { fg = palette.operator, bold = true })
  vim.api.nvim_set_hl(0, "netrwClassify", { fg = palette.accent })
  vim.api.nvim_set_hl(0, "netrwLink", { fg = palette.function_call })
  vim.api.nvim_set_hl(0, "netrwSymLink", { fg = palette.function_call })
  vim.api.nvim_set_hl(0, "netrwExe", { fg = palette.variable })
  vim.api.nvim_set_hl(0, "netrwComment", { fg = palette.comment, italic = true })
  vim.api.nvim_set_hl(0, "netrwList", { fg = palette.fg })
  vim.api.nvim_set_hl(0, "netrwTreeBar", { fg = palette.comment })
  
  -- Plugin highlights: Telescope
  vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = palette.border, bg = palette.ui_darker })
  vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = palette.fg, bg = palette.ui_darker })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = palette.fg, bg = palette.ui_darker })
  vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = palette.selection_bg, bold = true })
  vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = palette.highlight_match })
  vim.api.nvim_set_hl(0, "TelescopeTitle", { fg = palette.accent, bold = true })
  
  -- Plugin highlights: NvimTree
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = palette.fg, bg = palette.sidebar_bg })
  vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { fg = palette.fg, bg = palette.sidebar_bg })
  vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = palette.accent, bold = true })
  vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = palette.selection_bg })
  vim.api.nvim_set_hl(0, "NvimTreeOpenedFolder", { fg = palette.operator })
  vim.api.nvim_set_hl(0, "NvimTreeFileNew", { fg = palette.variable })
  vim.api.nvim_set_hl(0, "NvimTreeFileRenamed", { fg = palette.operator })
  vim.api.nvim_set_hl(0, "NvimTreeFileDeleted", { fg = palette.error })
  
  -- Plugin highlights: NeoTree
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = palette.fg, bg = palette.sidebar_bg })
  vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { fg = palette.fg, bg = palette.sidebar_bg })
  vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = palette.accent, bold = true })
  vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = palette.selection_bg })
  vim.api.nvim_set_hl(0, "NeoTreeBorder", { fg = palette.border })
  
  -- Plugin highlights: CMP (autocomplete)
  vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = palette.comment, strikethrough = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = palette.operator, bold = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = palette.operator, bold = true })
  vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = palette.variable })
  vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = palette.function_call })
  vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = palette.type })
  vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = palette.function_call })
  vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = palette.type })
  vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = palette.type })
  vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = palette.operator })
  vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = palette.type })
  vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = palette.operator })
  vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = palette.keyword })
  vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = palette.constant })
  vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = palette.variable })
end

return M