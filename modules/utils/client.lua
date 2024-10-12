local utils = {}

--- @param message string
--- @param type string
function utils.notify(message, type)
    lib.notify({ 
        description = message, 
        type = type 
    })
end

return utils