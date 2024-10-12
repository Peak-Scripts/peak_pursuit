local bridge = {}
local Ox = require '@ox_core.lib.init'

function bridge.hasPoliceJob()
    local player = Ox.GetPlayer()
    local groups = player.getGroups()

    for _, group in pairs(groups) do
        if group == 'police' then
            return true
        end
    end

    return nil
end

return bridge