if GetResourceState('qbx_core') ~= 'started' then return end

function HasPoliceJob()
    if exports.qbx_core:HasPrimaryGroup('police') then
        return true
    end

    return nil
end