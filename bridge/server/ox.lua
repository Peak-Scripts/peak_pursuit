if GetResourceState('ox_core') ~= 'started' then return end

Ox = require '@ox_core.lib.init'

--- @param source integer
function HasPoliceJob(source)
    if not source then return end
    
    local player = Ox.GetPlayer(source)
    local groups = player.getGroups()

    for _, group in pairs(groups) do
        if group == 'police' then
            return true
        end
    end

    return nil
end