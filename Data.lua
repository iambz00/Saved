local addonName, _ = ...
-- Global object
SavedClassic = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")
SavedClassic.name = addonName
--SavedClassic.version = GetAddOnMetadata(addonName, "Version")
SavedClassic.version = "5.5.1.5"

local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

SavedClassic.ts = {
    [114780] = { icon = "|T612100:14:14|t" }, -- (Alchemy) Transmute: Living Steel
    [131686] = { icon = "|T134139:14:14|t" }, -- (Jewelcrafting) Shared Cooldown
    [116499] = { icon = "|T463518:14:14|t" }, -- (Enchanting) Sha Crystal
    [112996] = { icon = "|T632822:14:14|t" }, -- (Inscription) Scroll of Wisdom
    [138646] = { icon = "|T576649:14:14|t" }, -- (Blacksmithing) Lightning Steel Ingot
    [140040] = { icon = "|T642725:14:14|t" }, -- (Leatherworking) Magnificence of Leather -- inv_misc_pelt_08
    [140041] = { icon = "|T642723:14:14|t" }, --    Magnificence of Scales
    [142976] = { icon = "|T878263:14:14|t" }, --    Hardened Magnificent Hide
    [125557] = { icon = "|T629936:14:14|t" }, -- (Tailoring) Imperial Silk
}

