local bridge = {}

local ESX = exports.es_extended:getSharedObject()

--- @param source integer
function bridge.hasPoliceJob(source)
    local playerData = ESX.GetPlayerData(source)
    local playerJob = playerData.job.name

    if playerJob == 'police' then
        return true
    end

    return nil
end

return bridge