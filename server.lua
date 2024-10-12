RegisterNetEvent('peak_pursuit:server:syncVehicle', function(netId, vehMode)
    local source = source
    if not bridge.hasPoliceJob(source) then return end

    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        Entity(vehicle).state:set('peak_pursuit:vehicleMode', vehMode, true)
    end
end)

