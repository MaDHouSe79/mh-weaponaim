--[[ ===================================================== ]] --
--[[            MH Weapon Aim Script by MaDHouSe           ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local isLoggedIn = false
local radialmenu = nil
local aimStyle = 0
local action = 50
local aimgang = nil
local GangAimVariation = {'aim_variation_a', 'aim_variation_b', 'aim_variation_c', 'aim_variation_d', 'aim_variation_e'}
local aimbilly = nil
local HillbillyAimVariation = {'aim_variation_a', 'aim_variation_b', 'aim_variation_c', 'aim_variation_d', 'aim_variation_e', 'aim_variation_f'}

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('mh-weaponaim:server:onjoin')
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerData = QBCore.Functions.GetPlayerData()
        TriggerServerEvent('mh-weaponaim:server:onjoin')
        isLoggedIn = true
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        PlayerData = {}
        isLoggedIn = false
    end
end)

RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    if radialmenu ~= nil then
        exports['qb-radialmenu']:RemoveOption(radialmenu)
        radialmenu = nil
    end
    if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' then
        radialmenu = exports['qb-radialmenu']:AddOption({
            id = 'weaponaim',
            title = "Weapon Aim",
            icon = 'gun',
            items = {{
                id = 'defaultaim',
                title = "Default Aim",
                icon = "crosshairs",
                type = 'client',
                event = "mh-weaponaim:client:defaultaim",
                shouldClose = true
            }, {
                id = 'hillbilly000',
                title = "Hillbilly Aim",
                icon = "crosshairs",
                items = {{
                    id = 'hillbilly001',
                    title = "Aiming 1",
                    icon = "crosshairs",
                    type = 'client',
                    event = "mh-weaponaim:client:hillbillyaima",
                    shouldClose = true
                }, {
                    id = 'hillbilly002',
                    title = "Aiming 2",
                    icon = "crosshairs",
                    type = 'client',
                    event = "mh-weaponaim:client:hillbillyaimb",
                    shouldClose = true
                }, {
                    id = 'hillbilly003',
                    title = "Aiming 3",
                    icon = "crosshairs",
                    type = 'client',
                    event = "mh-weaponaim:client:hillbillyaimc",
                    shouldClose = true
                }, {
                    id = 'hillbilly004',
                    title = "Aiming 4",
                    icon = "crosshairs",
                    type = 'client',
                    event = "mh-weaponaim:client:hillbillyaimd",
                    shouldClose = true
                }, {
                    id = 'hillbilly005',
                    title = "Aiming 5",
                    icon = "crosshairs",
                    type = 'client',
                    event = "mh-weaponaim:client:hillbillyaime",
                    shouldClose = true
                }, {
                    id = 'hillbilly006',
                    title = "Aiming 6",
                    icon = "crosshairs",
                    type = 'client',
                    event = "mh-weaponaim:client:hillbillyaimf",
                    shouldClose = true
                }}
            }, {
                id = 'gang000',
                title = "Gang Aim",
                icon = "crosshairs",
                items = {{
                    id = 'gang001',
                    title = "Aiming 1",
                    icon = "crosshairs",
                    type = 'client',
                    event = "mh-weaponaim:client:gangaima",
                    shouldClose = true
                }, {
                    id = 'gang002',
                    title = "Aiming 2",
                    icon = "crosshairs",
                    type = 'client',
                    event = "mh-weaponaim:client:gangaimb",
                    shouldClose = true
                }, {
                    id = 'gang003',
                    title = "Aiming 3",
                    icon = "crosshairs",
                    type = 'client',
                    event = "mh-weaponaim:client:gangaimc",
                    shouldClose = true
                }, {
                    id = 'gang004',
                    title = "Aiming 4",
                    icon = "crosshairs",
                    type = 'client',
                    event = "mh-weaponaim:client:gangaimd",
                    shouldClose = true
                }, {
                    id = 'gang005',
                    title = "Aiming 5",
                    icon = "crosshairs",
                    type = 'client',
                    event = "mh-weaponaim:client:gangaime",
                    shouldClose = true
                }}
            }}
        }, radialmenu)
    end
end)

RegisterNetEvent('mh-weaponaim:client:updateaim', function(style, aim)
    aimStyle = style
    if style == 1 then
        aimbilly = aim
    elseif style == 2 then
        aimgang = aim
    end
end)

RegisterNetEvent('mh-weaponaim:client:defaultaim', function()
    aimStyle = 0
end)

RegisterNetEvent('mh-weaponaim:client:hillbillyaima', function()
    aimStyle = 1
    aimbilly = HillbillyAimVariation[1]
    TriggerServerEvent('mh-weaponaim:server:update', aimStyle, aimbilly)
end)

