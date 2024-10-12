local bridge = {}

--- @param source integer
function bridge.hasPoliceJob(source)
    if exports.qbx_core:HasPrimaryGroup(source, 'police') then
        return true
    end

    return nil
end

return bridge