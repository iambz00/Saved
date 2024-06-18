local addonName, _ = ...
-- Global object
SavedClassic = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")
SavedClassic.name = addonName
--SavedClassic.version = GetAddOnMetadata(addonName, "Version")
SavedClassic.version = "4.4.0.8"

local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

SavedClassic.ts = { -- Tradeskills of long cooldowns
    [80243] = { icon = "466847", }, -- (Alchemy) Transmute: Truegold
    -- Tailoring - 6 Dreamcloth recipe shares cooldown
    [75141] = { share = 75146   },  -- (Tailoring) Dream of Skywall (Air)
    [75142] = { share = 75146   },  -- (Tailoring) Dream of Deepholm (Earth)
    [75144] = { share = 75146   },  -- (Tailoring) Dream of Hyjal (Life)
    [75145] = { share = 75146   },  -- (Tailoring) Dream of Ragnaros (Fire)
    [75146] = { icon = "132698" },  -- (Tailoring) Dream of Azshara (Water)
    [73478] = { icon = "134128" },  -- (Jewelcraft) Fire Prism
    [86654] = { icon = "237446" },  -- (Inscription) Forged documents(Horde)
    [89244] = { icon = "237446" },  -- (Inscription) Forged documents(Alliance)
}
SavedClassic.items = {  -- Items to count always
}
SavedClassic.currencies = {
    [1]   = { altName = L["gold"    ], icon = "|TInterface/MoneyFrame/UI-GoldIcon:14:14:2:0|t"},   -- Gold
    [2]   = { altName = L["silver"  ], icon = "|TInterface/MoneyFrame/UI-SilverIcon:14:14:2:0|t" },   -- Silver
    [3]   = { altName = L["copper"  ], icon = "|TInterface/MoneyFrame/UI-CopperIcon:14:14:2:0|t" },   -- Copper
    [1901]= { altName = L["honor"   ] }, -- Honor point
    -- Cataclysm
    -- [Currency:Name]   : Adaptive output between Type-0 and Type-2
    -- Type-0 = [Currency:Name-0] : [Icon][Quantity]
    -- Type-1 = [Currency:Name-1] : [Icon][Quantity]([Earnable])  -- Earnable in minus value
    -- Type-2 = [Currency:Name-2] : [Icon][Quantity]([Earnable])  -- Earnable in red font
    -- Type-3 = [Currency:Name-3] : [Icon][Quantity]([Earned]/[MaxQuantity])
    [395] = { altName = L["JP"      ] }, -- 4.0.1 Hidden      Justice Points
    [396] = { altName = L["VP"      ] }, -- 4.0.1 Hidden      Valor Points
    [390] = { altName = L["conquest"] }, -- 4.0.1 PvP         Conquest Point
    [416] = { altName = L["MOW"     ] }, -- 4.3.4 Cataclysm   Mark of the World Tree
    [614] = { altName = L["MOD"     ] }, -- 4.3.4 Cataclysm   Mote of Darkness
    [615] = { altName = L["EOC"     ] }, -- 4.3.4 Cataclysm   Essence of Corrupted Deathwing
    [361] = { altName = L["jewel"   ] }, -- 4.0.1 Cataclysm   Illustrious Jewelcrafter's Token
    [402] = { altName = L["cook"    ] }, -- 4.3.4 Misc.       Chef's Award
    [391] = { altName = L["TBC"     ] }, -- 4.0.1 PvP         Tol Barad Commendation
    [515] = { altName = L["DPT"     ] }, -- 4.3.4 Misc.       Darkmoon Prize Ticket
    order = {
        1,2,3,          -- Gold, Silver, Copper
        396,395,        -- [Valor], Justice
        390,1901,       -- [Conquest], Honor
        416,614,615,    -- Raid Rewards
        361,402,        -- Jewelcraft, Cooking
        391,            -- Tol Barad
        515,            -- Darkmoon
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
    [C_Map.GetAreaInfo(5094)] = { order = -406, name = L["R4_Dragon Soul"],             color = "FFB3001B" },
    [C_Map.GetAreaInfo(5334)] = { order = -405, name = L["R4_Firelands"],               color = "FFDE0A26" },
    [C_Map.GetAreaInfo(5638)] = { order = -404, name = L["R4_Throne of the Four Winds"],color = "FFF01E2C" },
    [C_Map.GetAreaInfo(5723)] = { order = -403, name = L["R4_Blackwing Descent"],       color = "FFFF2C2C" },
    [C_Map.GetAreaInfo(5892)] = { order = -402, name = L["R4_Bastion of Twilight"],     color = "FFF94449" },
    [C_Map.GetAreaInfo(5600)] = { order = -401, name = L["R4_Baradin Hold"],            color = "FFEE6B6E" },
    -- WotLK Raid 
    [C_Map.GetAreaInfo(4812)] = { order = -309, name = L["R3_Icecrown Citadel"],        color = "FFA8DAF9" },
    [C_Map.GetAreaInfo(4722)] = { order = -308, name = L["R3_Ruby Sanctum"],            color = "FF2A9DF4" },
    [C_Map.GetAreaInfo(4273)] = { order = -307, name = L["R3_Trial of the Crusader"],   color = "FF2A9DF4" },
    [C_Map.GetAreaInfo(3456)] = { order = -306, name = L["R3_Ulduar"],                  color = "FF187BCD" },
    [C_Map.GetAreaInfo(4987)] = { order = -305, name = L["R3_Naxxramas"],               color = "FFA8DAF9" },
    [C_Map.GetAreaInfo(2159)] = { order = -304, name = L["R3_Obsidian Sanctum"],        color = "FF2A9DF4" },
    [C_Map.GetAreaInfo(4500)] = { order = -303, name = L["R3_Eye of Eternity"],         color = "FF187BCD" },
    [C_Map.GetAreaInfo(4493)] = { order = -302, name = L["R3_Onyxia's Lair"],           color = "FF187BCD" },
    [C_Map.GetAreaInfo(4603)] = { order = -301, name = L["R3_Vault of Archavon"],       color = "FF1167B1" },
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
