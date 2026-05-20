local QBCore = exports['qb-core']:GetCoreObject({ 'Functions' })
local sharedItems = exports['qb-core']:GetShared('Items')

local function exploitBan(id, reason)
    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)',
        {
            GetPlayerName(id),
            QBCore.Functions.GetIdentifier(id, 'license'),
            QBCore.Functions.GetIdentifier(id, 'discord'),
            QBCore.Functions.GetIdentifier(id, 'ip'),
            reason,
            2147483647,
            'qb-pawnshop'
        })
    TriggerEvent('qb-log:server:CreateLog', 'pawnshop', 'Player Banned', 'red',
        string.format('%s was banned by %s for %s', GetPlayerName(id), 'qb-pawnshop', reason), true)
    DropPlayer(id, 'You were permanently banned by the server for: Exploiting')
end

RegisterNetEvent('qb-pawnshop:server:sellPawnItems', function(itemName, itemAmount, itemPrice)
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    local totalPrice = (tonumber(itemAmount) * itemPrice)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local dist
    for _, value in pairs(Config.PawnLocation) do
        dist = #(playerCoords - value.coords)
        if #(playerCoords - value.coords) < 2 then
            dist = #(playerCoords - value.coords)
            break
        end
    end
    if dist > 5 then
        exploitBan(src, 'sellPawnItems Exploiting')
        return
    end
    if exports['qb-inventory']:RemoveItem(src, itemName, tonumber(itemAmount), false, 'qb-pawnshop:server:sellPawnItems') then
        if Config.BankMoney then
            Player.AddMoney('bank', totalPrice, 'qb-pawnshop:server:sellPawnItems')
        else
            Player.AddMoney('cash', totalPrice, 'qb-pawnshop:server:sellPawnItems')
        end
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.sold', { value = tonumber(itemAmount), value2 = sharedItems[itemName].label, value3 = totalPrice }), 'success')
        TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems[itemName], 'remove')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_items'), 'error')
    end
    TriggerClientEvent('qb-pawnshop:client:openMenu', src)
end)

RegisterNetEvent('qb-pawnshop:server:meltItemRemove', function(itemName, itemAmount, item)
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    if exports['qb-inventory']:RemoveItem(src, itemName, itemAmount, false, 'qb-pawnshop:server:meltItemRemove') then
        TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems[itemName], 'remove')
        local meltTime = (tonumber(itemAmount) * item.time)
        TriggerClientEvent('qb-pawnshop:client:startMelting', src, item, tonumber(itemAmount), (meltTime * 60000 / 1000))
        TriggerClientEvent('QBCore:Notify', src, Lang:t('info.melt_wait', { value = meltTime }), 'primary')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_items'), 'error')
    end
end)

RegisterNetEvent('qb-pawnshop:server:pickupMelted', function(item)
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local dist
    for _, value in pairs(Config.PawnLocation) do
        dist = #(playerCoords - value.coords)
        if #(playerCoords - value.coords) < 2 then
            dist = #(playerCoords - value.coords)
            break
        end
    end
    if dist > 5 then
        exploitBan(src, 'pickupMelted Exploiting')
        return
    end
    for _, v in pairs(item.items) do
        local meltedAmount = v.amount
        for _, m in pairs(v.item.reward) do
            local rewardAmount = m.amount
            if exports['qb-inventory']:AddItem(src, m.item, (meltedAmount * rewardAmount), false, false, 'qb-pawnshop:server:pickupMelted') then
                TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems[m.item], 'add')
                TriggerClientEvent('QBCore:Notify', src, Lang:t('success.items_received', { value = (meltedAmount * rewardAmount), value2 = sharedItems[m.item].label }), 'success')
                TriggerClientEvent('qb-pawnshop:client:resetPickup', src)
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t('error.inventory_full', { value = sharedItems[m.item].label }), 'warning', 7500)
            end
        end
    end
    TriggerClientEvent('qb-pawnshop:client:openMenu', src)
end)

QBCore.Functions.CreateCallback('qb-pawnshop:server:getInv', function(source, cb)
    local Player = exports['qb-core']:GetPlayer(source)
    local inventory = Player.PlayerData.items
    return cb(inventory)
end)
