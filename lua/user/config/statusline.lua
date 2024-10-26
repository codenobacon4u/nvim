local M = {}

vim.g.qf_disable_statusline = 1

vim.o.showmode = false

--[[
--- Cache for highlight groups
---@type table<string, boolean>
local statusline_hls = {}

---@param hl string
---@return string
function M.get_or_create_hl(hl)
    local hl_name = 'Statusline' .. hl

    if not statusline_hl[hl] then
        local bg_hl = vim.api.nvim_get_hl(0, { name = 'StatusLine' })
        local fg_hl = vim.api.nvim_get_hl(0, { name = hl })

        vim.api.nvim_set_hl(0, hl_name, { bg = ('#%06x'):format(bg_hl.bg), fg = ('#%06x'):format(fg_hl.fg) })
        statusline_hls[hl] = true
    end

    return hl_name
end
--]]

--- Current mode
---@return string
function M.mode_component()
    local mode_to_str = {
        ['n'] = 'NORMAL',
        ['no'] = 'OP-PENDING',
        ['nov'] = 'OP-PENDING',
        ['noV'] = 'OP-PENDING',
        ['no\22'] = 'OP-PENDING',
        ['niI'] = 'NORMAL',
        ['niR'] = 'NORMAL',
        ['niV'] = 'NORMAL',
        ['nt'] = 'NORMAL',
        ['ntT'] = 'NORMAL',
        ['v'] = 'VISUAL',
        ['vs'] = 'VISUAL',
        ['V'] = 'VISUAL',
        ['Vs'] = 'VISUAL',
        ['\22'] = 'VISUAL',
        ['\22s'] = 'VISUAL',
        ['s'] = 'SELECT',
        ['S'] = 'SELECT',
        ['\19'] = 'SELECT',
        ['i'] = 'INSERT',
        ['ic'] = 'INSERT',
        ['ix'] = 'INSERT',
        ['R'] = 'REPLACE',
        ['Rc'] = 'REPLACE',
        ['Rx'] = 'REPLACE',
        ['Rv'] = 'VIRT REPLACE',
        ['Rvc'] = 'VIRT REPLACE',
        ['Rvx'] = 'VIRT REPLACE',
        ['c'] = 'COMMAND',
        ['cv'] = 'VIM EX',
        ['ce'] = 'EX',
        ['r'] = 'PROMPT',
        ['rm'] = 'MORE',
        ['r?'] = 'CONFIRM',
        ['!'] = 'SHELL',
        ['t'] = 'TERMINAL',
    }

    local mode = mode_to_str[vim.api.nvim_get_mode().mode] or 'UNKNOWN'

    local hl = 'Other'
    if mode:find 'NORMAL' then
        hl = 'Normal'
    elseif mode:find 'PENDING' then
        hl = 'Pending'
    elseif mode:find 'VISUAL' then
        hl = 'Visual'
    elseif mode:find 'INSERT' or mode:find 'SELECT' then
        hl = 'Insert'
    elseif mode:find 'COMMAND' or mode:find 'TERMINAL' or mode:find 'EX' then
        hl = 'Command'
    end

    return table.concat {
        string.format('%%#StatuslineModeSeparator%s#', hl),
        string.format('%%#StatuslineMode%s#%s', hl, mode),
        string.format('%%#StatuslineModeSeparator%s#', hl),
    }
end

local function git_diff(type)
    local status = vim.b.gitsigns_status_dict
    if status and status[type] then
        return status[type]
    end

    return 0
end

function M.git_component()
    local branch = vim.b.gitsigns_head
    if not branch then
        return ''
    end
    local added = git_diff("added") > 0 and string.format('  %s', git_diff("added")) or ''
    local changed = git_diff("changed") > 0 and string.format('  %s', git_diff("changed")) or ''
    local removed = git_diff("removed") > 0 and string.format('  %s', git_diff("removed")) or '' 
   
    return string.format(' %s%s%s%s', branch, added, changed, removed)
end

function M.encoding_component()
    local encoding = vim.opt.fileencoding:get()
    return encoding ~= '' and string.format('%%#StatuslineModeSeparatorOther# %s', encoding) or ''
end

function M.position_component()
    local line = vim.fn.line '.'
    local line_count = vim.api.nvim_buf_line_count(0)
    local col = vim.fn.virtcol '.'

    return table.concat {
        '%#StatuslineItalic#l: ',
        string.format('%%#StatuslineTitle#%d', line),
        string.format('%%#StatuslineItalic#/%d c: %d', line_count, col),
    }
end


function M.render()
    local function concat_components(components)
        return vim.iter(components):skip(1):fold(components[1], function(acc, component)
            return #components > 0 and string.format('%s  %s', acc, component) or acc
        end)
    end

    return table.concat {
        concat_components {
            M.mode_component(),
            M.git_component(),
        },
        '%#StatusLine#%=',
        concat_components {
            M.encoding_component(),
            M.position_component(),
        },
        ' ',
    }
end

vim.o.statusline = "%!v:lua.require'user.config.statusline'.render()"

return M
