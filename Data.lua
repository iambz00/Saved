local addonName, _ = ...
-- Global object
SavedClassic = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")
SavedClassic.name = addonName
--SavedClassic.version = GetAddOnMetadata(addonName, "Version")
SavedClassic.version = "4.4.0.6"

local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

SavedClassic.ts = { -- Tradeskills of long cooldowns
    -- Alchemy
    [80243] = { icon = "466847", },   -- Transmute: Truegold
    -- Tailoring
    [75146] = { icon = "132698", },   -- Dream of ...
}
SavedClassic.items = {  -- Items to count always
}
SavedClassic.currencies = {
    [1]   = { altName = L["gold"    ], icon = "|TInterface/MoneyFrame/UI-GoldIcon:14:14:2:0|t"},   -- Gold
    [2]   = { altName = L["silver"  ], icon = "|TInterface/MoneyFrame/UI-SilverIcon:14:14:2:0|t" },   -- Silver
    [3]   = { altName = L["copper"  ], icon = "|TInterface/MoneyFrame/UI-CopperIcon:14:14:2:0|t" },   -- Copper
    [1901]= { altName = L["honor"   ] }, -- Honor point
    [1900]= { altName = L["arena"   ] }, -- Arena point
    -- Cataclysm
    -- [Currency:Name]   : Adaptive output between Type-0 and Type-1
    -- Type-0 = [Currency:Name-0] : [Icon][Total amount]
    -- Type-1 = [Currency:Name-1] : [Icon][Total amount]([earnedThisWeek])
    -- Type-2 = [Currency:Name-2] : [Icon][Total amount]([earnedThisWeek]/[WeeklyMax])
    -- Type-3 = [Currency:Name-3] : [earnedThisWeek]
    -- Type-4 = [Currency:Name-4] : [weeklyMax]
    -- Type-5 = [Currency:Name-5] : [totalMax]
    [395] = { altName = L["JP"      ] }, -- 4.0.1 Hidden      Justice Points
    [396] = { altName = L["VP"      ] }, -- 4.0.1 Hidden      Valor Points
    [390] = { altName = L["conquest"] }, -- 4.0.1 PvP         Conquest Point
    [391] = { altName = L["TBC"     ] }, -- 4.0.1 PvP         Tol Barad Commendation
    [416] = { altName = L["MOW"     ] }, -- 4.3.4 Cataclysm   Mark of the World Tree
--    [483] = { altName = L["CAM"     ] }, -- 4.3.4 Meta        Conquest Arena Meta
--    [484] = { altName = L["CRB"     ] }, -- 4.3.4 Meta        Conquest Rated BG Meta
    [515] = { altName = L["DPT"     ] }, -- 4.3.4 Misc.       Darkmoon Prize Ticket
    [614] = { altName = L["MOD"     ] }, -- 4.3.4 Cataclysm   Mote of Darkness
    [615] = { altName = L["EOC"     ] }, -- 4.3.4 Cataclysm   Essence of Corrupted Deathwing
    [361] = { altName = L["jewel"   ] }, -- 4.0.1 Cataclysm   Illustrious Jewelcrafter's Token
    [402] = { altName = L["cook"    ] }, -- 4.3.4 Misc.       Chef's Award
    order = {
        1,2,3,1901,390,1900,-- Money, PvP
        395,396,            -- Justice, Valor
        416,615,614,        -- Raid Rewards
        361,402,            -- Jewelcraft, Cooking
        391,                -- Tol Barad
        --483,484,            -- Conquest Arena/RatedBG
        515,                -- Darkmoon
    }
}
setmetatable(SavedClassic.currencies, { __index = 
        function(t,k)
            for id, v in pairs(t) do
                if v.altName and v.altName == k then
                    v.id = id   -- Will be used in _TranslationTable
                    return v
                end
            end
            return nil
        end }
)

