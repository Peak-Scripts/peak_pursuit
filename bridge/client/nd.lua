if GetResourceState('ND_Core') ~= 'started' then return end

function HasPoliceJob(source)
    if not source then return end

    local player = exports.ND_Core:getPlayer()
    local playerJob = player.getData('job')
    
    if playerJob == 'police' then
        return true
    end

    return nil
end