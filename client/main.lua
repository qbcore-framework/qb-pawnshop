local QBCore = exports['qb-core']:GetCoreObject()

local isMelting = false
local canTake = false
local meltTime
local meltedItem = {}
local ped = {}

CreateThread(function()
    for _, value in pairs(Config.PawnLocation) do
        if value.showblip then
            local blip = AddBlipForCoord(value.coords.x, value.coords.y, value.coords.z)
            SetBlipSprite(blip, 431)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.7)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, 5)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Lang:t('info.title'))
            EndTextCommandSetBlipName(blip)
        end
    end
end)

CreateThread(function()
    if Config.UseTarget then
        for key, value in pairs(Config.PawnLocation) do
            local model = value.ped
            RequestModel(GetHashKey(model))
            while not HasModelLoaded(GetHashKey(model)) do Wait(1) end

            RequestAnimDict("mini@strip_club@idles@bouncer@base")
            while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
                Wait(1)
            end
            ped =  CreatePed(4, model,value.coords.x,value.coords.y,value.coords.z - 1.0, value.heading, false, true)
            SetEntityHeading(ped, value.heading)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)

            exports['qb-target']:AddBoxZone('PawnShop'..key, value.coords, value.length, value.width, {
                name = 'PawnShop'..key,
                heading = value.heading,
                minZ = value.coords.z - 2,
                maxZ = value.coords.z + 2,
                debugPoly = value.debugPoly,
            }, {
                options = {
                    {
                        type = 'client',
                        event = 'qb-pawnshop:client:openMenu',
                        icon = 'fas fa-ring',
                        label = 'Pawn Shop',
                        shopitems = value.items,
                        meltingenabled = value.enablemelting
                    },
                },
                distance = value.distance
            })
        end
    else
        local zone = {}
        for key, value in pairs(Config.PawnLocation) do
            zone[#zone+1] = BoxZone:Create(value.coords, value.length, value.width, {
                name = 'PawnShop'..key,
                heading = value.heading,
                minZ = value.coords.z - 2,
                maxZ = value.coords.z + 2,
                data = {shopitems = value.items, meltingenabled = value.enablemelting}
            })
        end
        local pawnShopCombo = ComboZone:Create( zone, { name = 'NewPawnShopCombo', debugPoly = false })
        pawnShopCombo:onPlayerInOut(function(isPointInside, _, zonedata)
            if isPointInside then
                exports['qb-menu']:showHeader({
                    {
                        header = Lang:t('info.title'),
                        txt = Lang:t('info.open_pawn'),
                        params = {
                            event = 'qb-pawnshop:client:openMenu',
                            args = {shopitems = zonedata.data.shopitems, meltingenabled = zonedata.data.meltingenabled}
                        },
                    }
                })
            else
                exports['qb-menu']:closeMenu()
            end
        end)
    end
end)

RegisterNetEvent('qb-pawnshop:client:openMenu', function(data)
    local shopitems = data.shopitems
    if Config.UseTimes then
        if GetClockHours() >= Config.TimeOpen and GetClockHours() <= Config.TimeClosed then
            local pawnShop = {
                {
                    header = Lang:t('info.title'),
                    isMenuHeader = true,
                },
                {
                    header = Lang:t('info.sell'),
                    txt = Lang:t('info.sell_pawn'),
                    params = {
                        event = 'qb-pawnshop:client:openPawn',
                        args = {
                            items = shopitems
                        }
                    }
                }
            }
            if not isMelting and data.meltingenabled then
                pawnShop[#pawnShop + 1] = {
                    header = Lang:t('info.melt'),
                    txt = Lang:t('info.melt_pawn'),
                    params = {
                        event = 'qb-pawnshop:client:openMelt',
                        args = {
                            items = Config.MeltingItems,
                            shopitems = shopitems,
                            enablemelting = data.meltingenabled
                        }
                    }
                }
            end
            if canTake and data.meltingenabled then
                pawnShop[#pawnShop + 1] = {
                    header = Lang:t('info.melt_pickup'),
                    txt = '',
                    params = {
                        isServer = true,
                        event = 'qb-pawnshop:server:pickupMelted',
                        args = {
                            items = meltedItem
                        }
                    }
                }
            end
            exports['qb-menu']:openMenu(pawnShop)
        else
            QBCore.Functions.Notify(Lang:t('info.pawn_closed', { value = Config.TimeOpen, value2 = Config.TimeClosed }))
        end
    else
        local pawnShop = {
            {
                header = Lang:t('info.title'),
                isMenuHeader = true,
            },
            {
                header = Lang:t('info.sell'),
                txt = Lang:t('info.sell_pawn'),
                params = {
                    event = 'qb-pawnshop:client:openPawn',
                    args = {
                        items = shopitems,
                        enablemelting = data.meltingenabled
                    }
                }
            }
        }
        if not isMelting and data.meltingenabled then
            pawnShop[#pawnShop + 1] = {
                header = Lang:t('info.melt'),
                txt = Lang:t('info.melt_pawn'),
                params = {
                    event = 'qb-pawnshop:client:openMelt',
                    args = {
                        items = Config.MeltingItems,
                        shopitems = shopitems,
                        enablemelting = data.meltingenabled
                    }
                }
            }
        end
        if canTake and data.meltingenabled then
            pawnShop[#pawnShop + 1] = {
                header = Lang:t('info.melt_pickup'),
                txt = '',
                params = {
                    isServer = true,
                    event = 'qb-pawnshop:server:pickupMelted',
                    args = {
                        items = meltedItem
                    }
                }
            }
        end
        exports['qb-menu']:openMenu(pawnShop)
    end
end)

