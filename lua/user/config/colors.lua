local palette = require("rose-pine.palette")
local groups = {}
for group, color in pairs(require("rose-pine.config").options.groups) do
    groups[group] = require("rose-pine.utilities").parse_color(color)
end

vim.cmd.colorscheme("rose-pine")

local statusline_groups = {}
for mode, color in pairs {
    Normal = palette.rose,
    Pending = palette.pine,
    Visual = palette.iris,
    Insert = palette.foam,
    Command = palette.love,
    Other = palette.rose,
} do
    statusline_groups['StatuslineMode' .. mode] = { fg = color, bg = palette.muted }
    statusline_groups['StatuslineModeSeparator' .. mode] = { fg = palette.muted, bg = groups.panel }
end
statusline_groups = vim.tbl_extend('error', statusline_groups, {
    StatusLineTerm = { link = "StatusLine" },
    StatusLineTermNC = { link = "StatusLineNC" },
    StatuslineItalic = { fg = palette.subtle, bg = groups.panel, italic = true },
    StatuslineSpinner = { fg = palette.subtle, bg = groups.panel, bold = true },
    StatuslineTitle = { fg = palette.subtle, bg = groups.panel, bold = true },
})

for group, opts in pairs(statusline_groups) do
    vim.api.nvim_set_hl(0, group, opts)
end

