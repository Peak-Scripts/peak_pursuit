local bridge = {}

--- @param source integer
function bridge.hasPoliceJob(source)
    local player = exports.ND_Core:getPlayer(source)
    local playerJob = player.getData('job')
    
    if playerJob == 'police' then
        return true
    end

    return nil
end

return bridge