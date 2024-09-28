if GetResourceState('es_extended') ~= 'started' then return end

local ESX = exports['es_extended']:getSharedObject()

function HasPoliceJob()
    local playerData = ESX.GetPlayerData()
    local playerJob = playerData.job.name

    if playerJob == 'police' then
        return true
    end

    return nil
end