RegisterNetEvent('mh-weaponaim:client:hillbillyaimb', function()
    aimStyle = 1
    aimbilly = HillbillyAimVariation[2]
    TriggerServerEvent('mh-weaponaim:server:update', aimStyle, aimbilly)
end)
RegisterNetEvent('mh-weaponaim:client:hillbillyaimc', function()
    aimStyle = 1
    aimbilly = HillbillyAimVariation[3]
    TriggerServerEvent('mh-weaponaim:server:update', aimStyle, aimbilly)
end)

RegisterNetEvent('mh-weaponaim:client:hillbillyaimd', function()
    aimStyle = 1
    aimbilly = HillbillyAimVariation[4]
    TriggerServerEvent('mh-weaponaim:server:update', aimStyle, aimbilly)
end)

RegisterNetEvent('mh-weaponaim:client:hillbillyaime', function()
    aimStyle = 1
    aimbilly = HillbillyAimVariation[5]
    TriggerServerEvent('mh-weaponaim:server:update', aimStyle, aimbilly)
end)

RegisterNetEvent('mh-weaponaim:client:hillbillyaimf', function()
    aimStyle = 1
    aimbilly = HillbillyAimVariation[6]
    TriggerServerEvent('mh-weaponaim:server:update', aimStyle, aimbilly)
end)

RegisterNetEvent('mh-weaponaim:client:gangaima', function()
    aimStyle = 2
    aimgang = GangAimVariation[1]
    TriggerServerEvent('mh-weaponaim:server:update', aimStyle, aimgang)
end)

RegisterNetEvent('mh-weaponaim:client:gangaimb', function()
    aimStyle = 2
    aimgang = GangAimVariation[2]
    TriggerServerEvent('mh-weaponaim:server:update', aimStyle, aimgang)
end)

RegisterNetEvent('mh-weaponaim:client:gangaimc', function()
    aimStyle = 2
    aimgang = GangAimVariation[3]
    TriggerServerEvent('mh-weaponaim:server:update', aimStyle, aimgang)
end)

RegisterNetEvent('mh-weaponaim:client:gangaimd', function()
    aimStyle = 2
    aimgang = GangAimVariation[4]
    TriggerServerEvent('mh-weaponaim:server:update', aimStyle, aimgang)
end)

RegisterNetEvent('mh-weaponaim:client:gangaime', function()
    aimStyle = 2
    aimgang = GangAimVariation[5]
    TriggerServerEvent('mh-weaponaim:server:update', aimStyle, aimgang)
end)

CreateThread(function()
    while true do
        if isLoggedIn then
            local inVeh = IsPedInVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), false)
            local _, hash = GetCurrentPedWeapon(PlayerPedId(), 1)
            if not inVeh then
                if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' then
                    if aimStyle == 1 then
                        loadAnimDict("combat@aim_variations@1h@hillbilly")
                        if IsPlayerFreeAiming(PlayerId()) or (IsControlPressed(0, 24) and GetAmmoInClip(PlayerPedId(), hash) > 0) then
                            if not IsEntityPlayingAnim(PlayerPedId(), "combat@aim_variations@1h@hillbilly", aimbilly, 3) then
                                TaskPlayAnim(PlayerPedId(), "combat@aim_variations@1h@hillbilly", aimbilly, 8.0, -8.0, -1, 49, 0, 0, 0, 0)
                                SetEnableHandcuffs(PlayerPedId(), true)
                            end
                        elseif IsEntityPlayingAnim(PlayerPedId(), "combat@aim_variations@1h@hillbilly", aimbilly, 3) then
                            ClearPedTasks(PlayerPedId())
                            SetEnableHandcuffs(PlayerPedId(), false)
                        end
                    elseif aimStyle == 2 then
                        loadAnimDict("combat@aim_variations@1h@gang")
                        if IsPlayerFreeAiming(PlayerId()) or (IsControlPressed(0, 24) and GetAmmoInClip(Player, hash) > 0) then
                            if not IsEntityPlayingAnim(PlayerPedId(), "combat@aim_variations@1h@gang", aimgang, 3) then
                                TaskPlayAnim(PlayerPedId(), "combat@aim_variations@1h@gang", aimgang, 8.0, -8.0, -1, 49, 0, 0, 0, 0)
                                SetEnableHandcuffs(PlayerPedId(), true)
                            end
                        elseif IsEntityPlayingAnim(PlayerPedId(), "combat@aim_variations@1h@gang", aimgang, 3) then
                            ClearPedTasks(PlayerPedId())
                            SetEnableHandcuffs(PlayerPedId(), false)
                        end
                        Citizen.Wait(50)
                    end
                end
            end
        end
        Citizen.Wait(80)
    end
end)
