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
L["Display settings"] = "顯示設置"
L["Desc - Common"] = "|cff00ff00■|r |cffccaa00每個配置已保存 [單角色]|r"
L["Show floating UI frame"] = "顯示懸浮窗"
L["Floating UI width"] = "懸浮窗寬度"
L["Floating UI height"] = "懸浮窗高度"
L["Desc - Frame"] = "|cff00ff00■|r |cffccaa00Shift - 拖動來移動框架|r"
L["Show minimap icon"] = "顯示小地圖按鈕"
L["Show info"] = "顯示信息"
L["per Character"] = "單角色"
L["per Realm"] = "單服務器"
L["Show total gold"] = "顯示總金"
L["Hide info from level under"] = "低於等級隱藏信息"
L["Show current chracter first"] = "優先顯示當前角色"
L["Sort Order"] = true
L["Sort Option"] = true
L["Exclude Characters"] = "不想看見的角色(用英文逗號或者空格分隔)"
L["Descending"] = true
L["Asscending"] = true
L["Tooltip - Character info."] = "提示 - 角色信息"
L["Line 1 of char info."] = "角色信息第一行"
L["Line 2 of char info."] = "角色信息第二行"
L["Left"] = "左"
L["Right"] = "右"
L["Tooltip - Raid instances"] = "提示 - 團本信息"
L["Lines of raid instances"] = "團本信息行"
L["Tooltip - Heroic instances"] = "提示 - 英雄本信息"
L["Lines of heroic instances"] = "英雄本信息行"
L["Show in one-line"] = "單行顯示"

