local bridge = {}
local QBCore = exports['qb-core']:GetCoreObject()

function bridge.hasPoliceJob()
    local playerData = QBCore.Functions.GetPlayerData()

    if playerData.job.name == 'police' then
        return true
    end

    return nil
end

return bridge