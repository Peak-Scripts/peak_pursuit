RegisterNetEvent('peak_pursuitmode:server:syncVehicle', function(netId, vehMode)
    local source = source
    if not HasPoliceJob(source) then return end

    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        Entity(vehicle).state:set('peak_pursuitmode:vehicleMode', vehMode, true)
    end
end)

