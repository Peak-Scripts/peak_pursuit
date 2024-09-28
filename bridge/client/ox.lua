if GetResourceState('ox_core') ~= 'started' then return end

Ox = require '@ox_core.lib.init'

function HasPoliceJob()
    local player = Ox.GetPlayer()
    local groups = player.getGroups()

    for _, group in pairs(groups) do
        if group == 'police' then
            return true
        end
    end

    return nil
end