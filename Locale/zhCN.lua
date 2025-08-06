local addonName, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN")

if L then
L["Transmute"] = "转换"

L["Reset due to update"] = function(oldv, newv) return "因版本更新而重置部分或全部数据 ("..oldv.." -> "..newv.. ")" end
L["extended"] = "(扩展)"

L["minites"] = "分钟"
L["Enabled"] = "启用"
L["Disabled"] = "禁用"

L["Raid Table Notice"] = "左键点击打开表格, 右键点击打开设置"
L["Display settings"] = "显示设置"
L["Desc - Common"] = "|cff00ff00■|r |cffccaa00每个配置已保存 [单角色]|r"
L["Show floating UI frame"] = "显示悬浮窗"
L["Floating UI width"] = "悬浮窗宽度"
L["Floating UI height"] = "悬浮窗高度"
L["Desc - Frame"] = "|cff00ff00■|r |cffccaa00Shift - 拖动来移动框架|r"
L["Show minimap icon"] = "显示小地图按钮"
L["Show info"] = "显示信息"
L["per Character"] = "单角色"
L["per Realm"] = "单服务器"
L["Show total gold"] = "顯示總金"
L["Hide info from level under"] = "低于等级隐藏信息"
L["Show current chracter first"] = true
L["Sort Order"] = true
L["Sort Option"] = true
L["Exclude Characters"] = "不想看见的角色(用英文逗号或者空格分割)"
L["Descending"] = true
L["Asscending"] = true
L["Tooltip - Character info."] = "提示 - 角色信息"
L["Line 1 of char info."] = "角色信息第一行"
L["Line 2 of char info."] = "角色信息第二行"
L["Left"] = "左"
L["Right"] = "右"
L["Tooltip - Raid instances"] = "提示 - 团本信息"
L["Lines of raid instances"] = "团本信息行"
L["Tooltip - Heroic instances"] = "提示 - 英雄本信息"
L["Lines of heroic instances"] = "英雄本信息行"
L["Show in one-line"] = "单行显示"

L["Select character"] = "选择角色"
L["Reset selected character"] = "重置选择的角色"
L["Are you really want to reset?"] = "你确定要重置吗？"
L["Reset all characters"] = "重置所有角色"
L["Copy settings to"] = "复制设置到"
L["Copy"] = "复制"
L["Confirm copy"] = "将设置覆盖到目标角色上"

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
    { "|cff00ff00■|r |cffccaa00使用方法 - 角色信息|r" },
    { "[name]"          , "名称(职业颜色)"  , "[name2]"         , "名称(无颜色)"    },
    { "[level]"         , "[expCur]"        , "[expMax]"        , "[exp%]"      },
    { "[expRest]"       , "[expRest%]"      , "[zone]"          , "[subzone]"   },
    { "[elapsed]"       , "自上次更新经过的时间", "[cooldown]"     , "专业技能冷却时间"    },
    { "[item:name]"     , "[item:name]"     , "图标和价格",            },
    { "[dqCom]"         , "[dqReset]"       , "[playedtotal]"   , "[playedlevel]" },
    { "[ilvl]"          , "[ilvl_avg]"      , "[ilvl_equip]"    ,   },
    { "[color/|cffff0000##|r|cff00ff00##|r|cff0000ff##|r]"
                        , "颜色开始(RGB 代码)", "[color]"         , "颜色结束"   },
    { " |cffff0000!|r 通過在末尾添加 /###### 著色",             },
    { "[currency:name]" , "[currency:ID]"   , "图标和价格",  },
    { " |cffff0000!|r Valor/Conquest Style" ,  "", "[currency:VP-3]", "|T463447:14:14|t960(4460/9600)"   },
    { "[currency:VP-2]" , "|T463447:14:14|t960(|cFFFF75755140|r)", "[currency:VP-1]"   , "|T463447:14:14|t960(-5140)"   },
}
L["Usage_Instance"] = {
    { "|cff00ff00■|r |cffccaa00Keywords for Instance info|r",   },
    { "[instName]"      , "副本名称"        , "[difficulty]"    , "大小和难度"  },
    { "[progress]"      , "BOSS击杀数量"    , "[bosses]"        , "BOSS数量"    },
    { "[time]"          , "重置时间"        , "[instID]"        , "副本 ID"     },
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
