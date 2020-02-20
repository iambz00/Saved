local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(AddonName, "enUS", true)
local SAVED_GOLD_ICON = "|TInterface/MoneyFrame/UI-GoldIcon:14:14:2:0|t"
local SAVED_SILVER_ICON = "|TInterface/MoneyFrame/UI-SilverIcon:14:14:2:0|t"
local SAVED_COPPER_ICON = "|TInterface/MoneyFrame/UI-CopperIcon:14:14:2:0|t"

if L then

L["Reset database due to major upgrade"] = function(oldv, newv) return "Reset database due to major upgrade ("..oldv.." -> "..newv ")" end
L["extended"] = "(extended)"

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
	.."   |cffccaa00%n|r Name(Class color)    |cffccaa00%N|r Name(No color)|n"
	.."   |cffccaa00%g|r Gold      |cffccaa00%G|r "..SAVED_GOLD_ICON.."         "
	.."|cffccaa00%s|r Silver    |cffccaa00%S|r "..SAVED_SILVER_ICON.."         "
	.."|cffccaa00%c|r Copper    |cffccaa00%C|r "..SAVED_COPPER_ICON.."|n"
	.."   |cffccaa00%l|r Current Level    |cffccaa00%e|r Current Exp     |cffccaa00%E|r Max Exp|n"
	.."   |cffccaa00%p|r Current Exp %    |cffccaa00%R|r Rest Exp(Estimated)    |cffccaa00%P|r Rest Exp %(Estimated)|n"
	.."   |cffccaa00%Z|r Currnet Zone     |cffccaa00%z|r Subzone        |cffccaa00%r|r New line|n"
	.."   |cffccaa00%F######|r Color start(RGB code 000000~ffffff)         |cffccaa00%f|r Color end|n"
	.."    |cffccaa00(Ex) %FffffffWhite%f =>|r |cffffffffWhite, |r |cffccaa00%Fff0000Red%f|r => |cffff0000Red|r"
L["Tooltip - Instance info"] = true
L["Lines of instance info"] = true
L["Desc_Inst"] = "|cff00ff00■|r Usage - Instance info|n"
	.."   |cffccaa00!n|r Instance name                  |cffccaa00!d|r Size and Difficulty|n"
	.."   |cffccaa00!p|r Number of bosses killed         |cffccaa00!P|r Number of bosses|n"
	.."   |cffccaa00!t|r Time to reset           |cffccaa00!i|r Instance ID           |cffccaa00!e|r Extended"
L["Reset current character"] = true
L["Are you really want to reset?"] = true
L["Reset all characters"] = true

end