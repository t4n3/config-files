local M = {}

-- Captures user's next keypress.
-- If keypress is a number the given callback will be called with that number
-- Else the keypress is ignored
function M.capture_number(callback)
    local char = string.char(vim.fn.getchar())

    if tonumber(char) then
        callback(tonumber(char))
    end
end

return M
