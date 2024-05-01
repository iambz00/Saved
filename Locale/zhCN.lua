local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(AddonName, "zhCN")

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
L["Desc_Char"] = "|cff00ff00■|r |cffccaa00使用方法 - 角色信息|r|n"
    .."|cffccaa00[name]|r 名称(职业颜色)|n"
    .."|cffccaa00[name2]|r 名称(无颜色)|n"
    .."|cffccaa00[level] [expCur] [expMax] [exp%]|r|n"
    .."|cffccaa00[expRest] [expRest%] [zone] [subzone]|r|n"
    .."|cffccaa00[elapsed]|r 自上次更新经过的时间|n"
    .."|cffccaa00[item:|cffffeeaaname or ID|r]|r 图标和价格|n"
    .."|cffccaa00[cooldown]|r 专业技能冷却时间|n"
    .."|cffccaa00[dqCom] [dqMax]|r|n"
    .."|cffccaa00[dqReset]|r 日常任务重置时间|n"
    .."|cffccaa00[gs] [ilvl]|r|n"
    .."|cffccaa00[color/######]|r 颜色开始(RGB 代码)|n|cffccaa00[color]|r  颜色结束|n"
    .."  通過在末尾添加 /###### 著色|n"
    .."|cffffeeaa(例如) |r|cffccaa00[color/ffffff]白色[color] =>|r |cffffffff白色|r|n   |cffccaa00[item:6265|cffcc3333/cc66cc|r] => |r|cffcc66cc".."|T"..GetItemIcon(6265)..":14:14|t12|r|n"
    .."|cffccaa00[currency:|cffffeeaaname or ID|r]|r 图标和价格|n"
L["Tooltip - Raid instances"] = "提示 - 团本信息"
L["Lines of raid instances"] = "团本信息行"
L["Desc_Inst"] = "|cff00ff00■|r |cffccaa00使用方法 - 副本信息|r|n"
    .."|cffccaa00[instName]|r 副本名称|n"
    .."|cffccaa00[difficulty]|r 大小和难度|n"
    .."|cffccaa00[progress]|r BOSS击杀数量|n"
    .."|cffccaa00[bosses]|r BOSS数量|n"
    .."|cffccaa00[time]|r 重置时间|n"
    .."|cffccaa00[instID]|r 副本 ID|n"
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
L["sidereal"] = true
L["defilers"] = true
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
