local bridge = {}

function bridge.hasPoliceJob()
    local player = exports.ND_Core:getPlayer()
    local playerJob = player.getData('job')
    
    if playerJob == 'police' then
        return true
    end

    return nil
end

return bridge