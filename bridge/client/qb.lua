if GetResourceState('qbx_core') == 'started' then return end
if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

function HasPoliceJob()
    local playerData = QBCore.Functions.GetPlayerData()

    if playerData.job.name == 'police' then
        return true
    end

    return nil
end
