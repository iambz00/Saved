local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(AddonName, "ruRU")
local GOLD_ICON = "|TInterface/MoneyFrame/UI-GoldIcon:14:14:2:0|t"
local SILVER_ICON = "|TInterface/MoneyFrame/UI-SilverIcon:14:14:2:0|t"
local COPPER_ICON = "|TInterface/MoneyFrame/UI-CopperIcon:14:14:2:0|t"

if L then
L["Transmute"] = "Трансмутация"

L["Reset due to update"] = function(oldv, newv) return "Сброс некоторых или всех данных из-за обновления версии ("..oldv.." -> "..newv ")" end
L["extended"] = "(расширение)"

L["minites"] = "м"
L["Enabled"] = "Включено"
L["Disabled"] = "Отключено"

L["Display settings"] = "Настройки отображения"
L["Show floating UI frame"] = "Показать всплывающее окно"
L["Floating UI width"] = "Ширина окна"
L["Floating UI height"] = "Высота окна"
L["Desc - Frame"] = "|cff00ff00■|r |cffccaa00Shift - Перетаскивание для перемещения окна|r"
L["Show minimap icon"] = "Показать значок на миникарте"
L["Show info"] = "Информационное окно"
L["per Character"] = "По персонажу"
L["per Realm"] = "По серверу"
L["Hide info from level under"] = "Скрыть информацию с уровня ниже"

L["Tooltip - Character info."] = "Информация, относящаяся к параметру всплывающей подсказки" --"Информация для персонажа"
L["Line 1 of char info."] = "Первая строка с информацией по специализации персонажа"
L["Line 2 of char info."] = "Вторая строка с информацией по специализации персонажа"
L["Left"] = "Лево"
L["Right"] = "Право"
L["Desc_Char"] = "|cff00ff00■|r |cffccaa00Использование - Информация о персонаже|r|n"
	.."|cffccaa00%n|r Имя (цвет класса)|n|cffccaa00%N|r Имя (без цвета)|n"
	.."|cffccaa00%g|r Золото   |cffccaa00%s|r Серебро   |cffccaa00%c|r Бронза|n"
	.."|cffccaa00%G|r "..GOLD_ICON.."    |cffccaa00%S|r "..SILVER_ICON.."    |cffccaa00%C|r "..COPPER_ICON.."|n"
	.."|cffccaa00%l|r Текущий уровень   |cffccaa00%p|r Текущий опыт %|n"
	.."|cffccaa00%e|r Текущий опыт   |cffccaa00%E|r Макс Опыт|n"
	.."|cffccaa00%R|r Опыт отдыха   |cffccaa00%P|r Опыт отдыха %|n"
	.."|cffccaa00%Z|r Текущая зона   |cffccaa00%z|r Подзона|n"
	.."|cffccaa00%H|r |T137000:14:14:0:0:14:14:0:8:0:8|t |cffccaa00%h|r Honor Points|n"
	.."|cffccaa00%A|r |T136729:14:14|t |cffccaa00%a|r Arena Points|n"
	.."|cffccaa00%r|r Новая линия|n"
	.."|cffccaa00%L|r Прошедшее время после последнего обновления|n"
	.."|cffccaa00%B|r Мировые баффы и статус Эликсира|n"
	.."|cffccaa00%i{|cffffffffСсылка на ID|cffccaa00}|r Значок предмета|n"
	.."|cffccaa00%n{|cffffffffСсылка на ID|cffccaa00}|r Количество предметов|n"
	.."|cffccaa00%i{|cffffffffСсылка на ID|cffccaa00}|r Значок + Количество|n"
	.."|cffccaa00e.g. %I{|cffffffff[осколков души]|r} or %I{6265} => |TInterface/Icons/Inv_misc_gem_amethyst_02:14:14|t25|r|n"
	.."|cffccaa00e.g. %I{|cffffffff[Badge of Justice]|r} or %I{29434} => |TInterface/Icons/Spell_holy_championsbond:14:14|t25|r|n"
	.."|cffccaa00%T|r Перезарядка навыков профессии   |cffccaa00%Q|r Time to DQ Reset|n"	--
	.."|cffccaa00%d|r Completed Daily Quests   |cffccaa00%D|r Maximum Daily Quests|n"	--
	.."|cffccaa00%F######|r Цвет начала(RGB кодировка)|n|cffccaa00%f|r Цвет окончания|n"
	.."|cffccaa00(ex) %FffffffБелый%f =>|r |cffffffffБелый|r|n   |cffccaa00%Fff0000Красный%f => |r|cffff0000Красный|r"
L["Tooltip - Raid instances"] = true
L["Lines of raid instances"] = true
L["Desc_Inst"] = "|cff00ff00■|r |cffccaa00Использование - Информация о подземелье|r|n"
	.."|cffccaa00!n|r Название подземелья|n"
	.."|cffccaa00!d|r Размер и сложность|n"
	.."|cffccaa00!p|r Количество убитых боссов|n"
	.."|cffccaa00!P|r Количество боссов|n"
	.."|cffccaa00!t|r Время сброса|n"
	.."|cffccaa00!i|r ID подземелья|n"
L["Tooltip - Heroic instances"] = true
L["Lines of heroic instances"] = true

L["Select character"] = "Выбор персонажа"
L["Reset selected character"] = "Сбросить выбранного персонажа"
L["Are you really want to reset?"] = "Вы действительно хотите сбросить настройки?"
L["Reset all characters"] = "Сбросить всех персонажей"
L["Copy settings to"] = "Настройки копирования на"
L["Copy"] = "Копировать"
L["Confirm copy"] = "Настройки копирования перезапишут информацию о персонаже/подземелье."

end
