vim.cmd("colorscheme aura-dark")

local palette = {
  bg = "#15141b",
  bg_alt = "#1b1a23",
  bg_visual = "#2a2837",
  fg = "#edecee",
  muted = "#6d6d6d",
  purple = "#a277ff",
  cyan = "#82e2ff",
  green = "#61ffca",
  yellow = "#ffca85",
  red = "#ff6767",
}

local set = vim.api.nvim_set_hl

set(0, "Normal", { fg = palette.fg, bg = palette.bg })
set(0, "NormalFloat", { fg = palette.fg, bg = palette.bg_alt })
set(0, "FloatBorder", { fg = palette.purple, bg = palette.bg_alt })
set(0, "CursorLine", { bg = palette.bg_alt })
set(0, "Visual", { bg = palette.bg_visual })
set(0, "LineNr", { fg = palette.muted })
set(0, "CursorLineNr", { fg = palette.purple, bold = true })
set(0, "Comment", { fg = palette.muted, italic = true })
set(0, "Function", { fg = palette.cyan })
set(0, "Keyword", { fg = palette.purple, italic = true })
set(0, "String", { fg = palette.green })
set(0, "Type", { fg = palette.yellow })

set(0, "DiagnosticError", { fg = palette.red })
set(0, "DiagnosticWarn", { fg = palette.yellow })
set(0, "DiagnosticInfo", { fg = palette.cyan })
set(0, "DiagnosticHint", { fg = palette.green })

set(0, "Pmenu", { fg = palette.fg, bg = palette.bg_alt })
set(0, "PmenuSel", { fg = palette.bg, bg = palette.purple, bold = true })
set(0, "Search", { fg = palette.bg, bg = palette.yellow, bold = true })
set(0, "IncSearch", { fg = palette.bg, bg = palette.cyan, bold = true })

vim.g.colors_name = "daniv-aura"
