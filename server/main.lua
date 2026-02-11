local QBCore = exports['qb-core']:GetCoreObject()

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
    local Player = QBCore.Functions.GetPlayer(src)
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
            Player.Functions.AddMoney('bank', totalPrice, 'qb-pawnshop:server:sellPawnItems')
        else
            Player.Functions.AddMoney('cash', totalPrice, 'qb-pawnshop:server:sellPawnItems')
        end
        TriggerClientEvent('QBCore:Notify', src, Lang:t('success.sold', { value = tonumber(itemAmount), value2 = QBCore.Shared.Items[itemName].label, value3 = totalPrice }), 'success')
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_items'), 'error')
    end
    TriggerClientEvent('qb-pawnshop:client:openMenu', src)
end)

RegisterNetEvent('qb-pawnshop:server:meltItemRemove', function(itemName, itemAmount, item)
    local src = source
    if exports['qb-inventory']:RemoveItem(src, itemName, itemAmount, false, 'qb-pawnshop:server:meltItemRemove') then
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
        local meltTime = (tonumber(itemAmount) * item.time)
        TriggerClientEvent('qb-pawnshop:client:startMelting', src, item, tonumber(itemAmount), (meltTime * 60000 / 1000))
        TriggerClientEvent('QBCore:Notify', src, Lang:t('info.melt_wait', { value = meltTime }), 'primary')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_items'), 'error')
    end
end)

RegisterNetEvent('qb-pawnshop:server:pickupMelted', function(item)
    local src = source
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
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[m.item], 'add')
                TriggerClientEvent('QBCore:Notify', src, Lang:t('success.items_received', { value = (meltedAmount * rewardAmount), value2 = QBCore.Shared.Items[m.item].label }), 'success')
                TriggerClientEvent('qb-pawnshop:client:resetPickup', src)
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t('error.inventory_full', { value = QBCore.Shared.Items[m.item].label }), 'warning', 7500)
            end
        end
    end
    TriggerClientEvent('qb-pawnshop:client:openMenu', src)
end)

QBCore.Functions.CreateCallback('qb-pawnshop:server:getInv', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items
    return cb(inventory)
end)

RegisterNetEvent('qb-pawnshop:server:sellAllPawnItems', function(items, total)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
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
        exploitBan(src, 'sellAllPawnItems Exploiting')
        return
    end
    local removedCount = 0
    for _, item in pairs(items) do
        local removed
        if item.slot then
            removed = exports['qb-inventory']:RemoveItem(src, item.name, item.amount, item.slot, 'qb-pawnshop:server:sellAllPawnItems')
        else
            removed = exports['qb-inventory']:RemoveItem(src, item.name, item.amount, false, 'qb-pawnshop:server:sellAllPawnItems')
        end
        if removed then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], 'remove')
            removedCount = removedCount + 1
        end
    end
    if removedCount > 0 then
        if Config.BankMoney then
            Player.Functions.AddMoney('bank', total, 'qb-pawnshop:server:sellAllPawnItems')
        else
            Player.Functions.AddMoney('cash', total, 'qb-pawnshop:server:sellAllPawnItems')
        end
        TriggerClientEvent('QBCore:Notify', src, 'You received $' .. total .. ' for all pawnable items.', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'No items could be sold.', 'error')
    end
    TriggerClientEvent('qb-pawnshop:client:openMenu', src)
end)