SavedClassic.abbr = {}
SavedClassic.abbr.heroic = {
    [C_Map.GetAreaInfo(4926)] = L["H4_Blackrock Caverns"],
    [C_Map.GetAreaInfo(5004)] = L["H4_Throne of the Tides"],
    [C_Map.GetAreaInfo(5035)] = L["H4_Vortex Pinnacle"],
    [C_Map.GetAreaInfo(5088)] = L["H4_The Stonecore"],
    [C_Map.GetAreaInfo(5396)] = L["H4_Lost City of the Tol'vir"],
    [C_Map.GetAreaInfo(4945)] = L["H4_Halls of Origination"],
    [C_Map.GetAreaInfo(4950)] = L["H4_Grim Batol"],
    [C_Map.GetAreaInfo(5789)] = L["H4_End Time"],
    [C_Map.GetAreaInfo(5788)] = L["H4_Well of Eternity"],
    [C_Map.GetAreaInfo(5844)] = L["H4_Hour of Twilight"],
    [C_Map.GetAreaInfo(1581)] = L["H4_Deadmines"],
    [C_Map.GetAreaInfo( 209)] = L["H4_Shadowfang Keep"],
    [C_Map.GetAreaInfo(1977)] = L["H4_Zul'Gurub"],
    [C_Map.GetAreaInfo(3805)] = L["H4_Zul'Aman"],
}

SavedClassic.abbr.raid = {
    -- Cataclysm Raid
    [C_Map.GetAreaInfo(5094)] = { order = -406, name = L["R4_Blackwing Descent"],        color = "d1001f" },
    [C_Map.GetAreaInfo(5334)] = { order = -405, name = L["R4_Bastion of Twilight"],      color = "de0a26" },
    [C_Map.GetAreaInfo(5638)] = { order = -404, name = L["R4_Throne of the Four Winds"], color = "f01e2c" },
    [C_Map.GetAreaInfo(5723)] = { order = -403, name = L["R4_Firelands"],                color = "ff2c2c" },
    [C_Map.GetAreaInfo(5892)] = { order = -402, name = L["R4_Dragon Soul"],              color = "f94449" },
    [C_Map.GetAreaInfo(5600)] = { order = -401, name = L["R4_Baradin Hold"],             color = "ee6b6e" },
    -- WotLK Raid 
    [C_Map.GetAreaInfo(4812)] = { order = -309, name = L["R3_Naxxramas"],             color = "a8daf9" },
    [C_Map.GetAreaInfo(4722)] = { order = -308, name = L["R3_Obsidian Sanctum"],      color = "2a9df4" },
    [C_Map.GetAreaInfo(4273)] = { order = -307, name = L["R3_Eye of Eternity"],       color = "2a9df4" },
    [C_Map.GetAreaInfo(3456)] = { order = -306, name = L["R3_Ulduar"],                color = "187bcd" },
    [C_Map.GetAreaInfo(4987)] = { order = -305, name = L["R3_Onyxia's Lair"],         color = "a8daf9" },
    [C_Map.GetAreaInfo(2159)] = { order = -304, name = L["R3_Trial of the Crusader"], color = "2a9df4" },
    [C_Map.GetAreaInfo(4500)] = { order = -303, name = L["R3_Icecrown Citadel"],      color = "187bcd" },
    [C_Map.GetAreaInfo(4493)] = { order = -302, name = L["R3_Ruby Sanctum"],          color = "187bcd" },
    [C_Map.GetAreaInfo(4603)] = { order = -301, name = L["R3_Vault of Archavon"],     color = "1167b1" },
    -- TBC Raid
    [C_Map.GetAreaInfo(4075)] = { order = -209, name = L["R2_Sunwell Plateau"],       },
    [C_Map.GetAreaInfo(3959)] = { order = -207, name = L["R2_Black Temple"],          },
    [C_Map.GetAreaInfo(3606)] = { order = -206, name = L["R2_Battle for Mount Hyjal"],},
    [C_Map.GetAreaInfo(3607)] = { order = -205, name = L["R2_Serpentshrine CavernC"], },
    [C_Map.GetAreaInfo(3845)] = { order = -204, name = L["R2_The Eye"],               },
    [C_Map.GetAreaInfo(3457)] = { order = -203, name = L["R2_Karazhan"],              },
    [C_Map.GetAreaInfo(3923)] = { order = -202, name = L["R2_Gruul's Lair"],          },
    [C_Map.GetAreaInfo(3836)] = { order = -201, name = L["R2_Magtheridon's Lair"],    },
    -- Vanilla Raid                                                                   
    [C_Map.GetAreaInfo(3428)] = { order = -105, name = L["R1_Temple of Ahn'Qiraj"],   },
    [C_Map.GetAreaInfo(3429)] = { order = -104, name = L["R1_Ruins of Ahn'Qiraj"],    },
    [C_Map.GetAreaInfo(2677)] = { order = -102, name = L["R1_Blackwing Lair"],        },
    [C_Map.GetAreaInfo(2717)] = { order = -101, name = L["R1_Molten Core"],           },
}
