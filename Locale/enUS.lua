local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(AddonName, "enUS", true)

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
L["Desc_Char"] = "|cff00ff00■|r |cffccaa00Keywords for Character info|r|n"
    .."|cffccaa00[name]|r Name(Class color)|n"
    .."|cffccaa00[name2]|r Name(No color)|n"
    .."|cffccaa00[level] [expCur] [expMax] [exp%]|r|n"
    .."|cffccaa00[expRest] [expRest%] [zone] [subzone]|r|n"
    .."|cffccaa00[elapsed]|r Elapsed time after last update|n"
    .."|cffccaa00[item:|cffffeeaaname or ID|r]|r Item Icon and Count|n"
    .."|cffccaa00[cooldown]|r Tradeskill cooldowns|n"
    .."|cffccaa00[dqCom] [dqMax]|r|n"
    .."|cffccaa00[dqReset]|r Time left until DQ reset|n"
    .."|cffccaa00[gs] [ilvl]|r|n"
    .."|cffccaa00[color/######]|r Color starts(RGB code)|n|cffccaa00[color]|r Color ends|n"
    .."  attach /###### to apply color|n"
    .."|cffffeeaa(ex) |r|cffccaa00[color/ffffff]WHITE[color] =>|r |cffffffffWHITE|r|n   |cffccaa00[item:6265|cffcc3333/cc66cc|r] => |r|cffcc66cc".."|T"..GetItemIcon(6265)..":14:14|t12|r|n"
    .."|cffccaa00[currency:|cffffeeaaname or ID|r]|r Currency Icon and Count|n"
L["Tooltip - Raid instances"] = true
L["Lines of raid instances"] = true
L["Desc_Inst"] = "|cff00ff00■|r |cffccaa00Keywords for Instance info|r|n"
    .."|cffccaa00[instName]|r Instance name|n"
    .."|cffccaa00[difficulty]|r Size and Difficulty|n"
    .."|cffccaa00[progress]|r Number of bosses killed|n"
    .."|cffccaa00[bosses]|r Number of bosses|n"
    .."|cffccaa00[time]|r Time to reset|n"
    .."|cffccaa00[instID]|r Instance ID|n"
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
L["dqMax"     ] = true
L["dqReset"   ] = true
L["gs"        ] = true
L["ilvl"      ] = true
L["instName"  ] = true
L["instID"    ] = true
L["difficulty"] = true
L["progress"  ] = true
L["bosses"    ] = true
L["time"      ] = true
-- Localized Currency Name
L["gold"    ] = true
L["silver"  ] = true
L["copper"  ] = true
L["honor"   ] = true
L["arena"   ] = true
L["conquest"] = true
L["jewel"   ] = true
L["cook"    ] = true
L["JP"      ] = true
L["VP"      ] = true
L["TBC"     ] = true
L["AF1"     ] = true
L["AF2"     ] = true
L["AF3"     ] = true
L["AF4"     ] = true
L["AF5"     ] = true
L["AF6"     ] = true
L["AF7"     ] = true
L["AF8"     ] = true
L["AF9"     ] = true
L["MOW"     ] = true
L["CAM"     ] = true
L["CRB"     ] = true
L["DPT"     ] = true
L["MOD"     ] = true
L["EOC"     ] = true
-- Heroic dungeon names, abbrs
L["H4_BRC"] = true
L["H4_ToT"] = true
L["H4_VP" ] = true
L["H4_SC" ] = true
L["H4_LCT"] = true
L["H4_HoO"] = true
L["H4_GB" ] = true
L["H4_ET" ] = true
L["H4_WoE"] = true
L["H4_HoT"] = true
L["H4_DM" ] = true
L["H4_SFK"] = true
L["H4_ZG" ] = true
L["H4_ZA" ] = true
-- Raid abbr. Cataclysm
L["R4_BWD"] = true
L["R4_BoT"] = true
L["R4_TFW"] = true
L["R4_FL" ] = true
L["R4_DS" ] = true
L["R4_BH" ] = true
-- Heroic abbr. WotLK
L["H3_TOK"] = true
L["H3_AN" ] = true
L["H3_DTK"] = true
L["H3_Gun"] = true
L["H3_HoL"] = true
L["H3_HoS"] = true
L["H3_CoS"] = true
L["H3_Nex"] = true
L["H3_Ocu"] = true
L["H3_VH" ] = true
L["H3_UK" ] = true
L["H3_UP" ] = true
L["H3_ToCh"] = "ToC"
L["H3_HoR"] = true
L["H3_PoS"] = true
L["H3_FoS"] = true
-- Raid abbr. WotLK
L["R3_Naxx"] = true
L["R3_OS"]   = true
L["R3_EoE"]  = true
L["R3_ULD"]  = true
L["R3_Ony"]  = true
L["R3_ToC"]  = true
L["R3_ICC"]  = true
L["R3_RS"]   = true
L["R3_VoA"]  = true
-- Raid abbr. TBC
L["R2_SP"] = true
L["R2_BT"] = true
L["R2_MH"] = true
L["R2_SC"] = true
L["R2_TK"] = true
L["R2_KZ"] = true
L["R2_GL"] = true
L["R2_ML"] = true
-- Raid abbr. Vanilla
L["R1_AQ"] = true
L["R1_RA"] = true
L["R1_BW"] = true
L["R1_MC"] = true
end
