local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(AddonName, "ruRU")

if L then
L["Transmute"] = "Трансмутация"

L["Reset due to update"] = function(oldv, newv) return "Сброс некоторых или всех данных из-за обновления версии ("..oldv.." -> "..newv.. ")" end
L["extended"] = "(расширение)"

L["minites"] = "м"
L["Enabled"] = "Включено"
L["Disabled"] = "Отключено"

L["Raid Table Notice"] = "L-Click to open Raid table, R-Click to open Options"
L["Display settings"] = "Настройки отображения"
L["Desc - Common"] = "|cff00ff00■|r |cffccaa00Every options are saved [per chracter]|r"
L["Show floating UI frame"] = "Показать всплывающее окно"
L["Floating UI width"] = "Ширина окна"
L["Floating UI height"] = "Высота окна"
L["Desc - Frame"] = "|cff00ff00■|r |cffccaa00Shift - Перетаскивание для перемещения окна|r"
L["Show minimap icon"] = "Показать значок на миникарте"
L["Show info"] = "Информационное окно"
L["per Character"] = "По персонажу"
L["per Realm"] = "По серверу"
L["Show total gold"] = "показать общее золото"
L["Hide info from level under"] = "Скрыть информацию с уровня ниже"
L["Show current chracter first"] = true
L["Sort Order"] = true
L["Sort Option"] = true
L["Exclude Characters"] = "Exclude Characters(Separate by , or space)"
L["Descending"] = true
L["Asscending"] = true
L["Tooltip - Character info."] = "Информация, относящаяся к параметру всплывающей подсказки" --"Информация для персонажа"
L["Line 1 of char info."] = "Первая строка с информацией по специализации персонажа"
L["Line 2 of char info."] = "Вторая строка с информацией по специализации персонажа"
L["Left"] = "Лево"
L["Right"] = "Право"
L["Desc_Char"] = "|cff00ff00■|r |cffccaa00Использование - Информация о персонаже|r|n"
    .."|cffccaa00[name]|r Имя (цвет класса)|n"
    .."|cffccaa00[name2]|r Имя (без цвета)|n"
    .."|cffccaa00[level] [expCur] [expMax] [exp%]|r|n"
    .."|cffccaa00[expRest] [expRest%] [zone] [subzone]|r|n"
    .."|cffccaa00[elapsed]|r Прошедшее время после последнего обновления|n"
    .."|cffccaa00[item:|cffffeeaaимя на ID|r]|r значок и количество|n"
    .."|cffccaa00[cooldown]|r Перезарядка навыков профессии|n"
    .."|cffccaa00[dqCom] [dqMax]|r|n"
    .."|cffccaa00[dqReset]|r Time left until DQ Reset|n"
    .."|cffccaa00[gs] [ilvl]|r|n"
    .."|cffccaa00[color/######]|r Цвет начала(RGB кодировка)|n|cffccaa00[color]|r Цвет окончания|n"
    .."  Цвет, добавляя /###### в конец|n"
    .."|cffffeeaa(ex) |r|cffccaa00[color/ffffff]Белый[color] =>|r |cffffffffБелый|r|n   |cffccaa00[item:6265|cffcc3333/cc66cc|r] => |r|cffcc66cc".."|T"..GetItemIcon(6265)..":14:14|t12|r|n"
    .."|cffccaa00[currency:|cffffeeaaимя на ID|r]|r значок и количество|n"
L["Tooltip - Raid instances"] = true
L["Lines of raid instances"] = true
L["Desc_Inst"] = "|cff00ff00■|r |cffccaa00Использование - Информация о подземелье|r|n"
    .."|cffccaa00[instName]|r Название подземелья|n"
    .."|cffccaa00[difficulty]|r Размер и сложность|n"
    .."|cffccaa00[progress]|r Количество убитых боссов|n"
    .."|cffccaa00[bosses]|r Количество боссов|n"
    .."|cffccaa00[time]|r Время сброса|n"
    .."|cffccaa00[instID]|r ID подземелья|n"
L["Tooltip - Heroic instances"] = true
L["Lines of heroic instances"] = true
L["Show in one-line"] = "Показать в одну строку"

L["Select character"] = "Выбор персонажа"
L["Reset selected character"] = "Сбросить выбранного персонажа"
L["Are you really want to reset?"] = "Вы действительно хотите сбросить настройки?"
L["Reset all characters"] = "Сбросить всех персонажей"
L["Copy settings to"] = "Настройки копирования на"
L["Copy"] = "Копировать"
L["Confirm copy"] = "Настройки копирования перезапишут информацию о персонаже/подземелье."

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
