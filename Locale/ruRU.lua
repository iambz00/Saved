local addonName, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ruRU")

if L then
L["Transmute"] = "Трансмутация"

L["Reset due to update"] = function(oldv, newv) return "Сброс некоторых или всех данных из-за обновления версии ("..oldv.." -> "..newv.. ")" end
L["extended"] = "(расширение)"

L["minites"] = "м"
L["Enabled"] = "Включено"
L["Disabled"] = "Отключено"

L["Raid Table Notice"] = "ЛКМ — открыть таблицу рейдов, ПКМ — открыть настройки"
L["Display settings"] = "Настройки отображения"
L["Desc - Common"] = "|cff00ff00■|r |cffccaa00Все настройки сохраняются [для каждого персонажа]|r"
L["Show floating UI frame"] = "Показать всплывающее окно интерфейса"
L["Floating UI width"] = "Ширина всплывающего окна"
L["Floating UI height"] = "Высота всплывающего окна"
L["Desc - Frame"] = "|cff00ff00■|r |cffccaa00Shift — перетаскивание для перемещения окна|r"
L["Show minimap icon"] = "Показать значок на миникарте"
L["Show info"] = "Показать информационное окно"
L["per Character"] = "Для каждого персонажа"
L["per Realm"] = "Для каждого сервера"
L["Show total gold"] = "Показать общее количество золота"
L["Hide info from level under"] = "Скрыть информацию для уровней ниже"
L["Show current chracter first"] = "Показать текущего персонажа первым"
L["Sort Order"] = "Порядок сортировки"
L["Sort Option"] = "Параметры сортировки"
L["Exclude Characters"] = "Исключить персонажей (разделять запятой или пробелом)"
L["Descending"] = "По убыванию"
L["Asscending"] = "По возрастанию"
L["Tooltip - Character info."] = "Информация о персонаже во всплывающей подсказке"
L["Line 1 of char info."] = "Первая строка информации о специализации персонажа"
L["Line 2 of char info."] = "Вторая строка информации о специализации персонажа"
L["Left"] = "Слева"
L["Right"] = "Справа"
L["Tooltip - Raid instances"] = "Всплывающая подсказка — рейдовые подземелья"
L["Lines of raid instances"] = "Строки для рейдовых подземелий"
L["Tooltip - Heroic instances"] = "Всплывающая подсказка — героические подземелья"
L["Lines of heroic instances"] = "Строки для героических подземелий"
L["Show in one-line"] = "Показать в одной строке"

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
    { "|cff00ff00■|r |cffccaa00Использование - Информация о персонаже|r" },
    { "[name]"          , "Имя (цвет класса)", "[name2]"        , "Имя (без цвета)"  },
    { "[level]"         , "[expCur]"        , "[expMax]"        , "[exp%]"      },
    { "[expRest]"       , "[expRest%]"      , "[zone]"          , "[subzone]"   },
    { "[elapsed]"       , "Прошедшее время после последнего обновления", "[cooldown]"     , "Перезарядка навыков профессии"    },
    { "[item:aимя]"     , "[item:name]"     , "значок и количество",            },
    { "[dqCom]"         , "[dqMax]"         , "[dqReset]"       , "[playedtotal]" },
    { "[ilvl]"          , "[ilvl_avg]"      , "[ilvl_equip]"    , "[playedlevel]" },
    { "[color/|cffff0000##|r|cff00ff00##|r|cff0000ff##|r]"
                        , "Цвет начала(RGB кодировка)", "[color]"         , "Цвет окончания"   },
    { " |cffff0000!|r Цвет, добавляя /###### в конец",             },
    { "[currency:имя]"  , "[currency:ID]"   , "значок и количество",  },
    { " |cffff0000!|r Valor/Conquest Style" ,  "", "[currency:VP-3]", "|T463447:14:14|t960(4460/9600)"   },
    { "[currency:VP-2]" , "|T463447:14:14|t960(|cFFFF75755140|r)", "[currency:VP-1]"   , "|T463447:14:14|t960(-5140)"   },
}
L["Usage_Instance"] = {
    { "|cff00ff00■|r |cffccaa00Использование - Информация о подземелье|r",   },
    { "[instName]"      , "Название подземелья", "[difficulty]"    , "Размер и сложность" },
    { "[progress]"      , "Количество убитых боссов", "[bosses]"        , "Количество боссов"       },
    { "[time]"          , "Время сброса"   , "[instID]"        , "ID подземелья" },
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
