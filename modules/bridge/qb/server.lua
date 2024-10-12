
local bridge = {}
local QBCore = exports['qb-core']:GetCoreObject()

--- @param source integer
function bridge.hasPoliceJob(source)
    local player = QBCore.Functions.GetPlayer(source)

    if player.PlayerData.job.name == 'police' then
        return true
    end

    return nil
end

return bridge