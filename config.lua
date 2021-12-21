Config = {}

Config.PawnLocation = vector3(412.34, 314.81, 103.13)
Config.BankMoney = false -- Set to true if you want the money to go into the players bank
Config.UseTimes = true
Config.TimeOpen = 7
Config.TimeClosed = 17

Config.PawnItems = {
    [1] = {
        item = "goldchain",
        price = math.random(50,100)
    },
    [2] = {
        item = "diamond_ring",
        price = math.random(50,100)
    },
    [3] = {
        item = "rolex",
        price = math.random(50,100)
    },
    [4] = {
        item = "10kgoldchain",
        price = math.random(50,100)
    },
    [5] = {
        item = "tablet",
        price = math.random(50,100)
    }
    ,
    [6] = {
        item = "iphone",
        price = math.random(50,100)
    }
    ,
    [7] = {
        item = "samsungphone",
        price = math.random(50,100)
    }
    ,
    [8] = {
        item = "laptop",
        price = math.random(50,100)
    }
}