SavedClassic.items = {  -- Items to count always
}
SavedClassic.currencies = {
    [1]   = { altName = L["gold"    ]:lower(), icon = "|T237618:14:14:2:0|t" }, -- Gold
    [2]   = { altName = L["silver"  ]:lower(), icon = "|T237620:14:14:2:0|t" }, -- Silver
    [3]   = { altName = L["copper"  ]:lower(), icon = "|T237617:14:14:2:0|t" }, -- Copper
    [1901]= { altName = L["honor"   ]:lower() }, -- Honor point
    -- [Currency:Name]   : Adaptive output between Type-0 and Type-2
    -- Type-0 = [Currency:Name-0] : [Icon][Quantity]
    -- Type-1 = [Currency:Name-1] : [Icon][Quantity]([Earnable])  -- Earnable in minus value
    -- Type-2 = [Currency:Name-2] : [Icon][Quantity]([Earnable])  -- Earnable in red font
    -- Type-3 = [Currency:Name-3] : [Icon][Quantity]([Earned]/[MaxQuantity])
    [395] = { altName = L["JP"      ]:lower() }, -- Justice Points
    [396] = { altName = L["VP"      ]:lower() }, -- Valor Points
    [390] = { altName = L["conquest"]:lower() }, -- Conquest Point
    [515] = { altName = L["Darkmoon"]:lower() }, -- Darkmoon Prize Ticket
    -- Mists of Pandaria
    [697] = { altName = L["Elder"   ]:lower() }, -- Elder Charm of Good Fortune 행운의 장로 부적
    [738] = { altName = L["Lesser"  ]:lower() }, -- Lesser Charm of Good Fortune 행운의 하급 부적
    [752] = { altName = L["Mogu"    ]:lower() }, -- Mogu Rune of Fate 운명의 모구 룬
    [776] = { altName = L["Seal"    ]:lower() }, -- Warforged Seal 전쟁벼림 인장
    [777] = { altName = L["Timeless"]:lower() }, -- Timeless Coin 영원의 주화
    [3350]= { altName = L["August"  ]:lower() }, -- August Stone Fragment 천신석 파편
    [402] = { altName = L["Ironpaw" ]:lower() }, -- Ironpaw Token 아이언포우 징표
    [789] = { altName = L["Bloody"  ]:lower() }, -- Bloody Coin 피투성이 동전

    order = {
        1,2,3,          -- Gold, Silver, Copper
        396,395,        -- Valor, Justice
        390,1901,       -- Conquest, Honor
        697,738,752,776, -- Raid related
        3350,           -- Elemental Rune Dungeon
        777,            -- Timeless Isle
        402,            -- Cooking
        789,            -- PvP
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

SavedClassic.worldBoss = {
    [32098] = L["Galleon"],
    [32099] = L["Sha of Anger"],
    [32518] = L["Nalak"],
    [32519] = L["Oondasta"],
}

SavedClassic.abbr = {}
SavedClassic.abbr.heroic = {
    [C_Map.GetAreaInfo(5918)] = L["H5_Shado-pan Monastery"],
    [C_Map.GetAreaInfo(5956)] = L["H5_Temple of the Jade Serpent"],
    [C_Map.GetAreaInfo(5963)] = L["H5_Stormstout Brewery"],
    [C_Map.GetAreaInfo(5976)] = L["H5_Gate of the Setting Sun"],
    [C_Map.GetAreaInfo(6182)] = L["H5_Mogu'shan Palace"],
    [C_Map.GetAreaInfo(6052)] = L["H5_Scarlet Halls"],
    [C_Map.GetAreaInfo(6109)] = L["H5_Scarlet Monastery"],
    [C_Map.GetAreaInfo(6066)] = L["H5_Scholomance"],
    [C_Map.GetAreaInfo(6214)] = L["H5_Siege of Niuzao Temple"],
}

SavedClassic.abbr.raid = {
    -- MoP Raid
    [C_Map.GetAreaInfo(6125)] = { order = -505, name = L["R5_Mogu'shan Vaults"],        color = "FF12A769" },
    [C_Map.GetAreaInfo(6297)] = { order = -504, name = L["R5_Heart of Fear"],           color = "FF05BB6F" },
    [C_Map.GetAreaInfo(6067)] = { order = -503, name = L["R5_Terrace of Endless Spring"],color= "FF00D6B2" },
    [C_Map.GetAreaInfo(6622)] = { order = -502, name = L["R5_Throne of Thunder"],       color = "FF00E284" },
    [C_Map.GetAreaInfo(6738)] = { order = -501, name = L["R5_Siege of Orgrimmar"],      color = "FF0FFFBB" },
    [L["World Boss"]        ] = { order = -500,                                         color = "FF8DFFC0" },
    -- Cataclysm Raid
    [C_Map.GetAreaInfo(5892)] = { order = -406, name = L["R4_Dragon Soul"],             color = "FFB3001B" },
    [C_Map.GetAreaInfo(5723)] = { order = -405, name = L["R4_Firelands"],               color = "FFDE0A26" },
    [C_Map.GetAreaInfo(5638)] = { order = -404, name = L["R4_Throne of the Four Winds"],color = "FFF01E2C" },
    [C_Map.GetAreaInfo(5094)] = { order = -403, name = L["R4_Blackwing Descent"],       color = "FFFF2C2C" },
    [C_Map.GetAreaInfo(5334)] = { order = -402, name = L["R4_Bastion of Twilight"],     color = "FFF94449" },
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
    [C_Map.GetAreaInfo(4075)] = { order = -209, name = L["R2_Sunwell Plateau"],         color = "FF005C29" },
    [C_Map.GetAreaInfo(3959)] = { order = -207, name = L["R2_Black Temple"],            color = "FF138808" },
    [C_Map.GetAreaInfo(3606)] = { order = -206, name = L["R2_Battle for Mount Hyjal"],  color = "FF228C22" },
    [C_Map.GetAreaInfo(3607)] = { order = -205, name = L["R2_Serpentshrine CavernC"],   color = "FF299617" },
    [C_Map.GetAreaInfo(3845)] = { order = -204, name = L["R2_The Eye"],                 color = "FF32AB32" },
    [C_Map.GetAreaInfo(3457)] = { order = -203, name = L["R2_Karazhan"],                color = "FF8FD400" },
    [C_Map.GetAreaInfo(3923)] = { order = -202, name = L["R2_Gruul's Lair"],            color = "FF98FF98" },
    [C_Map.GetAreaInfo(3836)] = { order = -201, name = L["R2_Magtheridon's Lair"],      color = "FF90EE90" },
    -- Vanilla Raid                                                                   
    [C_Map.GetAreaInfo(3428)] = { order = -105, name = L["R1_Temple of Ahn'Qiraj"],     color = "FF65350F" },
    [C_Map.GetAreaInfo(3429)] = { order = -104, name = L["R1_Ruins of Ahn'Qiraj"],      color = "FF80471C" },
    [C_Map.GetAreaInfo(2677)] = { order = -102, name = L["R1_Blackwing Lair"],          color = "FF795C34" },
    [C_Map.GetAreaInfo(2717)] = { order = -101, name = L["R1_Molten Core"],             color = "FF9A7B4F" },
}

setmetatable(SavedClassic.abbr.raid, { __index =
        function(_, k) return { order = 0, name = k, color = "FFFFFF99" } end })
