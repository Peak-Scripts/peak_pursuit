local bridge = {}

function bridge.hasPoliceJob()
    if exports.qbx_core:HasPrimaryGroup('police') then
        return true
    end

    return nil
end

return bridge