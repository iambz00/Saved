local addonName, _ = ...
-- Global object
SavedClassic = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")
SavedClassic.name = addonName
--SavedClassic.version = GetAddOnMetadata(addonName, "Version")
SavedClassic.version = "2.5.5.4"

local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

SavedClassic.ts = {
	[28028] = { },	-- Void Sphere
	[26751] = { },	-- Primal Mooncloth
	[31373] = { },	-- SpellCloth
	[36686] = { },	-- Shadowcloth
	-- [29688] = { altName = L["Transmute"], },	-- Transmute: Primal Might
}

SavedClassic.currencies = {
    [1]   = { altName = L["gold"    ]:lower(), icon = "|T237618:14:14:2:0|t" }, -- Gold
    [2]   = { altName = L["silver"  ]:lower(), icon = "|T237620:14:14:2:0|t" }, -- Silver
    [3]   = { altName = L["copper"  ]:lower(), icon = "|T237617:14:14:2:0|t" }, -- Copper
    [1901]= { altName = L["honor"   ]:lower(), icon = "|T137000:14:14:0:0:14:14:0:8:0:8|t" }, -- Honor point - fix alliance on initializing
    [1900]= { altName = L["arena"   ]:lower(), icon = "|T136729:14:14:2:0|t" }, -- Arena Point
}

setmetatable(SavedClassic.currencies,
    { __index =
        function(t,k)
            for id, v in pairs(t) do
                if v.altName and v.altName == k then
                    v.currencyID = id
                    return v
                end
            end
            return { }
        end
    }
)

SavedClassic.instance = { }
SavedClassic.instance.heroic = { }
for areaID, name in pairs({
    [3562] = L["H2_Hellfire Ramparts"],
    [3713] = L["H2_The Blood Furnace"],
    [3717] = L["H2_The Slave Pens"],
    [3716] = L["H2_The Underbog"],
    [3792] = L["H2_Mana-Tombs"],
    [3790] = L["H2_Auchenai Crypts"],
    [2367] = L["H2_Old Hillsbrad Foothills"],
    [3791] = L["H2_Sethekk Halls"],
    [3715] = L["H2_The Steamvault"],
    [3789] = L["H2_Shadow Labyrinth"],
    [3714] = L["H2_The Shattered Halls"],
    [2366] = L["H2_The Black Morass"],
    [3847] = L["H2_The Botanica"],
    [3849] = L["H2_The Mechanar"],
    [3848] = L["H2_The Arcatraz"],
    [4131] = L["H2_Magisters' Terrace"],
}) do
    pcall(function() SavedClassic.instance.heroic[C_Map.GetAreaInfo(areaID)] = name end)
end

