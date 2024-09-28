if GetResourceState('qbx_core') ~= 'started' then return end

--- @param source integer
function HasPoliceJob(source)
    if not source then return end

    if exports.qbx_core:HasPrimaryGroup(source, 'police') then
        return true
    end

    return nil
end