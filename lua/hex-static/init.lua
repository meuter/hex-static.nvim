local M = {}

local function hexstring_to_c_arrray(args)
    local hexconvert = require("hex-static.hexconvert")
    if args.range == 0 then
        hexconvert.hexstring_current_line_to_c_array()
    elseif args.range == 2 then
        hexconvert.hexstring_selection_to_c_array()
    end
end

function M.setup(_)
    vim.api.nvim_create_user_command("HexStringToCArray", hexstring_to_c_arrray, {
        range = true,
        desc = "hex-static.nvim: converts hex string to C style array.",
    })
end

return M
