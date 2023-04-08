local edits = require("hex-static.edits")

local M = {}

local function is_hexstring(text)
    -- strip white spaces
    local stripped = text:gsub("%s+", "")

    -- check if all remaining characters are hexadeciml digits
    local non_hex_digits = stripped:gsub("%x+", "")
    if #non_hex_digits ~= 0 then
        print("ERROR: text contains non hexadecimal digits '" .. non_hex_digits .. "'")
        return false
    end

    -- check if even number of digits
    if #stripped % 2 ~= 0 then
        print("ERROR: text does not contain an even number of digits (number of digits is '" .. #stripped .. "')")
        return false
    end

    return true
end

local function hexstring_to_c_array(text)
    -- strip  spaces
    local line = text:gsub("%s+", "")

    -- replace pairs of digits 'DD' by '0xDD, ' grouped by 16 bytes
    local bytes = {}
    local byte_count = 0
    local lines_to_insert = {}
    for i = 1, #line, 2 do
        local byte = line:sub(i, i + 1)
        byte_count = byte_count + 1
        table.insert(bytes, "0x" .. byte)
        if byte_count % 16 == 0 then
            local new_line = table.concat(bytes, ", ")
            if i + 1 ~= #line then
                new_line = new_line .. ","
            end
            table.insert(lines_to_insert, new_line)
            bytes = {}
        end
    end

    -- take care of the remaining digits
    if #bytes > 0 then
        table.insert(lines_to_insert, table.concat(bytes, ", "))
    end

    return lines_to_insert
end

function M.hexstring_selection_to_c_array()
    local text = edits.get_selected_text()
    if not is_hexstring(text) then return end
    local lines_to_insert = hexstring_to_c_array(text)
    edits.replace_selection_with(lines_to_insert)
end

function M.hexstring_word_under_cursor_to_c_array()
    local text = edits.get_word_under_cursor()
    if not is_hexstring(text) then return end
    local lines_to_insert = hexstring_to_c_array(text)
    edits.replace_word_under_cursor_with(lines_to_insert)
end

return M
