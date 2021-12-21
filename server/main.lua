local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("qb-pawnshop:server:sellPawnItems", function(itemName, itemAmount, itemPrice)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalPrice = (itemAmount * itemPrice)

    Player.Functions.RemoveItem(itemName, itemAmount)
    if Config.BankMoney then
        Player.Functions.AddMoney("bank", totalPrice)
    else
        Player.Functions.AddMoney("cash", totalPrice)
    end
    TriggerClientEvent("QBCore:Notify", src, "You have sold "..QBCore.Shared.Items[itemName].label.." for $"..totalPrice, "success"
    )
end)

QBCore.Functions.CreateCallback('qb-pawnshop:server:getInv', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items

    return cb(inventory)
end)