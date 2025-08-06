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
L["Display settings"] = true
L["Desc - Common"] = "|cff00ff00■|r |cffccaa00Every options are saved [per chracter]|r"
L["Show floating UI frame"] = true
L["Floating UI width"] = true
L["Floating UI height"] = true
L["Desc - Frame"] = "|cff00ff00■|r |cffccaa00Shift - Drag to move the Frame|r"
L["Show minimap icon"] = true
L["Show info"] = true
L["per Character"] = true
L["per Realm"] = true
L["Show total gold"] = true
L["Hide info from level under"] = true
L["Show current chracter first"] = true
L["Sort Order"] = true
L["Sort Option"] = true
L["Exclude Characters"] = "Exclude Characters(Separate by , or space)"
L["Descending"] = true
L["Asscending"] = true
L["Tooltip - Character info."] = true
L["Line 1 of char info."] = true
L["Line 2 of char info."] = true
L["Left"] = true
L["Right"] = true
L["Tooltip - Raid instances"] = true
L["Lines of raid instances"] = true
L["Tooltip - Heroic instances"] = true
L["Lines of heroic instances"] = true
L["Show in one-line"] = true

L["Select character"] = true
L["Reset selected character"] = true
L["Are you really want to reset?"] = true
L["Reset all characters"] = true
L["Copy settings to"] = true
L["Copy"] = true
L["Confirm copy"] = "Overwrite settings to target character"

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
L["conquest"] = true
L["JP"      ] = true
L["VP"      ] = true
L["Darkmoon"] = true
-- MoP
L["Elder"   ] = true
L["Lesser"  ] = true
L["Mogu"    ] = true
L["Seal"    ] = true
L["Timeless"] = true
L["August"  ] = true
L["Ironpaw" ] = true
L["Bloody"  ] = true
-- Usage
L["Usage_Character"] = {
    { "|cff00ff00■|r |cffccaa00Keywords for Character info|r" },
    { "[name]"          , "Name(color)"     , "[name2]"         , "Name(no color)"  },
    { "[level]"         , "[expCur]"        , "[expMax]"        , "[exp%]"      },
    { "[expRest]"       , "[expRest%]"      , "[zone]"          , "[subzone]"   },
    { "[elapsed]"       , "After last update", "[cooldown]"     , "Tradeskill cooldowns"    },
    { "[item:name]"     , "[item:name]"     , "Item Icon and Count",            },
    { "[dqCom]"         , "[dqReset]"       , "[playedtotal]"   , "[playedlevel]" },
    { "[ilvl]"          , "[ilvl_avg]"      , "[ilvl_equip]"    ,   },
    { "[color/|cffff0000##|r|cff00ff00##|r|cff0000ff##|r]"
                        , "Color start(RGB)", "[color]"         , "Color end"   },
    { "! attach /###### to any keyword to apply color",             },
    { "[currency:name]" , "[currency:ID]"   , "Currency Icon and Count",  },
    { " |cffff0000!|r Valor/Conquest Style" ,  "", "[currency:VP-3]", "|T463447:14:14|t960(4460/9600)"   },
    { "[currency:VP-2]" , "|T463447:14:14|t960(|cFFFF75755140|r)", "[currency:VP-1]"   , "|T463447:14:14|t960(-5140)"   },
}
L["Usage_Instance"] = {
    { "|cff00ff00■|r |cffccaa00Keywords for Instance info|r",   },
    { "[instName]"      , "Instance name"   , "[difficulty]"    , "Size and Difficulty" },
    { "[progress]"      , "Killed"          , "[bosses]"        , "Total"       },
    { "[time]"          , "Time to reset"   , "[instID]"        , "Instance ID" },
}
-- World Boss
L["World Boss"]     = true
L["Galleon"]        = "G"
L["Sha of Anger"]   = "S"
L["Nalak"]          = "N"
L["Oondasta"]       = "O"
-- Heroic - MoP
L["H5_Shado-pan Monastery"]     = "SPM"
L["H5_Temple of the Jade Serpent"]  = "TJS"
L["H5_Stormstout Brewery"]      = "SSB"
L["H5_Gate of the Setting Sun"] = "GSS"
L["H5_Mogu'shan Palace"]        = "MsP"
L["H5_Scarlet Halls"]           = "SH"
L["H5_Scarlet Monastery"]       = "SM"
L["H5_Scholomance"]             = "Sch"
L["H5_Siege of Niuzao Temple"]  = "SNT"
-- Raid - MoP
L["R5_Mogu'shan Vaults"]        = "MsV"
L["R5_Heart of Fear"]           = "HoF"
L["R5_Terrace of Endless Spring"]   = "TES"
L["R5_Throne of Thunder"]       = "ToT"
L["R5_Siege of Orgrimmar"]      = "SoO"
-- Raid - Cataclysm
L["R4_Blackwing Descent"]       = "BWD"
L["R4_Bastion of Twilight"]     = "BoT"
L["R4_Throne of the Four Winds"]    = "T4W"
L["R4_Firelands"]               = "FL"
L["R4_Dragon Soul"]             = "DS"
L["R4_Baradin Hold"]            = "BH"
-- Raid - WotLK
L["R3_Naxxramas"]               = "Naxx"
L["R3_Obsidian Sanctum"]        = "OS"
L["R3_Eye of Eternity"]         = "EoE"
L["R3_Ulduar"]                  = "ULD"
L["R3_Onyxia's Lair"]           = "Ony"
L["R3_Trial of the Crusader"]   = "CC"
L["R3_Icecrown Citadel"]        = "IC"
L["R3_Ruby Sanctum"]            = "RS"
L["R3_Vault of Archavon"]       = "VoA"
-- Raid - TBC
L["R2_Sunwell Plateau"]         = "SP"
L["R2_Black Temple"]            = "BT"
L["R2_Battle for Mount Hyjal"]  = "Hyjal"
L["R2_Serpentshrine CavernC"]   = "SSC"
L["R2_The Eye"]                 = "TK"  -- Tempest Keep
L["R2_Karazhan"]                = "KZ"
L["R2_Gruul's Lair"]            = "Gruul"
L["R2_Magtheridon's Lair"]      = "Mag"
-- Raid - Vanilla
L["R1_Temple of Ahn'Qiraj"]     = "TAQ"
L["R1_Ruins of Ahn'Qiraj"]      = "RAQ"
L["R1_Blackwing Lair"]          = "BW"
L["R1_Molten Core"]             = "MC"
end
