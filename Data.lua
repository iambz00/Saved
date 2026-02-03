local addonName, _ = ...
-- Global object
SavedClassic = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")
SavedClassic.name = addonName
--SavedClassic.version = GetAddOnMetadata(addonName, "Version")
SavedClassic.version = "2.5.5.2"

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
    order = {
        1,2,3,1900,1901
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
    [C_Map.GetAreaInfo(3562)] = L["H2_Hellfire Ramparts"],
    [C_Map.GetAreaInfo(3713)] = L["H2_The Blood Furnace"],
    [C_Map.GetAreaInfo(3717)] = L["H2_The Slave Pens"],
    [C_Map.GetAreaInfo(3716)] = L["H2_The Underbog"],
    [C_Map.GetAreaInfo(3792)] = L["H2_Mana-Tombs"],
    [C_Map.GetAreaInfo(3790)] = L["H2_Auchenai Crypts"],
    [C_Map.GetAreaInfo(2367)] = L["H2_Old Hillsbrad Foothills"],
    [C_Map.GetAreaInfo(3791)] = L["H2_Sethekk Halls"],
    [C_Map.GetAreaInfo(3715)] = L["H2_The Steamvault"],
    [C_Map.GetAreaInfo(3789)] = L["H2_Shadow Labyrinth"],
    [C_Map.GetAreaInfo(3714)] = L["H2_The Shattered Halls"],
    [C_Map.GetAreaInfo(2366)] = L["H2_The Black Morass"],
    [C_Map.GetAreaInfo(3847)] = L["H2_The Botanica"],
    [C_Map.GetAreaInfo(3849)] = L["H2_The Mechanar"],
    [C_Map.GetAreaInfo(3848)] = L["H2_The Arcatraz"],
    [C_Map.GetAreaInfo(4131)] = L["H2_Magisters' Terrace"],
}

