local addonName, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true)

if L then
L["Transmute"] = true

L["Reset due to update"] = function(oldv, newv) return "Reset some or entire data due to version update ("..oldv.." -> "..newv.. ")" end
L["extended"] = "(extended)"

L["minites"] = "m"
L["Enabled"] = true
L["Disabled"] = true

L["Raid Table Notice"] = "L-Click to open Raid table, R-Click to open Options"
L["DISPLAY"] = "Display"
L["TOOLTIP_SCALE"] = "Tooltip Scale(%)"
L["FLOAT_UI"] = "Float UI"
L["FLOAT_UI_W"] = "UI Width"
L["FLOAT_UI_H"] = "UI Height"
L["FLOAT_UI_DESCRIPTION"] = "|cff00ff00■|r |cffccaa00Shift - Drag to move the Frame|r"
L["MINIMAP_ICON"] = "Minimap Icon"
L["DISPLAY_SCOPE"] = "Display Scope"
L["Character"] = true
L["Realm"] = true
L["Account"] = true
L["TOTAL_GOLD"] = "Total Gold"
L["HIDE_LEVEL"] = "Hide Character Below Level"
L["CURRENT_1ST"] = "Current Chracter First"
L["SORT_BY"] = "Sort By"
L["SORT_ORDER"] = "Sort Order"
L["Descending"] = true
L["Ascending"] = true
L["EXCLUDE"] = "Exclude Characters(Separate by comma or space)"
L["TOOLTIP"] = "Tooltip"
L["TOOLTIP_CHARACTER"] = "Tooltip - Character Info."
L["INFO1"] = "Line 1 of Char Info."
L["INFO2"] = "Line 2 of Char Info."
L["Left"] = true
L["Right"] = true
L["TOOLTIP_RAID"] = "Tooltip - Raid Instances"
L["INFO3"] = "Lines of raid instances"
L["TOOLTIP_HEROIC"] = "Tooltip - Heroic instances"
L["INFO4"] = "Lines of heroic instances"
L["INFO_SHORT"] = "Display as One-line"

L["Common"] = true
L["LowLevel"] = true

-- Localized Translation Table
L["color"     ] = true
L["item"      ] = true
L["currency"  ] = true
L["name"      ] = true
L["name2"     ] = true
L["zone"      ] = true
L["subzone"   ] = true
L["cooldown"  ] = true
L["elapsed"   ] = true
L["level"     ] = true
L["expCur"    ] = true
L["expMax"    ] = true
L["exp%"      ] = true
L["expRest"   ] = true
L["expRest%"  ] = true
L["dqCom"     ] = true
L["dqReset"   ] = true
L["ilvl"      ] = true
L["ilvl_avg"  ] = true
L["ilvl_equip"] = true
L["instName"  ] = true
L["instID"    ] = true
L["difficulty"] = true
L["progress"  ] = true
L["bosses"    ] = true
L["time"      ] = true
L["playedtotal"] = true
L["playedlevel"] = true
-- Localized Currency Name
L["gold"    ] = true
L["silver"  ] = true
L["copper"  ] = true
L["honor"   ] = true
L["arena"   ] = true
-- Usage
L["Usage_Character"] = {
    { "|cff00ff00■|r |cffccaa00Keywords for Character info|r" },
    { "[name]"          , "Name(color)"     , "[name2]"         , "Name(no color)"  },
    { "[level]"         , "[expCur]"        , "[expMax]"        , "[exp%]"      },
    { "[expRest]"       , "[expRest%]"      , "[zone]"          , "[subzone]"   },
    { "[elapsed]"       , "After last update", "[cooldown]"     , "Tradeskill cooldowns"    },
    { "[item:name]"     , "[item:name]"     , "Item Icon and Count",            },
    { "[dqCom]"         , "[dqReset]"       ,   },
    { "[ilvl]"          , "[ilvl_avg]"      , "[ilvl_equip]"    ,   },
    { "[color/|cffff0000##|r|cff00ff00##|r|cff0000ff##|r]"
                        , "Color start(RGB)", "[color]"         , "Color end"   },
    { "! attach /###### to any keyword to apply color",             },
    { "[currency:name]" , "Currency Icon and Count",  },
}
L["Usage_Instance"] = {
    { "|cff00ff00■|r |cffccaa00Keywords for Instance info|r",   },
    { "[instName]"      , "Instance name"   , "[difficulty]"    , "Size and Difficulty" },
    { "[progress]"      , "Killed"          , "[bosses]"        , "Total"       },
    { "[time]"          , "Time to reset"   , "[instID]"        , "Instance ID" },
}
-- Abbreviation
L["H2_Hellfire Ramparts"]         = "HR"
L["H2_The Blood Furnace"]         = "BR"
L["H2_The Slave Pens"]            = "SP"
L["H2_The Underbog"]              = "Ub"
L["H2_Mana-Tombs"]                = "MT"
L["H2_Auchenai Crypts"]           = "AC"
L["H2_Old Hillsbrad Foothills"]   = "OH"
L["H2_Sethekk Halls"]             = "Se"
L["H2_The Steamvault"]            = "Sv"
L["H2_Shadow Labyrinth"]          = "SL"
L["H2_The Shattered Halls"]       = "Sh"
L["H2_The Black Morass"]          = "BM"
L["H2_The Botanica"]              = "Bo"
L["H2_The Mechanar"]              = "Me"
L["H2_The Arcatraz"]              = "Ar"
L["H2_Magisters' Terrace"]        = "Te"

