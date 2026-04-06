-- helper function to assist the main func below
local function wrapText(text, limit)
    local lines = {}

    for line in text:gmatch("([^\r\n%s][^%s]*)%s*") do
        if #lines == 0 or #(lines[#lines] .. " " .. line) > limit then
            table.insert(lines, line)
        else
            lines[#lines] = lines[#lines] .. " " .. line
        end
    end
    return lines
end
--[[ processes the loc text for gadgets that follows the typical formatting,
all you have to do is add the 'before' and 'after' in
their relevant places and it *should* just work]]
function processGadgetLocText(first_cond, last_cond)
    local loc_table = {}
    local line_limit = 30

    table.insert(loc_table, "{C:white,X:yellow}Before{}")
    local first_lines = wrapText(first_cond, line_limit)
    for _, line in ipairs(first_lines) do
        table.insert(loc_table, line)
    end

    table.insert(loc_table, "{C:white,X:yellow}After{}")
    local last_lines = wrapText(last_cond, line_limit)
    for _, line in ipairs(last_lines) do
        table.insert(loc_table, line)
    end

    return loc_table
end