SavedClassic.abbr.raid = {
    -- MoP Raid
    [L["Mogu'shan Vaults"]          ] = { order = -505, name = L["R5_Mogu'shan Vaults"],        color = "FF12A769" },
    [L["Heart of Fear"]             ] = { order = -504, name = L["R5_Heart of Fear"],           color = "FF05BB6F" },
    [L["Terrace of Endless Spring"] ] = { order = -503, name = L["R5_Terrace of Endless Spring"],color= "FF00D6B2" },
    [L["Throne of Thunder"]         ] = { order = -502, name = L["R5_Throne of Thunder"],       color = "FF00E284" },
    [L["Siege of Orgrimmar"]        ] = { order = -501, name = L["R5_Siege of Orgrimmar"],      color = "FF0FFFBB" },
    -- [L["World Boss"]                ] = { order = -500,                                         color = "FF8DFFC0" },
    -- Cataclysm Raid
    [L["Dragon Soul"]               ] = { order = -406, name = L["R4_Dragon Soul"],             color = "FFB3001B" },
    [L["Firelands"]                 ] = { order = -405, name = L["R4_Firelands"],               color = "FFDE0A26" },
    [L["Throne of the Four Winds"]  ] = { order = -404, name = L["R4_Throne of the Four Winds"],color = "FFF01E2C" },
    [L["Blackwing Descent"]         ] = { order = -403, name = L["R4_Blackwing Descent"],       color = "FFFF2C2C" },
    [L["The Bastion of Twilight"]   ] = { order = -402, name = L["R4_Bastion of Twilight"],     color = "FFF94449" },
    [L["Baradin Hold"]              ] = { order = -401, name = L["R4_Baradin Hold"],            color = "FFEE6B6E" },
    -- WotLK Raid
    [L["Icecrown Citadel"]          ] = { order = -309, name = L["R3_Icecrown Citadel"],        color = "FFA8DAF9" },
    [L["The Ruby Sanctum"]          ] = { order = -308, name = L["R3_Ruby Sanctum"],            color = "FF2A9DF4" },
    [L["Trial of the Crusader"]     ] = { order = -307, name = L["R3_Trial of the Crusader"],   color = "FF2A9DF4" },
    [L["Ulduar"]                    ] = { order = -306, name = L["R3_Ulduar"],                  color = "FF187BCD" },
    [L["Naxxramas"]                 ] = { order = -305, name = L["R3_Naxxramas"],               color = "FFA8DAF9" },
    [L["The Eye of Eternity"]       ] = { order = -304, name = L["R3_Obsidian Sanctum"],        color = "FF2A9DF4" },
    [L["The Obsidian Sanctum"]      ] = { order = -303, name = L["R3_Eye of Eternity"],         color = "FF187BCD" },
    [L["Onyxia's Lair"]             ] = { order = -302, name = L["R3_Onyxia's Lair"],           color = "FF187BCD" },
    [L["Vault of Archavon"]         ] = { order = -301, name = L["R3_Vault of Archavon"],       color = "FF1167B1" },
    -- TBC Raid
    [L["The Sunwell"]               ] = { order = -209, name = L["R2_Sunwell Plateau"],         color = "FF005C29" },
    [L["Black Temple"]              ] = { order = -207, name = L["R2_Black Temple"],            color = "FF138808" },
    [L["-Hyjal"]                    ] = { order = -206, name = L["R2_Battle for Mount Hyjal"],  color = "FF228C22" },
    [L["-Serpentshrine Cavern"]     ] = { order = -205, name = L["R2_Serpentshrine Cavern"],    color = "FF299617" },
    [L["Tempest Keep"]              ] = { order = -204, name = L["R2_Tempest Keep"],            color = "FF32AB32" },
    [L["Karazhan"]                  ] = { order = -203, name = L["R2_Karazhan"],                color = "FF8FD400" },
    [L["Gruul's Lair"]              ] = { order = -202, name = L["R2_Gruul's Lair"],            color = "FF98FF98" },
    [L["Magtheridon's Lair"]        ] = { order = -201, name = L["R2_Magtheridon's Lair"],      color = "FF90EE90" },
    -- Vanilla Raid                                                                   
    [L["Ahn'Qiraj Temple"]          ] = { order = -105, name = L["R1_Temple of Ahn'Qiraj"],     color = "FF65350F" },
    [L["Ruins of Ahn'Qiraj"]        ] = { order = -104, name = L["R1_Ruins of Ahn'Qiraj"],      color = "FF80471C" },
    [L["Blackwing Lair"]            ] = { order = -102, name = L["R1_Blackwing Lair"],          color = "FF795C34" },
    [L["Molten Core"]               ] = { order = -101, name = L["R1_Molten Core"],             color = "FF9A7B4F" },
}
--[[
SavedClassic.abbr.raid[C_Map.GetAreaInfo(6125)] = SavedClassic.abbr.raid[L["Mogu'shan Vaults"]          ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(6297)] = SavedClassic.abbr.raid[L["Heart of Fear"]             ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(6067)] = SavedClassic.abbr.raid[L["Terrace of Endless Spring"] ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(6622)] = SavedClassic.abbr.raid[L["Throne of Thunder"]         ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(6738)] = SavedClassic.abbr.raid[L["Siege of Orgrimmar"]        ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(5892)] = SavedClassic.abbr.raid[L["Dragon Soul"]               ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(5723)] = SavedClassic.abbr.raid[L["Firelands"]                 ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(5638)] = SavedClassic.abbr.raid[L["Throne of the Four Winds"]  ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(5094)] = SavedClassic.abbr.raid[L["Blackwing Descent"]         ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(5334)] = SavedClassic.abbr.raid[L["The Bastion of Twilight"]   ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(5600)] = SavedClassic.abbr.raid[L["Baradin Hold"]              ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4812)] = SavedClassic.abbr.raid[L["Icecrown Citadel"]          ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4987)] = SavedClassic.abbr.raid[L["The Ruby Sanctum"]          ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4722)] = SavedClassic.abbr.raid[L["Trial of the Crusader"]     ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4273)] = SavedClassic.abbr.raid[L["Ulduar"]                    ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(3456)] = SavedClassic.abbr.raid[L["Naxxramas"]                 ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4493)] = SavedClassic.abbr.raid[L["The Obsidian Sanctum"]      ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4500)] = SavedClassic.abbr.raid[L["The Eye of Eternity"]       ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(2159)] = SavedClassic.abbr.raid[L["Onyxia's Lair"]             ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4603)] = SavedClassic.abbr.raid[L["Vault of Archavon"]         ]
]]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4075)] = SavedClassic.abbr.raid[L["The Sunwell"]               ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(3959)] = SavedClassic.abbr.raid[L["Black Temple"]              ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(3606)] = SavedClassic.abbr.raid[L["-Hyjal"]                    ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(3607)] = SavedClassic.abbr.raid[L["-Serpentshrine Cavern"]     ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(3845)] = SavedClassic.abbr.raid[L["Tempest Keep"]              ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(3457)] = SavedClassic.abbr.raid[L["Karazhan"]                  ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(3923)] = SavedClassic.abbr.raid[L["Gruul's Lair"]              ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(3836)] = SavedClassic.abbr.raid[L["Magtheridon's Lair"]        ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(3428)] = SavedClassic.abbr.raid[L["Ahn'Qiraj Temple"]          ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(3429)] = SavedClassic.abbr.raid[L["Ruins of Ahn'Qiraj"]        ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(2677)] = SavedClassic.abbr.raid[L["Blackwing Lair"]            ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(2717)] = SavedClassic.abbr.raid[L["Molten Core"]               ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(2159)] = SavedClassic.abbr.raid[L["Onyxia's Lair"]             ]

setmetatable(SavedClassic.abbr.raid, { __index =
        function(_, k) return { order = 0, name = k, color = "FFFFFF99" } end })
