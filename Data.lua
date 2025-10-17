local addonName, _ = ...
-- Global object
SavedClassic = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")
SavedClassic.name = addonName
--SavedClassic.version = GetAddOnMetadata(addonName, "Version")
SavedClassic.version = "5.5.1.8"

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
    [L["Mogu'shan Vaults"]          ] = { order = -505, name = L["R5_Mogu'shan Vaults"],        color = "FF12A769" },
    [L["Heart of Fear"]             ] = { order = -504, name = L["R5_Heart of Fear"],           color = "FF05BB6F" },
    [L["Terrace of Endless Spring"] ] = { order = -503, name = L["R5_Terrace of Endless Spring"],color= "FF00D6B2" },
    [L["Throne of Thunder"]         ] = { order = -502, name = L["R5_Throne of Thunder"],       color = "FF00E284" },
    [L["Siege of Orgrimmar"]        ] = { order = -501, name = L["R5_Siege of Orgrimmar"],      color = "FF0FFFBB" },
    [L["World Boss"]                ] = { order = -500,                                         color = "FF8DFFC0" },
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
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4722)] = SavedClassic.abbr.raid[L["The Ruby Sanctum"]          ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4273)] = SavedClassic.abbr.raid[L["Trial of the Crusader"]     ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(3456)] = SavedClassic.abbr.raid[L["Ulduar"]                    ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4987)] = SavedClassic.abbr.raid[L["Naxxramas"]                 ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(2159)] = SavedClassic.abbr.raid[L["The Eye of Eternity"]       ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4500)] = SavedClassic.abbr.raid[L["The Obsidian Sanctum"]      ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4493)] = SavedClassic.abbr.raid[L["Onyxia's Lair"]             ]
SavedClassic.abbr.raid[C_Map.GetAreaInfo(4603)] = SavedClassic.abbr.raid[L["Vault of Archavon"]         ]
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

setmetatable(SavedClassic.abbr.raid, { __index =
        function(_, k) return { order = 0, name = k, color = "FFFFFF99" } end })
