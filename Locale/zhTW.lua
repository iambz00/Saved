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
L["worldbuff" ] = true
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
-- Usage
L["Usage_Character"] = {
    { "|cff00ff00■|r |cffccaa00使用方法 - 角色信息|r" },
    { "[name]"          , "名稱(職業顏色)"  , "[name2]"         , "名稱(無顏色)"  },
    { "[level]"         , "[expCur]"        , "[expMax]"        , "[exp%]"      },
    { "[expRest]"       , "[expRest%]"      , "[zone]"          , "[subzone]"   },
    { "[elapsed]"       , "自上次更新經過的時間", "[cooldown]"     , "專業技能冷卻時間"    },
    { "[item:name]"     , "[item:name]"     , "物品圖標和數量"  ,               },
    { "[dqCom]"         , "[dqMax]"         , "[dqReset]"       , "[playedtotal]"   },
    { "[ilvl]"          , "[ilvl_avg]"      , "[ilvl_equip]"    , "[playedlevel]"   },
    { "[color/|cffff0000##|r|cff00ff00##|r|cff0000ff##|r]"
                        , "顏色開始(RGB 代碼)", "[color]"         , "顏色結束"  },
    { " |cffff0000!|r 通過在末尾添加 /###### 著色",             },
    { "[currency:name]" , "[currency:ID]"   , "物品圖標和數量",     },
}
L["Usage_Instance"] = {
    { "|cff00ff00■|r |cffccaa00使用方法 - 副本信息|r",   },
    { "[instName]"      , "副本名稱"        , "[difficulty]"    , "大小和難度"  },
    { "[progress]"      , "BOSS擊殺數量"    , "[bosses]"        , "BOSS數量"       },
    { "[time]"          , "重置時間"        , "[instID]"        , "副本 ID" },
}
-- Raid abbr. Vanilla
L["R1_Naxxramas"] = "Naxx"
L["R1_Onyxia's Lair"]  = "Ony"
L["R1_Temple of Ahn'Qiraj"] = "TAQ"
L["R1_Ruins of Ahn'Qiraj"] = "RAQ"
L["R1_Blackwing Lair"] = "BW"
L["R1_Molten Core"] = "MC"
end
