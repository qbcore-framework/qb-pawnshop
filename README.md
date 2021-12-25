# qb-pawnshop
Pawn Shop For QB-Core

# Add this to qb-target Config.BoxZones
```
["pawn"] = {
        name = "Pawnshop",
        coords = vector3(411.94, 315.5, 103.02),
        length = 2.35,
        width = 0.5,
        heading = 297,
        debugPoly = true,
        minZ = 100.87,
        maxZ = 104.67,
        options = {
            {
                event = "qb-pawnshop:client:openMenu",
                icon = "fas fa-ring",
                label = "Pawn Items",
            },
        },
        distance = 2.5
    },
```

# License

    QBCore Framework
    Copyright (C) 2021 Joshua Eger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>