SavedClassic.instance.raid = {
    -- MoP Raid
    [L["Mogu'shan Vaults"]          ] = { areaID = 6125, order = -505, abbr = L["R5_Mogu'shan Vaults"],         color = "FF12A769" },
    [L["Heart of Fear"]             ] = { areaID = 6297, order = -504, abbr = L["R5_Heart of Fear"],            color = "FF05BB6F" },
    [L["Terrace of Endless Spring"] ] = { areaID = 6067, order = -503, abbr = L["R5_Terrace of Endless Spring"],color = "FF00D6B2" },
    [L["Throne of Thunder"]         ] = { areaID = 6622, order = -502, abbr = L["R5_Throne of Thunder"],        color = "FF00E284" },
    [L["Siege of Orgrimmar"]        ] = { areaID = 6738, order = -501, abbr = L["R5_Siege of Orgrimmar"],       color = "FF0FFFBB" },
    -- [L["World Boss"]                ] = { order = -500,                                                     color = "FF8DFFC0" },
    -- Cataclysm Raid
    [L["Dragon Soul"]               ] = { areaID = 5892, order = -406, abbr = L["R4_Dragon Soul"],              color = "FFB3001B" },
    [L["Firelands"]                 ] = { areaID = 5723, order = -405, abbr = L["R4_Firelands"],                color = "FFDE0A26" },
    [L["Throne of the Four Winds"]  ] = { areaID = 5638, order = -404, abbr = L["R4_Throne of the Four Winds"], color = "FFF01E2C" },
    [L["Blackwing Descent"]         ] = { areaID = 5094, order = -403, abbr = L["R4_Blackwing Descent"],        color = "FFFF2C2C" },
    [L["The Bastion of Twilight"]   ] = { areaID = 5334, order = -402, abbr = L["R4_Bastion of Twilight"],      color = "FFF94449" },
    [L["Baradin Hold"]              ] = { areaID = 5600, order = -401, abbr = L["R4_Baradin Hold"],             color = "FFEE6B6E" },
    -- WotLK Raid
    [L["Icecrown Citadel"]          ] = { areaID = 4812, order = -309, abbr = L["R3_Icecrown Citadel"],         color = "FFA8DAF9" },
    [L["The Ruby Sanctum"]          ] = { areaID = 4987, order = -308, abbr = L["R3_Ruby Sanctum"],             color = "FF2A9DF4" },
    [L["Trial of the Crusader"]     ] = { areaID = 4722, order = -307, abbr = L["R3_Trial of the Crusader"],    color = "FF2A9DF4" },
    [L["Ulduar"]                    ] = { areaID = 4273, order = -306, abbr = L["R3_Ulduar"],                   color = "FF187BCD" },
    [L["Naxxramas"]                 ] = { areaID = 3456, order = -305, abbr = L["R3_Naxxramas"],                color = "FFA8DAF9" },
    [L["The Eye of Eternity"]       ] = { areaID = 4500, order = -304, abbr = L["R3_Obsidian Sanctum"],         color = "FF2A9DF4" },
    [L["The Obsidian Sanctum"]      ] = { areaID = 4493, order = -303, abbr = L["R3_Eye of Eternity"],          color = "FF187BCD" },
    [L["Onyxia's Lair"]             ] = { areaID = 2159, order = -302, abbr = L["R3_Onyxia's Lair"],            color = "FF187BCD" },
    [L["Vault of Archavon"]         ] = { areaID = 4603, order = -301, abbr = L["R3_Vault of Archavon"],        color = "FF1167B1" },
    -- TBC Raid
    [L["The Sunwell"]               ] = { areaID = 4075, order = -209, abbr = L["R2_Sunwell Plateau"],          color = "FF005C29" },
    [L["Black Temple"]              ] = { areaID = 3959, order = -207, abbr = L["R2_Black Temple"],             color = "FF138808" },
    [L["-Hyjal"]                    ] = { areaID = 3606, order = -206, abbr = L["R2_Battle for Mount Hyjal"],   color = "FF228C22" },
    [L["-Serpentshrine Cavern"]     ] = { areaID = 3607, order = -205, abbr = L["R2_Serpentshrine Cavern"],     color = "FF299617" },
    [L["Tempest Keep"]              ] = { areaID = 3845, order = -204, abbr = L["R2_Tempest Keep"],             color = "FF32AB32" },
    [L["Karazhan"]                  ] = { areaID = 3457, order = -203, abbr = L["R2_Karazhan"],                 color = "FF8FD400" },
    [L["Gruul's Lair"]              ] = { areaID = 3923, order = -202, abbr = L["R2_Gruul's Lair"],             color = "FF98FF98" },
    [L["Magtheridon's Lair"]        ] = { areaID = 3836, order = -201, abbr = L["R2_Magtheridon's Lair"],       color = "FF90EE90" },
    -- Vanilla Raid
    [L["Ahn'Qiraj Temple"]          ] = { areaID = 3428, order = -105, abbr = L["R1_Temple of Ahn'Qiraj"],      color = "FF65350F" },
    [L["Ruins of Ahn'Qiraj"]        ] = { areaID = 3429, order = -104, abbr = L["R1_Ruins of Ahn'Qiraj"],       color = "FF80471C" },
    [L["Blackwing Lair"]            ] = { areaID = 2677, order = -102, abbr = L["R1_Blackwing Lair"],           color = "FF795C34" },
    [L["Molten Core"]               ] = { areaID = 2717, order = -101, abbr = L["R1_Molten Core"],              color = "FF9A7B4F" },
}

for name, body in pairs(SavedClassic.instance.raid) do
    if body.areaID then
        local areaName = C_Map.GetAreaInfo(body.areaID)
        if areaName and ( areaName ~= name) then
            SavedClassic.instance.raid[areaName] = body
        end
    end
end

setmetatable(SavedClassic.instance.raid, { __index =
        function(_, k) return { order = 0, name = k, color = "FFFFFF99" } end })
