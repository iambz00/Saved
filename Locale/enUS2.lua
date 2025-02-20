local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(AddonName, "enUS", true)
local GOLD_ICON = "|TInterface/MoneyFrame/UI-GoldIcon:14:14:2:0|t"
local SILVER_ICON = "|TInterface/MoneyFrame/UI-SilverIcon:14:14:2:0|t"
local COPPER_ICON = "|TInterface/MoneyFrame/UI-CopperIcon:14:14:2:0|t"
local SOUL_SHARD_ICON = "|TInterface/Icons/Inv_misc_gem_amethyst_02:14:14|t"

if L then
L["Transmute"] = true

L["Reset due to update"] = function(oldv, newv) return "Reset some or entire data due to version update ("..oldv.." -> "..newv ")" end
L["extended"] = "(extended)"

L["minites"] = "m"
L["Enabled"] = true
L["Disabled"] = true

L["Display settings"] = true
L["Show floating UI frame"] = true
L["Floating UI width"] = true
L["Floating UI height"] = true
L["Desc - Frame"] = "|cff00ff00■|r |cffccaa00Shift - Drag to move the Frame|r"
L["Show minimap icon"] = true
L["Show info"] = true
L["per Character"] = true
L["per Realm"] = true
L["Hide info from level under"] = true

L["Tooltip - Character info."] = true
L["Line 1 of char info."] = true
L["Line 2 of char info."] = true
L["Left"] = true
L["Right"] = true
L["Desc_Char"] = "|cff00ff00■|r |cffccaa00Usage - Character info|r|n"
	.."|cffccaa00%n|r Name(Class color)|n|cffccaa00%N|r Name(No color)|n"
	.."|cffccaa00%g|r Gold   |cffccaa00%s|r Silver   |cffccaa00%c|r Copper|n"
	.."|cffccaa00%G|r "..GOLD_ICON.."    |cffccaa00%S|r "..SILVER_ICON.."    |cffccaa00%C|r "..COPPER_ICON.."|n"
	.."|cffccaa00%l|r Current Level   |cffccaa00%p|r Current Exp %|n"
	.."|cffccaa00%e|r Current Exp   |cffccaa00%E|r Max Exp|n"
	.."|cffccaa00%R|r Rest Exp   |cffccaa00%P|r Rest Exp %|n"
	.."|cffccaa00%Z|r Currnet Zone   |cffccaa00%z|r Subzone치|n"
	.."|cffccaa00%r|r New line|n"
	.."|cffccaa00%L|r Elapsed time after last update|n"
	.."|cffccaa00%B|r World buffs and Elixir status|n"
	.."|cffccaa00%i{|cffffffffItemlink or ID|cffccaa00}|r Item icon|n"
	.."|cffccaa00%n{|cffffffffItemlink or ID|cffccaa00}|r Item amount|n"
	.."|cffccaa00%i{|cffffffffItemlink or ID|cffccaa00}|r Icon + Amount|n"
	.."|cffccaa00e.g. %I{|cffffffff[Soul Shard]|r} or %I{6265} => "..SOUL_SHARD_ICON.."25|r|n"
	.."|cffccaa00%T|r Tradeskill cooldowns|n"
	.."|cffccaa00%F######|r Color starts(RGB code)|n|cffccaa00%f|r Color ends|n"
	.."|cffccaa00e.g. %FffffffWhite%f =>|r |cffffffffWhite|r|n   |cffccaa00%Fff0000Red%f => |r|cffff0000Red|r"
L["Desc_Char2"] = true
L["Tooltip - Instance info"] = true
L["Lines of instance info"] = true
L["Desc_Inst"] = "|cff00ff00■|r |cffccaa00Usage - Instance info|r|n"
	.."|cffccaa00!n|r Instance name|n"
	.."|cffccaa00!d|r Size and Difficulty|n"
	.."|cffccaa00!p|r Number of bosses killed|n"
	.."|cffccaa00!P|r Number of bosses|n"
	.."|cffccaa00!t|r Time to reset|n"
	.."|cffccaa00!i|r Instance ID|n"
L["Reset selected character"] = true
L["Are you really want to reset?"] = true
L["Reset all characters"] = true
L["Dupe settings to"] = true
L["Dupe"] = true
L["Dupe settings will overwirte character/instance info settings."] = true
end