L["R5_Mogu'shan Vaults"         ] = "MsV"
L["R5_Heart of Fear"            ] = "HoF"
L["R5_Terrace of Endless Spring"] = "TES"
L["R5_Throne of Thunder"        ] = "ToT"
L["R5_Siege of Orgrimmar"       ] = "SoO"
L["R4_Blackwing Descent"        ] = "BWD"
L["R4_Bastion of Twilight"      ] = "BoT"
L["R4_Throne of the Four Winds" ] = "T4W"
L["R4_Firelands"                ] = "FL"
L["R4_Dragon Soul"              ] = "DS"
L["R4_Baradin Hold"             ] = "BH"
L["R3_Naxxramas"                ] = "Naxx"
L["R3_Obsidian Sanctum"         ] = "OS"
L["R3_Eye of Eternity"          ] = "EoE"
L["R3_Ulduar"                   ] = "ULD"
L["R3_Onyxia's Lair"            ] = "Ony"
L["R3_Trial of the Crusader"    ] = "CC"
L["R3_Icecrown Citadel"         ] = "IC"
L["R3_Ruby Sanctum"             ] = "RS"
L["R3_Vault of Archavon"        ] = "VoA"
L["R2_Sunwell Plateau"          ] = "SP"
L["R2_Black Temple"             ] = "BT"
L["R2_Battle for Mount Hyjal"   ] = "Hyjal"
L["R2_Serpentshrine Cavern"     ] = "SSC"
L["R2_Tempest Keep"             ] = "TK"
L["R2_Karazhan"                 ] = "KZ"
L["R2_Gruul's Lair"             ] = "Gruul"
L["R2_Magtheridon's Lair"       ] = "Mag"
L["R1_Temple of Ahn'Qiraj"      ] = "TAQ"
L["R1_Ruins of Ahn'Qiraj"       ] = "RAQ"
L["R1_Blackwing Lair"           ] = "BW"
L["R1_Molten Core"              ] = "MC"
-- Full Name
L["Mogu'shan Vaults"            ] = true
L["Heart of Fear"               ] = true
L["Terrace of Endless Spring"   ] = true
L["Throne of Thunder"           ] = true
L["Siege of Orgrimmar"          ] = true
L["Dragon Soul"                 ] = true
L["Firelands"                   ] = true
L["Throne of the Four Winds"    ] = true
L["Blackwing Descent"           ] = true
L["The Bastion of Twilight"     ] = true
L["Baradin Hold"                ] = true
L["Icecrown Citadel"            ] = true
L["The Ruby Sanctum"            ] = true
L["Trial of the Crusader"       ] = true
L["Ulduar"                      ] = true
L["Naxxramas"                   ] = true
L["The Eye of Eternity"         ] = true
L["The Obsidian Sanctum"        ] = true
L["Onyxia's Lair"               ] = true
L["Vault of Archavon"           ] = true
L["The Sunwell"                 ] = true
L["Black Temple"                ] = true
L["-Hyjal"                      ] = "The Battle for Mount Hyjal"
L["-Serpentshrine Cavern"       ] = "Coilfang: Serpentshrine Cavern"
L["Tempest Keep"                ] = true
L["Karazhan"                    ] = true
L["Gruul's Lair"                ] = true
L["Magtheridon's Lair"          ] = true
L["Ahn'Qiraj Temple"            ] = true
L["Ruins of Ahn'Qiraj"          ] = true
L["Blackwing Lair"              ] = true
L["Molten Core"                 ] = true

end
