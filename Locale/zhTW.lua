local addonName, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhTW")

if L then
L["Transmute"] = "轉換"

L["Reset due to update"] = function(oldv, newv) return "因版本更新而重置部分或者全部數據 ("..oldv.." -> "..newv.. ")" end
L["extended"] = "(擴展)"

L["minites"] = "分鐘"
L["Enabled"] = "啟用"
L["Disabled"] = "禁用"

L["Raid Table Notice"] = "左鍵點擊打開進度表格, 右鍵點擊打開設置"
L["DISPLAY"] = "顯示"
L["TOOLTIP_SCALE"] = "Tooltip Scale(%)"
L["FLOAT_UI"] = "懸浮窗"
L["FLOAT_UI_W"] = "懸浮窗寬度"
L["FLOAT_UI_H"] = "懸浮窗高度"
L["FLOAT_UI_DESCRIPTION"] = "|cff00ff00■|r |cffccaa00Shift - 拖動來移動框架|r"
L["MINIMAP_ICON"] = "顯示小地圖按鈕"
L["DISPLAY_SCOPE"] = "顯示範圍"
L["Character"] = "角色"
L["Realm"] = "伺服器"
L["Account"] = "帳號"
L["TOTAL_GOLD"] = "總金"
L["HIDE_LEVEL"] = "低於等級隱藏信息"
L["CURRENT_1ST"] = "優先顯示當前角色"
L["SORT_BY"] = "排序依據"
L["SORT_ORDER"] = "排序順序"
L["Descending"] = "降序"
L["Asscending"] = "升序"
L["EXCLUDE"] = "不想看見的角色(用英文逗號或者空格分隔)"
L["TOOLTIP"] = "提示"
L["TOOLTIP_CHARACTER"] = "提示 - 角色信息"
L["INFO1"] = "角色信息第一行"
L["INFO2"] = "角色信息第二行"
L["Left"] = "左"
L["Right"] = "右"
L["TOOLTIP_RAID"] = "提示 - 團本信息"
L["INFO3"] = "團本信息行"
L["TOOLTIP_HEROIC"] = "提示 - 英雄本信息"
L["INFO4"] = "英雄本信息行"
L["INFO_SHORT"] = "單行顯示"

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
    { "[name]"          , "名稱(職業顏色)"  , "[name2]"         , "名稱(無顏色)"  },
    { "[level]"         , "[expCur]"        , "[expMax]"        , "[exp%]"      },
    { "[expRest]"       , "[expRest%]"      , "[zone]"          , "[subzone]"   },
    { "[elapsed]"       , "自上次更新經過的時間", "[cooldown]"     , "專業技能冷卻時間"    },
    { "[item:name]"     , "[item:name]"     , "物品圖標和數量"  ,               },
    { "[dqCom]"         , "[dqReset]"       ,   },
    { "[ilvl]"          , "[ilvl_avg]"      , "[ilvl_equip]"    ,   },
    { "[color/|cffff0000##|r|cff00ff00##|r|cff0000ff##|r]"
                        , "顏色開始(RGB 代碼)", "[color]"         , "顏色結束"  },
    { " |cffff0000!|r 通過在末尾添加 /###### 著色",             },
    { "[currency:name]" , "物品圖標和數量"  ,   },
}
L["Usage_Instance"] = {
    { "|cff00ff00■|r |cffccaa00使用方法 - 副本信息|r",   },
    { "[instName]"      , "副本名稱"        , "[difficulty]"    , "大小和難度"  },
    { "[progress]"      , "BOSS擊殺數量"    , "[bosses]"        , "BOSS數量"       },
    { "[time]"          , "重置時間"        , "[instID]"        , "副本 ID" },
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
L["Mogu'shan Vaults"            ] = "魔古山寶庫"
L["Heart of Fear"               ] = "恐懼之心"
L["Terrace of Endless Spring"   ] = "豐泉台"
L["Throne of Thunder"           ] = "雷霆王座"
L["Siege of Orgrimmar"          ] = "圍攻奧格瑪"
L["Dragon Soul"                 ] = "巨龍之魂"
L["Firelands"                   ] = "火源之界"
L["Throne of the Four Winds"    ] = "四風王座"
L["Blackwing Descent"           ] = "黑翼陷窟"
L["The Bastion of Twilight"     ] = "暮光堡壘"
L["Baradin Hold"                ] = "巴拉丁堡"
L["Icecrown Citadel"            ] = "冰冠城塞"
L["The Ruby Sanctum"            ] = "晶紅聖所"
L["Trial of the Crusader"       ] = "十字軍試煉"
L["Ulduar"                      ] = "奧杜亞"
L["Naxxramas"                   ] = "納克薩瑪斯"
L["The Eye of Eternity"         ] = "永恆之眼"
L["The Obsidian Sanctum"        ] = "黑曜聖所"
L["Onyxia's Lair"               ] = "奧妮克希亞的巢穴"
L["Vault of Archavon"           ] = "亞夏梵穹殿"
L["The Sunwell"                 ] = "太陽之井"
L["Black Temple"                ] = "黑暗神廟"
L["-Hyjal"                      ] = "海加爾山之戰"
L["-Serpentshrine Cavern"       ] = "盤牙:毒蛇神殿洞穴"
L["Tempest Keep"                ] = "風暴要塞"
L["Karazhan"                    ] = "卡拉贊"
L["Gruul's Lair"                ] = "戈魯爾之巢"
L["Magtheridon's Lair"          ] = "瑪瑟里頓的巢穴"
L["Ahn'Qiraj Temple"            ] = "安其拉神廟"
L["Ruins of Ahn'Qiraj"          ] = "安其拉廢墟"
L["Blackwing Lair"              ] = "黑翼之巢"
L["Molten Core"                 ] = "熔火之心"

end
