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
L["DISPLAY"] = "отображения"
L["TOOLTIP_SCALE"] = "Установить масштаб подсказки (%)"
L["FLOAT_UI"] = "всплывающее окно"
L["FLOAT_UI_W"] = "Ширина всплывающего окна"
L["FLOAT_UI_H"] = "Высота всплывающего окна"
L["FLOAT_UI_DESCRIPTION"] = "|cff00ff00■|r |cffccaa00Shift — перетаскивание для перемещения окна|r"
L["MINIMAP_ICON"] = "Показать значок на миникарте"
L["DISPLAY_SCOPE"] = "Область отображения"
L["Character"] = "Персонаж"
L["Realm"] = "Сервер"
L["Account"] = "Учётная запись"
L["TOTAL_GOLD"] = "общее количество золота"
L["HIDE_LEVEL"] = "Скрыть информацию для уровней ниже"
L["CURRENT_1ST"] = "Показать текущего персонажа первым"
L["SORT_BY"] = "Порядок сортировки"
L["SORT_ORDER"] = "Параметры сортировки"
L["Descending"] = "По убыванию"
L["Ascending"] = "По возрастанию"
L["EXCLUDE"] = "Исключить персонажей (разделять запятой или пробелом)"
L["TOOLTIP"] = "подсказке"
L["TOOLTIP_CHARACTER"] = "Информация о персонаже во всплывающей подсказке"
L["INFO1"] = "Первая строка информации о специализации персонажа"
L["INFO2"] = "Вторая строка информации о специализации персонажа"
L["Left"] = "Слева"
L["Right"] = "Справа"
L["TOOLTIP_RAID"] = "Всплывающая подсказка — рейдовые подземелья"
L["INFO3"] = "Строки для рейдовых подземелий"
L["TOOLTIP_HEROIC"] = "Всплывающая подсказка — героические подземелья"
L["INFO4"] = "Строки для героических подземелий"
L["INFO_SHORT"] = "Показать в одной строке"

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
    { "|cff00ff00■|r |cffccaa00Использование - Информация о персонаже|r" },
    { "[name]"          , "Имя (цвет класса)", "[name2]"        , "Имя (без цвета)"  },
    { "[level]"         , "[expCur]"        , "[expMax]"        , "[exp%]"      },
    { "[expRest]"       , "[expRest%]"      , "[zone]"          , "[subzone]"   },
    { "[elapsed]"       , "Прошедшее время после последнего обновления", "[cooldown]"     , "Перезарядка навыков профессии"    },
    { "[item:aимя]"     , "[item:name]"     , "значок и количество",            },
    { "[dqCom]"         , "[dqReset]"       , "[playedtotal]"   , "[playedlevel]" },
    { "[ilvl]"          , "[ilvl_avg]"      , "[ilvl_equip]"    ,   },
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
-- World Boss
L["World Boss"]     = true
L["Galleon"]        = "G"
L["Sha of Anger"]   = "S"
L["Nalak"]          = "N"
L["Oondasta"]       = "O"
-- Abbreviation
L["H5_Shado-pan Monastery"      ] = "SPM"
L["H5_Temple of the Jade Serpent"   ] = "TJS"
L["H5_Stormstout Brewery"       ]= "SSB"
L["H5_Gate of the Setting Sun"  ] = "GSS"
L["H5_Mogu'shan Palace"         ] = "MsP"
L["H5_Scarlet Halls"            ] = "SH"
L["H5_Scarlet Monastery"        ] = "SM"
L["H5_Scholomance"              ] = "Sch"
L["H5_Siege of Niuzao Temple"   ] = "SNT"
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
L["Mogu'shan Vaults"            ] = "Подземелья Могу'шан"
L["Heart of Fear"               ] = "Сердце Страха"
L["Terrace of Endless Spring"   ] = "Терраса Вечной Весны"
L["Throne of Thunder"           ] = "Престол Гроз"
L["Siege of Orgrimmar"          ] = "Осада Оргриммара"
L["Dragon Soul"                 ] = "Душа Дракона"
L["Firelands"                   ] = "Огненные Просторы"
L["Throne of the Four Winds"    ] = "Трон Четырех Ветров"
L["Blackwing Descent"           ] = "Твердыня Крыла Тьмы"
L["The Bastion of Twilight"     ] = "Сумеречный бастион"
L["Baradin Hold"                ] = "Крепость Барадин"
L["Icecrown Citadel"            ] = "Цитадель Ледяной Короны"
L["The Ruby Sanctum"            ] = "Рубиновое святилище"
L["Trial of the Crusader"       ] = "Испытание крестоносца"
L["Ulduar"                      ] = "Ульдуар"
L["Naxxramas"                   ] = "Наксрамас"
L["The Eye of Eternity"         ] = "Око Вечности"
L["The Obsidian Sanctum"        ] = "Обсидиановое святилище"
L["Onyxia's Lair"               ] = "Логово Ониксии"
L["Vault of Archavon"           ] = "Склеп Аркавона"
L["The Sunwell"                 ] = "Солнечный Колодец"
L["Black Temple"                ] = "Черный храм"
L["-Hyjal"                      ] = "Битва за гору Хиджал"
L["-Serpentshrine Cavern"       ] = "Кривой Клык: Змеиное святилище"
L["Tempest Keep"                ] = "Крепость Бурь"
L["Karazhan"                    ] = "Каражан"
L["Gruul's Lair"                ] = "Логово Груула"
L["Magtheridon's Lair"          ] = "Логово Магтеридона"
L["Ahn'Qiraj Temple"            ] = "Храм Ан'Киража"
L["Ruins of Ahn'Qiraj"          ] = "Руины Ан'Киража"
L["Blackwing Lair"              ] = "Логово Крыла Тьмы"
L["Molten Core"                 ] = "Огненные Недра"

end
