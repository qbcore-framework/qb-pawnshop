local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("qb-pawnshop:server:sellPawnItems", function(itemName, itemAmount, itemPrice)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalPrice = (itemAmount * itemPrice)

    if Player.Functions.RemoveItem(itemName, itemAmount) then
        if Config.BankMoney then
            Player.Functions.AddMoney("bank", totalPrice)
        else
            Player.Functions.AddMoney("cash", totalPrice)
        end
        TriggerClientEvent("QBCore:Notify", src, "You have sold for $"..totalPrice, "success")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
     TriggerClientEvent("QBCore:Notify", src, "ERROR! Not enough items maybe?", "error")
    end
    
end)

RegisterNetEvent("qb-pawnshop:server:meltItemRemove", function(itemName, itemAmount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveItem(itemName, itemAmount) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
        TriggerClientEvent("QBCore:Notify", src, "ERROR! Not enough items maybe?", "error")
    end

end)

RegisterNetEvent("qb-pawnshop:server:pickupMelted", function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local meltedAmount = 0
    for k,v in pairs(item.items) do
        meltedAmount = v.amount
        for l,m in pairs(v.item.reward) do
            Player.Functions.AddItem(m.item, (meltedAmount * m.amount))
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[m.item], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You received '..(meltedAmount * m.amount).. ' x '..QBCore.Shared.Items[m.item].label, 'success')
        end
    end
    TriggerClientEvent('qb-pawnshop:client:resetPickup', src)
end)

QBCore.Functions.CreateCallback('qb-pawnshop:server:getInv', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items

    return cb(inventory)
end)