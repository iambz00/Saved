local addonName, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ruRU")

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
    .."|cffffeeaa(ex) |r|cffccaa00[color/ffffff]Белый[color] =>|r |cffffffffБелый|r|n   |cffccaa00[item:6265|cffcc3333/cc66cc|r] => |r|cffcc66cc".."|T"..C_Item.GetItemIconByID(6265)..":14:14|t12|r|n"
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
