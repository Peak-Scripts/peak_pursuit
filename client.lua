local config = lib.load('config')
local utils = require 'modules.utils.client'
local mode = 1
local vehMode = config.vehicleModes[1]

local function isPoliceVehicle(vehicle)
    local vehModel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()
    return config.vehicleConfig[vehModel] ~= nil
end

local function getVehicleHandling(vehicle)
    local vehModel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()
    return config.vehicleConfig[vehModel] and config.vehicleConfig[vehModel][vehMode]
end

local function fixVehicleHandling(vehicle)
    SetVehicleModKit(vehicle, 0)
    SetVehicleMod(vehicle, 0, GetVehicleMod(vehicle, 0), false)
    SetVehicleMod(vehicle, 1, GetVehicleMod(vehicle, 1), false)
    SetVehicleMod(vehicle, 2, GetVehicleMod(vehicle, 2), false)
    SetVehicleMod(vehicle, 3, GetVehicleMod(vehicle, 3), false)
    SetVehicleMod(vehicle, 4, GetVehicleMod(vehicle, 4), false)
    SetVehicleMod(vehicle, 5, GetVehicleMod(vehicle, 5), false)
    SetVehicleMod(vehicle, 6, GetVehicleMod(vehicle, 6), false)
    SetVehicleMod(vehicle, 7, GetVehicleMod(vehicle, 7), false)
    SetVehicleMod(vehicle, 8, GetVehicleMod(vehicle, 8), false)
    SetVehicleMod(vehicle, 9, GetVehicleMod(vehicle, 9), false)
    SetVehicleMod(vehicle, 10, GetVehicleMod(vehicle, 10), false)
    SetVehicleMod(vehicle, 11, GetVehicleMod(vehicle, 11), false)
    SetVehicleMod(vehicle, 12, GetVehicleMod(vehicle, 12), false)
    SetVehicleMod(vehicle, 13, GetVehicleMod(vehicle, 13), false)
    SetVehicleMod(vehicle, 15, GetVehicleMod(vehicle, 15), false)
    SetVehicleMod(vehicle, 16, GetVehicleMod(vehicle, 16), false)
    SetVehicleMod(vehicle, 25, GetVehicleMod(vehicle, 25), false)
    SetVehicleMod(vehicle, 27, GetVehicleMod(vehicle, 27), false)
    SetVehicleMod(vehicle, 28, GetVehicleMod(vehicle, 28), false)
    SetVehicleMod(vehicle, 30, GetVehicleMod(vehicle, 30), false)
    SetVehicleMod(vehicle, 33, GetVehicleMod(vehicle, 33), false)
    SetVehicleMod(vehicle, 34, GetVehicleMod(vehicle, 34), false)
    SetVehicleMod(vehicle, 35, GetVehicleMod(vehicle, 35), false)
    SetVehicleWheelIsPowered(vehicle, 0, true)
    SetVehicleWheelIsPowered(vehicle, 1, true)
    SetVehicleWheelIsPowered(vehicle, 2, true)
    SetVehicleWheelIsPowered(vehicle, 3, true)
end

local function setVehHandling(vehicle)
    local handlingConfig = getVehicleHandling(vehicle)

    for key, value in pairs(handlingConfig) do
        if math.type(value) == 'float' then
            SetVehicleHandlingFloat(vehicle, 'CHandlingData', key, value)
        elseif math.type(value) == 'integer' then
            SetVehicleHandlingInt(vehicle, 'CHandlingData', key, value)
        elseif type(value) == 'vector3' then
            SetVehicleHandlingVector(vehicle, 'CHandlingData', key, value)
        end
    end

    fixVehicleHandling(vehicle)
end

local function setVehicleMods(vehicle)
    local modConfig = config.vehicleModifications[vehMode]
    
    local modTypes = {
        engine = 11,
        brakes = 12,
        transmission = 13,
        suspension = 15
    }

    local function checkAndSetMod(vehicle, modType, modValue)
        local maxMods = GetNumVehicleMods(vehicle, modType)
        if modValue > maxMods then
            modValue = maxMods
        end
        SetVehicleMod(vehicle, modType, modValue, false)
    end

    checkAndSetMod(vehicle, modTypes.engine, modConfig.engine)
    checkAndSetMod(vehicle, modTypes.brakes, modConfig.brakes)
    checkAndSetMod(vehicle, modTypes.transmission, modConfig.transmission)
    checkAndSetMod(vehicle, modTypes.suspension, modConfig.suspension)

    ToggleVehicleMod(vehicle, 18, modConfig.turbo)
    ToggleVehicleMod(vehicle, 22, modConfig.xenonHeadlights)
    SetVehicleXenonLightsColour(vehicle, modConfig.xenonHeadlightsColor)
end

local function changeVehicleMode()
    local vehicle = cache.vehicle
    local driverPed = GetPedInVehicleSeat(vehicle, -1)

    if not isPoliceVehicle(vehicle) or not bridge.hasPoliceJob() or not driverPed == cache.ped then return end

    local vehModel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()
    local availableModes = config.vehicleConfig[vehModel]

    local validModes = {}
    for i = 1, #config.vehicleModes do
        local mode = config.vehicleModes[i]
        if availableModes[mode] then
            validModes[#validModes + 1] = mode
        end
    end
    
    if #validModes == 0 then
        utils.notify('No valid modes for this vehicle.', 'error')
        return
    end

    mode = (mode % #validModes) + 1
    vehMode = validModes[mode]
    
    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    TriggerServerEvent('peak_pursuit:server:syncVehicle', netId, vehMode)
end

AddStateBagChangeHandler('peak_pursuit:vehicleMode', nil, function(bagName, _, value)
    local entity = tonumber(bagName:match('entity:(%d+)'))
    local vehicle = NetworkGetEntityFromNetworkId(entity)

    if vehicle and DoesEntityExist(vehicle) and cache.vehicle == vehicle then
        utils.notify(('Pursuit mode changed to %s'):format(value), 'inform') 
        setVehHandling(vehicle)
        setVehicleMods(vehicle)
    end
end)

lib.onCache('vehicle', function(newVehicle)
    if newVehicle and isPoliceVehicle(newVehicle) and bridge.hasPoliceJob() then
        utils.notify(('Last time this vehicle was left on %s pursuit mode'):format(vehMode), 'inform') 
    end
end)

lib.addKeybind({
    name = 'pursuitmode',
    description = 'Change pursuit mode (Police only)',
    defaultKey = config.defaultKey,
    onPressed = changeVehicleMode
})