L["Select character"] = "選擇角色"
L["Reset selected character"] = "重置選擇的角色"
L["Are you really want to reset?"] = "你確定要重置嗎？"
L["Reset all characters"] = "重置所有角色"
L["Copy settings to"] = "複製設定到"
L["Copy"] = "複製"
L["Confirm copy"] = "將設置覆蓋到目標角色上"

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
L["conquest"] = true
L["jewel"   ] = true
L["cook"    ] = true
L["JP"      ] = true
L["VP"      ] = true
L["TBC"     ] = true
L["MOW"     ] = true
L["CAM"     ] = true
L["CRB"     ] = true
L["DPT"     ] = true
L["MOD"     ] = true
L["EOC"     ] = true
L["FS"      ] = true
L["OF"      ] = true
-- Usage
L["Usage_Character"] = {
    { "|cff00ff00■|r |cffccaa00使用方法 - 角色信息|r" },
    { "[name]"          , "名稱(職業顏色)"  , "[name2]"         , "名稱(無顏色)"  },
    { "[level]"         , "[expCur]"        , "[expMax]"        , "[exp%]"      },
    { "[expRest]"       , "[expRest%]"      , "[zone]"          , "[subzone]"   },
    { "[elapsed]"       , "自上次更新經過的時間", "[cooldown]"     , "專業技能冷卻時間"    },
    { "[item:name]"     , "[item:name]"     , "物品圖標和數量"  ,               },
    { "[dqCom]"         , "[dqMax]"         , "[dqReset]"       , "[playedtotal]" },
    { "[ilvl]"          , "[ilvl_avg]"      , "[ilvl_equip]"    , "[playedlevel]" },
    { "[color/|cffff0000##|r|cff00ff00##|r|cff0000ff##|r]"
                        , "顏色開始(RGB 代碼)", "[color]"         , "顏色結束"  },
    { " |cffff0000!|r 通過在末尾添加 /###### 著色",             },
    { "[currency:name]" , "[currency:ID]"   , "物品圖標和數量",     },
    { " |cffff0000!|r Valor/Conquest Style" ,  "", "[currency:VP-3]", "|T463447:14:14|t960(4460/9600)"   },
    { "[currency:VP-2]" , "|T463447:14:14|t960(|cFFFF75755140|r)", "[currency:VP-1]"   , "|T463447:14:14|t960(-5140)"   },
}
L["Usage_Instance"] = {
    { "|cff00ff00■|r |cffccaa00使用方法 - 副本信息|r",   },
    { "[instName]"      , "副本名稱"        , "[difficulty]"    , "大小和難度"  },
    { "[progress]"      , "BOSS擊殺數量"    , "[bosses]"        , "BOSS數量"       },
    { "[time]"          , "重置時間"        , "[instID]"        , "副本 ID" },
}
-- Heroic abbr. Cataclysm
L["H4_Blackrock Caverns"] = "BRC"
L["H4_Throne of the Tides"] = "ToT"
L["H4_Vortex Pinnacle"] = "VP"
L["H4_The Stonecore"] = "SC"
L["H4_Lost City of the Tol'vir"] = "LCT"
L["H4_Halls of Origination"] = "HoO"
L["H4_Grim Batol"] = "GB"
L["H4_End Time"] = "ET"
L["H4_Well of Eternity"] = "WotE"
L["H4_Hour of Twilight"] = "HoT"
L["H4_Deadmines"] = "DM"
L["H4_Shadowfang Keep"] = "SFK"
L["H4_Zul'Gurub"] = "ZG"
L["H4_Zul'Aman"] = "ZA"
-- Raid abbr. Cataclysm
L["R4_Blackwing Descent"] = "BWD"
L["R4_Bastion of Twilight"] = "BoT"
L["R4_Throne of the Four Winds"] = "T4W"
L["R4_Firelands"] = "FL"
L["R4_Dragon Soul"] = "DS"
L["R4_Baradin Hold"] = "BH"
-- Heroic abbr. WotLK
L["H3_Ahn'kahet: The Old Kingdom"] = "AK"
L["H3_Azjol-Nerub"] = "AN"
L["H3_Drak'Tharon Keep"] = "DTK"
L["H3_Gundrak"] = "Gun"
L["H3_Halls of Lightning"] = "HoL"
L["H3_Halls of Stone"] = "HoS"
L["H3_Culling of Stratholme"] = "CoStrat"
L["H3_The Nexus"] = "Nex"
L["H3_The Oculus"] = "Ocu"
L["H3_Violet Hold"] = "VH"
L["H3_Utgarde Keep"] = "UK"
L["H3_Utgarde Pinnacle"] = "UP"
L["H3_Trial of the Champion"] = "ToC"
L["H3_Halls of Reflection"] = "HoR"
L["H3_Pit of Saron"] = "PoS"
L["H3_Forge of Souls"] = "FoS"
-- Raid abbr. WotLK
L["R3_Naxxramas"] = "Naxx"
L["R3_Obsidian Sanctum"]  = "OS"
L["R3_Eye of Eternity"]  = "EoE"
L["R3_Ulduar"]  = "ULD"
L["R3_Onyxia's Lair"]  = "Ony"
L["R3_Trial of the Crusader"]  = "CC"
L["R3_Icecrown Citadel"]  = "IC"
L["R3_Ruby Sanctum"]  = "RS"
L["R3_Vault of Archavon"]  = "VoA"
-- Raid abbr. TBC
L["R2_Sunwell Plateau"] = "SP"
L["R2_Black Temple"] = "BT"
L["R2_Battle for Mount Hyjal"] = "Hyjal"
L["R2_Serpentshrine CavernC"] = "SSC"
L["R2_The Eye"] = "TK"  -- Tempest Keep
L["R2_Karazhan"] = "KZ"
L["R2_Gruul's Lair"] = "Gruul"
L["R2_Magtheridon's Lair"] = "Mag"
-- Raid abbr. Vanilla
L["R1_Temple of Ahn'Qiraj"] = "TAQ"
L["R1_Ruins of Ahn'Qiraj"] = "RAQ"
L["R1_Blackwing Lair"] = "BW"
L["R1_Molten Core"] = "MC"
end
