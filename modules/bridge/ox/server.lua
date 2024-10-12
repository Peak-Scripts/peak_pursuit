local bridge = {}
local Ox = require '@ox_core.lib.init'

--- @param source integer
function bridge.hasPoliceJob(source)
    local player = Ox.GetPlayer(source)
    local groups = player.getGroups()

    for _, group in pairs(groups) do
        if group == 'police' then
            return true
        end
    end

    return nil
end

return bridge