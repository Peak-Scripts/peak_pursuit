local bridge = {}

local ESX = exports.es_extended:getSharedObject()

function bridge.hasPoliceJob()
    local playerData = ESX.GetPlayerData()
    local playerJob = playerData.job.name

    if playerJob == 'police' then
        return true
    end

    return nil
end

return bridge