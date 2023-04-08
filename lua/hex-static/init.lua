local M = {}

local function hexstring_to_c_arrray(args)
    local hexstr = require("hex-static.hexstr")
    local edits = require("hex-static.edits")
    local text = nil
    local range = nil

    if args.range == 0 then
        text = edits.get_word_under_cursor()
        range = edits.get_word_under_cursor_range()
    elseif args.range == 2 then
        text = edits.get_selected_text()
        range = edits.get_selected_range()
    end
    if not hexstr.is_hexstring(text) then
        return
    end
    edits.replace_range_with(range, hexstr.to_c_array(text))
end

function M.setup(_)
    vim.api.nvim_create_user_command("HexStringToCArray", hexstring_to_c_arrray, {
        range = true,
        desc = "hex-static.nvim: converts hex string to C style array.",
    })
end

return M
