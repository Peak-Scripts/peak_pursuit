if GetResourceState('es_extended') ~= 'started' then return end

local ESX = exports['es_extended']:getSharedObject()

--- @param source integer
function HasPoliceJob(source)
    if not source then return end
    
    local playerData = ESX.GetPlayerData()
    local playerJob = playerData.job.name

    if playerJob == 'police' then
        return true
    end

    return nil
end