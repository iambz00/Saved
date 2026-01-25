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
L["DISPLAY"] = "显示"
L["TOOLTIP_SCALE"] = "Tooltip Scale(%)"
L["FLOAT_UI"] = "悬浮窗"
L["FLOAT_UI_W"] = "悬浮窗宽度"
L["FLOAT_UI_H"] = "悬浮窗高度"
L["FLOAT_UI_DESCRIPTION"] = "|cff00ff00■|r |cffccaa00Shift - 拖动来移动框架|r"
L["MINIMAP_ICON"] = "显示小地图按钮"
L["DISPLAY_SCOPE"] = "显示范围"
L["Character"] = "角色"
L["Realm"] = "服务器"
L["Account"] = "账号"
L["TOTAL_GOLD"] = "總金"
L["HIDE_LEVEL"] = "低于等级隐藏信息"
L["CURRENT_1ST"] = "当前角色优先"
L["SORT_BY"] = "排序依据"
L["SORT_ORDER"] = "排序顺序"
L["Descending"] = "降序"
L["Ascending"] = "升序"
L["EXCLUDE"] = "不想看见的角色(用英文逗号或者空格分割)"
L["TOOLTIP"] = "提示"
L["TOOLTIP_CHARACTER"] = "提示 - 角色信息"
L["INFO1"] = "角色信息第一行"
L["INFO2"] = "角色信息第二行"
L["Left"] = "左"
L["Right"] = "右"
L["TOOLTIP_RAID"] = "提示 - 团本信息"
L["INFO3"] = "团本信息行"
L["TOOLTIP_HEROIC"] = "提示 - 英雄本信息"
L["INFO4"] = "英雄本信息行"
L["INFO_SHORT"] = "单行显示"

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
    { "|cff00ff00■|r |cffccaa00使用方法 - 角色信息|r" },
    { "[name]"          , "名称(职业颜色)"  , "[name2]"         , "名称(无颜色)"    },
    { "[level]"         , "[expCur]"        , "[expMax]"        , "[exp%]"      },
    { "[expRest]"       , "[expRest%]"      , "[zone]"          , "[subzone]"   },
    { "[elapsed]"       , "自上次更新经过的时间", "[cooldown]"     , "专业技能冷却时间"    },
    { "[item:name]"     , "[item:name]"     , "图标和价格",            },
    { "[dqCom]"         , "[dqReset]"       ,   },
    { "[ilvl]"          , "[ilvl_avg]"      , "[ilvl_equip]"    ,   },
    { "[color/|cffff0000##|r|cff00ff00##|r|cff0000ff##|r]"
                        , "颜色开始(RGB 代码)", "[color]"         , "颜色结束"   },
    { " |cffff0000!|r 通過在末尾添加 /###### 著色",             },
    { "[currency:name]" , "图标和价格"      ,  },
}
L["Usage_Instance"] = {
    { "|cff00ff00■|r |cffccaa00Keywords for Instance info|r",   },
    { "[instName]"      , "副本名称"        , "[difficulty]"    , "大小和难度"  },
    { "[progress]"      , "BOSS击杀数量"    , "[bosses]"        , "BOSS数量"    },
    { "[time]"          , "重置时间"        , "[instID]"        , "副本 ID"     },
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
L["Mogu'shan Vaults"            ] = "魔古山宝库"
L["Heart of Fear"               ] = "恐惧之心"
L["Terrace of Endless Spring"   ] = "永春台"
L["Throne of Thunder"           ] = "雷电王座"
L["Siege of Orgrimmar"          ] = "决战奥格瑞玛"
L["Dragon Soul"                 ] = "巨龙之魂"
L["Firelands"                   ] = "火焰之地"
L["Throne of the Four Winds"    ] = "风神王座"
L["Blackwing Descent"           ] = "黑翼血环"
L["The Bastion of Twilight"     ] = "暮光堡垒"
L["Baradin Hold"                ] = "巴拉丁监狱"
L["Icecrown Citadel"            ] = "冰冠堡垒"
L["The Ruby Sanctum"            ] = "红玉圣殿"
L["Trial of the Crusader"       ] = "十字军的试炼"
L["Ulduar"                      ] = "奥杜尔"
L["Naxxramas"                   ] = "纳克萨玛斯"
L["The Eye of Eternity"         ] = "永恒之眼"
L["The Obsidian Sanctum"        ] = "黑曜石圣殿"
L["Onyxia's Lair"               ] = "奥妮克希亚的巢穴"
L["Vault of Archavon"           ] = "阿尔卡冯的宝库"
L["The Sunwell"                 ] = "太阳之井"
L["Black Temple"                ] = "黑暗神殿"
L["-Hyjal"                      ] = "海加尔山之战"
L["-Serpentshrine Cavern"       ] = "盘牙湖泊：毒蛇神殿"
L["Tempest Keep"                ] = "风暴要塞"
L["Karazhan"                    ] = "卡拉赞"
L["Gruul's Lair"                ] = "格鲁尔的巢穴"
L["Magtheridon's Lair"          ] = "玛瑟里顿的巢穴"
L["Ahn'Qiraj Temple"            ] = "安其拉神殿"
L["Ruins of Ahn'Qiraj"          ] = "安其拉废墟"
L["Blackwing Lair"              ] = "黑翼之巢"
L["Molten Core"                 ] = "熔火之心"

end
