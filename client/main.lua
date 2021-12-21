local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
	local blip = AddBlipForCoord(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z)
	SetBlipSprite(blip, 431)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Pawn Shop")
	EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent('qb-pawnshop:client:openMenu', function()
	if Config.UseTimes then
		if GetClockHours() >= Config.TimeOpen and GetClockHours() <= Config.TimeClosed then
			QBCore.Functions.TriggerCallback('qb-pawnshop:server:getInv', function(inventory)
				local PlyInv = inventory
				local menu = {
					{
						header = "Pawn Shop Menu",
						isMenuHeader = true,
					}
				}
				for k,v in pairs(PlyInv) do
					for i = 1, #Config.PawnItems do
						if v.name == Config.PawnItems[i].item then
							menu[#menu +1] = {
								header = QBCore.Shared.Items[v.name].label,
								txt = "Selling Price: $"..Config.PawnItems[i].price,
								params = {
									event = "qb-pawnshop:client:pawnitemsbasic",
									args = {
										label = QBCore.Shared.Items[v.name].label,
										price = Config.PawnItems[i].price,
										name = v.name,
										amount = v.amount
									}
								}
							}
						end
					end
				end
				exports['qb-menu']:openMenu(menu)
			end)
		else
			QBCore.Functions.Notify("Pawnshop is closed. Come back between "..Config.TimeOpen..":00 AM - "..Config.TimeClosed..':00 PM')
		end
	else
		QBCore.Functions.TriggerCallback('qb-pawnshop:server:getInv', function(hasItems, PlyItems)
			-- Enter all new code here
		end, Config.PawnItems)
		local PlayerData = QBCore.Functions.GetPlayerData()
		local PlyInv = json.decode(PlayerData.inventory)
		local menu = {
			{
				header = "Pawn Shop Menu",
				isMenuHeader = true, -- Set to true to make a nonclickable title
			}
		}
		for k,v in pairs(PlyInv) do
			for i = 1, #Config.PawnItems do
				if v.name == Config.PawnItems[i].item then
					menu[#menu +1] = {
						header = QBCore.Shared.Items[v.name].label,
						txt = "Selling Price: $"..Config.PawnItems[i].price,
						params = {
							event = "qb-pawnshop:client:pawnitemsbasic",
							args = {
								label = QBCore.Shared.Items[v.name].label,
								price = Config.PawnItems[i].price,
								name = v.name,
								amount = v.amount
							}
						}
					}
				end
			end
		end
		exports['qb-menu']:openMenu(menu)
	end
end)

RegisterNetEvent("qb-pawnshop:client:pawnitemsbasic", function(item)
	local sellingItem = exports['qb-input']:ShowInput({
		header = "Pawn Item",
		submitText = "Sell Item",
		inputs = {
			{
				type = 'number',
				isRequired = false,
				name = 'amount',
				text = 'max amount '..item.amount
			}
		}
	})
	if sellingItem then
		if not sellingItem.amount then
			return
		end
		TriggerServerEvent('qb-pawnshop:server:sellPawnItems', item.name, sellingItem.amount, item.price)
	end
end)