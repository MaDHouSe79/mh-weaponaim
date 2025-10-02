--[[ ===================================================== ]] --
--[[            MH Weapon Aim Script by MaDHouSe           ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('mh-weaponaim:server:update', function(style, aim)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local citizenid = Player.PlayerData.citizenid
        local result = MySQL.Sync.fetchAll('SELECT * FROM player_weapon_aim WHERE citizenid = ?', {citizenid})
        if result[1] == nil then
            MySQL.Async.execute("INSERT INTO player_weapon_aim (citizenid, style, aim) VALUES (?, ?, ?)", {citizenid, style, aim})
        elseif result[1] then
            MySQL.Async.execute('UPDATE player_weapon_aim SET style = ?, aim = ? WHERE citizenid = ?', {style, aim, citizenid})
        end
    end
end)

RegisterServerEvent('mh-weaponaim:server:onjoin', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.Async.fetchAll("SELECT * FROM player_weapon_aim WHERE citizenid = ?", {Player.PlayerData.citizenid}, function(rs)
        if type(rs) == 'table' and #rs > 0 then
            if rs[1] and rs[1].style ~= nil and rs[1].aim ~= nil then
                TriggerClientEvent('mh-weaponaim:client:updateaim', src, rs[1].style, rs[1].aim)
            end
        end
    end)    
end)