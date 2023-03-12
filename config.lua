Config = {}

Config.img = "qb-inventory/html/images/"
Config.PawnLocation = {
    [1] = {
        coords = vector3(412.34, 314.81, 103.13),
        length = 1.0,
        width = 1.0,
        heading = 207.0,
        debugPoly = false,
        distance = 3.0,
        ped = 'a_f_y_soucent_01',
        enablemelting = false, -- is melting available at this location ?
        items = {
            [1] = {
                item = 'goldchain',
                price = math.random(50,100)
            },
            [2] = {
                item = 'diamond_ring',
                price = math.random(50,100)
            },
            [3] = {
                item = 'rolex',
                price = math.random(50,100)
            },
            [4] = {
                item = '10kgoldchain',
                price = math.random(50,100)
            },
        }
    },
    [2] = {
        coords = vector3(398.76, 316.85, 103.02),
        length = 1.0,
        width = 1.0,
        heading = 164.25,
        debugPoly = false,
        distance = 3.0,
        ped = 'a_m_o_genstreet_01',
        enablemelting = true,
        items = {
            [1] = {
                item = 'tablet',
                price = math.random(50,100)
            },
            [2] = {
                item = 'iphone',
                price = math.random(50,100)
            },
            [3] = {
                item = 'samsungphone',
                price = math.random(50,100)
            },
            [4] = {
                item = 'laptop',
                price = math.random(50,100)
            }
        }
    },
    }

Config.BankMoney = false -- Set to true if you want the money to go into the players bank
Config.UseTimes = false -- Set to false if you want the pawnshop open 24/7
Config.TimeOpen = 7 -- Opening Time
Config.TimeClosed = 17 -- Closing Time
Config.SendMeltingEmail = true -- send email when melting is ready ?

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.MeltingItems = { -- meltTime is amount of time in minutes per item
    [1] = {
        item = 'goldchain',
        rewards = {
            [1] = {
                item = 'goldbar',
                amount = 2
            }
        },
        meltTime = 0.15
    },
    [2] = {
        item = 'diamond_ring',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 1
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            }
        },
        meltTime = 0.15
    },
    [3] = {
        item = 'rolex',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 1
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            },
            [3] = {
                item = 'electronickit',
                amount = 1
            }
        },
        meltTime = 0.15
    },
    [4] = {
        item = '10kgoldchain',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 5
            },
            [2] = {
                item = 'goldbar',
                amount = 1
            }
        },
        meltTime = 0.15
    },
}
