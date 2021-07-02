isLoggedIn = false

local sellItemsSet = false
local sellPrice = 0
local sellHardwareItemsSet = false
local sellHardwarePrice = 0
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z)
	SetBlipSprite(blip, 431)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("F.T. Pawn")
	EndTextCommandSetBlipName(blip)
	while true do 
		Citizen.Wait(1)
		local inRange = false
		local pos = GetEntityCoords(PlayerPedId())
		if #(pos - Config.PawnLocation) < 5.0 then
			inRange = true
			if #(pos - Config.PawnLocation) < 1.5 then
				if GetClockHours() >= 7 and GetClockHours() <= 17 then
					if not sellItemsSet then 
						sellPrice = GetSellingPrice()
						sellItemsSet = true
					elseif sellItemsSet and sellPrice ~= 0 then
						DrawText3D(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z, "~g~E~w~ - Sell Watches/ Necklaces / Rings ($"..sellPrice..")")
						if IsControlJustReleased(0, 38) then
							TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
                            QBCore.Functions.Progressbar("sell_pawn_items", "Selling Items", math.random(15000, 25000), false, true, {}, {}, {}, {}, function() -- Done
                                ClearPedTasks(PlayerPedId())
								TriggerServerEvent("qb-pawnshop:server:sellPawnItems")
								sellItemsSet = false
								sellPrice = 0
                            end, function() -- Cancel
								ClearPedTasks(PlayerPedId())
								QBCore.Functions.Notify("Canceled..", "error")
							end)
						end
					else
						DrawText3D(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z, "Pawnshop: You have nothing to sell")
					end
				else
					DrawText3D(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z, "Pawnshop is closed, opens from ~r~7:00")
				end
			end
		end
		if not inRange then
			sellPrice = 0
			sellItemsSet = false
			Citizen.Wait(2500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local inRange = false
		local pos = GetEntityCoords(PlayerPedId())
		if #(pos - Config.PawnHardwareLocation) < 5.0 then
			inRange = true
			if #(pos - Config.PawnHardwareLocation) < 1.5 then
				if GetClockHours() >= 9 and GetClockHours() <= 16 then
					if not sellHardwareItemsSet then 
						sellHardwarePrice = GetSellingHardwarePrice()
						sellHardwareItemsSet = true
					elseif sellHardwareItemsSet and sellHardwarePrice ~= 0 then
						DrawText3D(Config.PawnHardwareLocation.x, Config.PawnHardwareLocation.y, Config.PawnHardwareLocation.z, "~g~E~w~ - Sale iPhones/Samsung S10s/Tablets/Laptops ($"..sellHardwarePrice..")")
						if IsControlJustReleased(0, 38) then
							TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
                            QBCore.Functions.Progressbar("sell_pawn_items", "Sell things", math.random(15000, 25000), false, true, {}, {}, {}, {}, function() -- Done
                                ClearPedTasks(PlayerPedId())
								TriggerServerEvent("qb-pawnshop:server:sellHardwarePawnItems")
								sellHardwareItemsSet = false
								sellHardwarePrice = 0
                            end, function() -- Cancel
								ClearPedTasks(PlayerPedId())
								QBCore.Functions.Notify("Canceled", "error")
							end)
						end
					else
						DrawText3D(Config.PawnHardwareLocation.x, Config.PawnHardwareLocation.y, Config.PawnHardwareLocation.z, "Pawnshop: You have nothing to sell")
					end
				else
					DrawText3D(Config.PawnHardwareLocation.x, Config.PawnHardwareLocation.y, Config.PawnHardwareLocation.z, "Pawnshop closed, open from ~r~9:00")
				end
			end
		end
		if not inRange then
			sellHardwarePrice = 0
			sellHardwareItemsSet = false
			Citizen.Wait(2500)
		end
	end
end)

function GetSellingPrice()
	local price = 0
	QBCore.Functions.TriggerCallback('qb-pawnshop:server:getSellPrice', function(result)
		price = result
	end)
	Citizen.Wait(500)
	return price
end

function GetSellingHardwarePrice()
	local price = 0
	QBCore.Functions.TriggerCallback('qb-pawnshop:server:getSellHardwarePrice', function(result)
		price = result
	end)
	Citizen.Wait(500)
	return price
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end