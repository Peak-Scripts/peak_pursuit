if GetResourceState('qbx_core') == 'started' then return end
if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

--- @param source integer
function HasPoliceJob(source)
    if not source then return end

    local player = QBCore.Functions.GetPlayer(source)

    if player.PlayerData.job.name == 'police' then
        return true
    end

    return nil
end