RegisterNetEvent('qb-pawnshop:client:openPawn', function(data)
    local shopitems = data.items
    local pawnMenu = {
        {
            header = Lang:t('info.title'),
            isMenuHeader = true,
        }
    }

    for _, v in pairs(shopitems) do
        local hasitem = QBCore.Functions.HasItem(v.item)
        if hasitem then
            pawnMenu[#pawnMenu + 1] = {
                header = QBCore.Shared.Items[v.item].label,
                txt = Lang:t('info.sell_items', { value = v.price }),
                params = {
                    event = 'qb-pawnshop:client:pawnitems',
                    args = {
                        label = QBCore.Shared.Items[v.item].label,
                        price = v.price,
                        name = v.item,
                    }
                }
            }
        else
            if Config.ShowNotOwnedItems then
                pawnMenu[#pawnMenu + 1] = {
                    header = QBCore.Shared.Items[v.item].label,
                    txt = Lang:t('info.sell_items', { value = v.price }),
                    disabled = true,
                }
            end
        end
    end

    pawnMenu[#pawnMenu + 1] = {
        header = Lang:t('info.back'),
        params = {
            event = 'qb-pawnshop:client:openMenu',
            args = {shopitems = shopitems, meltingenabled = data.enablemelting}
        }
    }
    exports['qb-menu']:openMenu(pawnMenu)
end)

RegisterNetEvent('qb-pawnshop:client:openMelt', function(data)
    QBCore.Functions.TriggerCallback('qb-pawnshop:server:getInv', function(inventory)
        local PlyInv = inventory
        local meltMenu = {
            {
                header = Lang:t('info.melt'),
                isMenuHeader = true,
            }
        }
        for _, v in pairs(PlyInv) do
            for i = 1, #data.items do
                if v.name == data.items[i].item then
                    meltMenu[#meltMenu + 1] = {
                        header = QBCore.Shared.Items[v.name].label,
                        txt = Lang:t('info.melt_item', { value = QBCore.Shared.Items[v.name].label }),
                        params = {
                            event = 'qb-pawnshop:client:meltItems',
                            args = {
                                label = QBCore.Shared.Items[v.name].label,
                                reward = data.items[i].rewards,
                                name = v.name,
                                amount = v.amount,
                                time = data.items[i].meltTime
                            }
                        }
                    }
                end
            end
        end
        meltMenu[#meltMenu + 1] = {
            header = Lang:t('info.back'),
            params = {
                event = 'qb-pawnshop:client:openMenu',
                args = {shopitems = data.shopitems, meltingenabled = data.enablemelting}
            }
        }
        exports['qb-menu']:openMenu(meltMenu)
    end)
end)

RegisterNetEvent('qb-pawnshop:client:pawnitems', function(data)
    QBCore.Functions.TriggerCallback('qb-pawnshop:server:ItemAmount', function(amount)
        local sellingItem = exports['qb-input']:ShowInput({
            header = "<center><p><img src=nui://"..Config.img..QBCore.Shared.Items[data.name].image.." width=100px></p>"..QBCore.Shared.Items[data.name].label,
            submitText = Lang:t('info.sell'),
            inputs = {
                {
                    type = 'number',
                    isRequired = true,
                    name = 'amount',
                    text = Lang:t('info.max', { value = amount })
                }
            }
        })
        if sellingItem then
            if not sellingItem.amount then
                return
            end

            if tonumber(sellingItem.amount) > 0 then
                TriggerServerEvent('qb-pawnshop:server:sellPawnItems', data.name, sellingItem.amount, data.price)
            else
                QBCore.Functions.Notify(Lang:t('error.negative'), 'error')
            end
        end
    end, data.name)
end)

RegisterNetEvent('qb-pawnshop:client:meltItems', function(item)
    local meltingItem = exports['qb-input']:ShowInput({
        header = Lang:t('info.melt'),
        submitText = Lang:t('info.submit'),
        inputs = {
            {
                type = 'number',
                isRequired = false,
                name = 'amount',
                text = Lang:t('info.max', { value = item.amount })
            }
        }
    })
    if meltingItem then
        if not meltingItem.amount then
            return
        end
        if meltingItem.amount ~= nil then
            if tonumber(meltingItem.amount) > 0 then
                TriggerServerEvent('qb-pawnshop:server:meltItemRemove', item.name, meltingItem.amount, item)

            else
                QBCore.Functions.Notify(Lang:t('error.no_melt'), 'error')
            end
        else
            QBCore.Functions.Notify(Lang:t('error.no_melt'), 'error')
        end
    end
end)

RegisterNetEvent('qb-pawnshop:client:startMelting', function(item, meltingAmount, meltTimees)
    if not isMelting then
        isMelting = true
        meltTime = meltTimees
        meltedItem = {}
        CreateThread(function()
            while isMelting do
                if LocalPlayer.state.isLoggedIn then
                    meltTime = meltTime - 1
                    if meltTime <= 0 then
                        canTake = true
                        isMelting = false
                        table.insert(meltedItem, { item = item, amount = meltingAmount })
                        if Config.SendMeltingEmail then
                            TriggerServerEvent('qb-phone:server:sendNewMail', {
                                sender = Lang:t('info.title'),
                                subject = Lang:t('info.subject'),
                                message = Lang:t('info.message'),
                                button = {}
                            })
                        else
                            QBCore.Functions.Notify(Lang:t('info.message'), 'success')
                        end
                    end
                else
                    break
                end
                Wait(1000)
            end
        end)
    end
end)

RegisterNetEvent('qb-pawnshop:client:resetPickup', function()
    canTake = false
end)
