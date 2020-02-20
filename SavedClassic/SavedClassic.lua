local AddonName, Addon = ...
SavedClassic = LibStub("AceAddon-3.0"):NewAddon(AddonName, "AceEvent-3.0")

SavedClassic.name = AddonName
SavedClassic.version = GetAddOnMetadata(AddonName, "Version")

local L = LibStub("AceLocale-3.0"):GetLocale(AddonName, true)

local SAVED_MSG_PREFIX = "|cff00ff00■ |cffffaa00Saved!|r "
local SAVED_MSG_SUFFIX = " |cff00ff00■|r"
local SAVED_GOLD_ICON = "|TInterface/MoneyFrame/UI-GoldIcon:14:14:2:0|t"
local SAVED_SILVER_ICON = "|TInterface/MoneyFrame/UI-SilverIcon:14:14:2:0|t"
local SAVED_COPPER_ICON = "|TInterface/MoneyFrame/UI-CopperIcon:14:14:2:0|t"

local player , _ = UnitName("player")
local _, class, _ = UnitClass("player")
local p = function(str) print(SAVED_MSG_PREFIX..str..SAVED_MSG_SUFFIX) end

_G.SavedClassic = SavedClassic

local pt = {
	["%Z"] = "zone" ,
	["%z"] = "subzone" ,

	["%n"] = "coloredName",
	["%N"] = "name",

	["%g"] = "gold" ,
	["%G"] = "return '"..SAVED_GOLD_ICON.."'" ,
	["%s"] = "silver" ,
	["%S"] = "return '"..SAVED_SILVER_ICON.."'" ,
	["%c"] = "copper" ,
	["%C"] = "return '"..SAVED_COPPER_ICON.."'" ,

	["%l"] = "level",
	["%e"] = "expCurrent",
	["%E"] = "expMax",
	["%p"] = "expPercent",
--	["%R"] = "expRest",
--	["%P"] = "expRestPercent",

	["%F"] = "return '|cff'" , 
	["%f"] = "return '|r'" , 
	["%r"] = "return '\\n'" ,

	["%%"] = "return '%'" ,

	["!n"] = "name" ,
	["!d"] = "difficultyName" ,
	["!i"] = "id" ,
	["!p"] = "progress" ,
	["!P"] = "numBoss" ,
	["!e"] = "extended" ,
	["!!"] = "return '!'" ,

--	["!t"] = "" ,
}

local dbDefault = {
	realm = {
		[player] = {
			frameX = 100,
			frameY = 25,
			showInfoPer = "realm",
			hideLevelUnder = 1,

			default = true,
			minimapIcon = { hide = false }
		}
	}
}

function SavedClassic:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SavedClassicDB", dbDefault)
	if self.db.global.version ~= self.version then
		--p(L["Reset database due to major upgrade"](self.db.global.version, self.version))
		--self.db:ResetDB()
	end
	self.db.global.version = self.version

	if self.db.realm[player].default then self:InitPlayerDB() end

	self:SetOrder()

	self:InitUI()
	self:InitDBIcon()

	self:BuildOptions() -- Build self.optionsTable
	LibStub("AceConfig-3.0"):RegisterOptionsTable(self.name, self.optionsTable)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(self.name, self.name, nil)

	self:RegisterEvent("PLAYER_MONEY")
	self:RegisterEvent("PLAYER_XP_UPDATE")
	self:RegisterEvent("PLAYER_LEAVING_WORLD", "SaveZone")

	self:RegisterEvent("PLAYER_ENTERING_WORLD", "SaveInfo")
	self:RegisterEvent("UPDATE_INSTANCE_INFO", "SaveInfo")
	self:RegisterEvent("ZONE_CHANGED", "SaveInfo")
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "SaveInfo")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "SaveInfo")

	self.totalMoney = 0	-- Total money except current character
	for character, saved in pairs(self.db.realm) do
		if character and (character ~= player) and saved.money then
			self.totalMoney = self.totalMoney + saved.money
		end
	end

end

function SavedClassic:OnEnable()
	p(L["Enabled"])
end

function SavedClassic:OnDisable()
	p(L["Disabled"])
end

function SavedClassic:SetOrder()
	-- db for ordered list
	self.order = { }
	for k, v in pairs(self.db.realm) do
		table.insert(self.order, { name = v.name, level = v.level })
	end
	table.sort(self.order, function(a,b) al = a.level or 0 bl = b.level or 0 return al > bl end)
end

function SavedClassic:InitPlayerDB()
	local playerdb = self.db.realm[player]
	local classColor = RAID_CLASS_COLORS[class]

	playerdb.default = false
	playerdb.name = player
	playerdb.coloredName = string.format("|cff%.2x%.2x%.2x%s|r", classColor.r*255, classColor.g*255, classColor.b*255, player)

	self:PLAYER_MONEY()
	self:PLAYER_XP_UPDATE()

	playerdb.info1 = true
	-- Hide exp info on max level
	if UnitLevel("player") < GetMaxPlayerLevel() then
		playerdb.info2 = true
		playerdb.info1_1 = "%r%F00ff00■%f [%Fffffff%l%f:%n] %Fffffff(%Z: %z)%f"
	else
		playerdb.info2 = false
		playerdb.info1_1 = "%r%F00ff00■%f [%n] %Fffffff(%Z: %z)%f"
	end
	playerdb.info3 = true

	playerdb.info1_2 = "%r%Fffee99%g%G%f  "
	playerdb.info2_1 = "   %Fcc66ff%e/%E (%p%%)%f %F66ccff+%R (%P%%)%f"
	playerdb.info2_2 = ""
	playerdb.info3_1 = "   !n (!d) !e %Fccccaa!p/!P%f"
	playerdb.info3_2 = "!t "
	playerdb.instances = { }
	playerdb.zone = ""
	playerdb.subzone = ""
	playerdb.lastUpdate = currentTime
	playerdb.frameShow = true
end

function SavedClassic:ResetCharDB()
	for k,_ in pairs(self.db.realm[player]) do
		self.db.realm[player][k] = nil
	end
	for k,v in pairs(dbDefault.realm[player]) do
		self.db.realm[player][k] = v
	end
	self:InitPlayerDB()
	self:SaveInfo()
end

function SavedClassic:ResetWholeDB()
	self.db:ResetDB()
	self:InitPlayerDB()
	self:SetOrder()
	self.totalMoney = 0
	self:SaveInfo()
end

function SavedClassic:SaveInfo()
	local db = self.db.realm[player]

	local classColor = RAID_CLASS_COLORS[class]
	db.coloredName = string.format("|cff%.2x%.2x%.2x%s|r", classColor.r*255, classColor.g*255, classColor.b*255, player)

	local instances = {}

	local currentTime = time()

	-- instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName
	--		= GetSavedInstanceInfo(index)
	local numSaved = GetNumSavedInstances()
	local numLocked = 0
	for i = 1, numSaved do
		local instance = { }
		local isLocked, extended, remain
		instance.name, instance.id, remain, _, isLocked, extended, _, instance.isRaid, _, instance.difficultyName, instance.numBoss, instance.progress = GetSavedInstanceInfo(i)
		if isLocked or instance.extended then	-- Save & count only locked or extended instances
			numLocked = numLocked+1
			instance.reset = remain + currentTime
			if extended then
				instance.extended = L["extended"]
			else
				instance.extended = ""
			end
			table.insert(instances, instance)
		end
	end

	table.sort(instances,
		function(a,b)
			if a.isRaid and not b.isRaid then return true
			elseif b.isRaid and not a.isRaid then return false
			else return ( a.name < b.name ) or ( a.name == b.name and a.difficultyName < b.difficultyName )
			end
		end
	)

	db.instances = instances

	self:PLAYER_MONEY()
	self:PLAYER_XP_UPDATE()
	self:SaveZone()	
	db.lastUpdate = currentTime
end

function SavedClassic:PLAYER_MONEY()
	local money = abs(GetMoney())
	local db = self.db.realm[player]
	db.money = money
	db.gold = floor(money / 10000)
	db.silver = floor(money % 10000 / 100)
	db.copper = floor(money % 100)
end

function SavedClassic:PLAYER_XP_UPDATE()
	local db = self.db.realm[player]
	db.level = UnitLevel("player")
	db.expCurrent = UnitXP("player")
	db.expMax = UnitXPMax("player")
	db.expPercent = floor(db.expCurrent / db.expMax * 100)
	db.expRest = GetXPExhaustion() or 0

	self:SetOrder()
end

function SavedClassic:SaveZone()
	local db = self.db.realm[player]
	local zone = GetZoneText()
	if zone and zone ~= "" then
		db.zone = zone
		db.subzone = GetSubZoneText()
	end
end

function SavedClassic:ShowInfoTooltip(tooltip)
	local mode = ""
	local db = self.db.realm[player]
	local realm = ""
	if db.showInfoPer == "realm" then realm = " - " .. GetRealmName() end

	local totalGold = floor((self.totalMoney + db.money) / 10000)
	tooltip:AddDoubleLine(SAVED_MSG_PREFIX .. realm .. SAVED_MSG_SUFFIX, totalGold.. SAVED_GOLD_ICON)

	if db.showInfoPer == "realm" then
		for _, v in ipairs(self.order) do
			if v.level < db.hideLevelUnder then
			else	
				self:ShowInstanceInfo(tooltip, v.name)
			end
		end
	else
		self:ShowInstanceInfo(tooltip, player)
	end
end

function SavedClassic:ShowInstanceInfo(tooltip, character)
	local db = self.db.realm[character]
	local currentTime = time()
	local restXP = floor(min(db.expRest + (currentTime - db.lastUpdate) / 28800 * 0.05 * db.expMax, db.expMax * 1.5))
	local restPercent = floor(restXP / db.expMax * 100)

	if db["info1"] then
		local line1_1 = string.gsub(db["info1_1"], "(%%[RP])", function(s) if s == "%R" then return restXP else return restPercent end end)
		line1_1 = string.gsub(line1_1, "(%%[%w%%])", function(s) return db[pt[s]] or loadstring(pt[s])() end)
		local line1_2 = string.gsub(db["info1_2"], "(%%[RP])", function(s) if s == "%R" then return restXP else return restPercent end end)
		line1_2 = string.gsub(line1_2, "(%%[%w%%])", function(s) return db[pt[s]] or loadstring(pt[s])() end)
		tooltip:AddDoubleLine(line1_1, line1_2)
	end
	if db["info2"] then
		local line2_1 = string.gsub(db["info2_1"], "(%%[RP])", function(s) if s == "%R" then return restXP else return restPercent end end)
		line2_1 = string.gsub(line2_1, "(%%[%w%%])", function(s) return db[pt[s]] or loadstring(pt[s])() end)
		local line2_2 = string.gsub(db["info2_2"], "(%%[RP])", function(s) if s == "%R" then return restXP else return restPercent end end)
		line2_2 = string.gsub(line2_2, "(%%[%w%%])", function(s) return db[pt[s]] or loadstring(pt[s])() end)
		tooltip:AddDoubleLine(line2_1, line2_2)
	end

	if not db.instances then return end
	local nMax = table.getn(db.instances)
	for i = 1, nMax do
		local instance = db.instances[i]
		local remain = SecondsToTime(instance.reset - time())
		if remain and ( remain ~= "" ) then
			if db["info3"] then
				local line3_1 = string.gsub(db["info3_1"], "(!t)", remain)
				line3_1 = string.gsub(line3_1, "([!%%][!%w])", function(s) return instance[pt[s]] or loadstring(pt[s])() end)
				local line3_2 = string.gsub(db["info3_2"], "(!t)", remain)
				line3_2 = string.gsub(line3_2, "([!%%][!%w])", function(s) return instance[pt[s]] or loadstring(pt[s])() end)
				tooltip:AddDoubleLine(line3_1, line3_2)
			end
		end
	end

end

function SavedClassic:InitUI()
	local db = self.db.realm[player]
	local ui = CreateFrame("Button", self.name.."FloatingUI", UIParent)
	self.ui = ui
	ui:EnableMouse(true)
	ui:SetWidth(db.frameX)
	ui:SetHeight(db.frameY)
	ui:SetMovable(true)
	ui:SetBackdrop({
		bgFile = "Interface/TutorialFrame/TutorialFrameBackground",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 2, right = 2, top = 2, bottom = 2 },
	})
	ui:SetBackdropBorderColor(1,0.82,0,1)
	ui:SetPoint("CENTER")

	text = ui:CreateFontString()
	text:SetAllPoints()
	text:SetFontObject("GameFontNormal")
	text:SetText("|cff00ff00Saved|r ")

	ui:RegisterForDrag("LeftButton")
	ui:RegisterForClicks("LeftButtonDown", "RightButtonDown")

	--ui:SetUserPlaced(true)
	ui:SetScript("OnEnter", function(s)
		local divider = GetScreenHeight() / 2
		local cursorY = select(2, GetCursorPosition())
		GameTooltip:Hide()
		GameTooltip:SetOwner(s, "ANCHOR_NONE", 0, 0)
		if cursorY > divider then
			GameTooltip:SetPoint("TOP", s , "BOTTOM")
		else
			GameTooltip:SetPoint("BOTTOM", s , "TOP")
		end
		self:ShowInfoTooltip(GameTooltip)
		GameTooltip:Show()
	end)
	ui:SetScript("OnLeave", function() GameTooltip:Hide() end)
	ui:SetScript("OnClick", function(s, btn)
		if (btn == "LeftButton" and not IsShiftKeyDown()) then
			LibStub("AceConfigDialog-3.0"):Open(self.name)
		end
	end)
	ui:SetScript("OnDragStart", function(s)
		if IsShiftKeyDown() then
			GameTooltip:Hide()
			s:StartMoving()
		end
	end)
	ui:SetScript("OnDragStop", function(s)
		s:StopMovingOrSizing()
		GameTooltip:Show()
	end)

	if self.db.realm[player].frameShow then
		self.ui:Show()
	else
		self.ui:Hide()
	end
end

function SavedClassic:InitDBIcon()
	self.icon = LibStub("LibDBIcon-1.0")
	self.iconLDB = LibStub("LibDataBroker-1.1"):NewDataObject(self.name .."Icon", {
		type = "data source",
		text = "Questie",
		icon = "135757",
		OnClick = function() LibStub("AceConfigDialog-3.0"):Open(self.name) end,
		OnTooltipShow = function(tooltip) self:ShowInfoTooltip(tooltip) end,
	})
	self.icon:Register(self.name, self.iconLDB, self.db.realm[player].minimapIcon)
end

function SavedClassic:BuildOptions()
	local db = self.db.realm[player]
	self.optionsTable = {
		name = self.name .. " option",
		handler = self,
		type = 'group',
		get = function(info) return db[info[#info]] end,
		set = function(info, value) db[info[#info]] = value end,
		args = {
			show = {
				name = L["Display settings"],
				type = "group",
				inline = true,
				order = 1,
				args = {
					frameShow = {
						name = L["Show floating UI frame"],
						type = "toggle",
						order = 101,
						set = function(info, value)
							db[info[#info]] = value
							if value then
								self.ui:Show()
							else
								self.ui:Hide()
							end
						end,
					},
					frameX = {
						name = L["Floating UI width"],
						type = "range",
						min = 80,
						max = 200,
						step = 1,
						order = 102,
						set = function(info, value)
							db.frameX = value
							self.ui:SetWidth(value)
						end
					},
					frameY = {
						name = L["Floating UI height"],
						type = "range",
						min = 20,
						max = 50,
						step = 1,
						order = 103,
						set = function(info, value)
							db.frameY = value
							self.ui:SetHeight(value)
						end
					},
					frameDesc = {
						name = L["Desc - Frame"],
						type = "description",
						order = 104
					},
					showMinimapIcon = {
						name = L["Show minimap icon"],
						type = "toggle",
						order = 111,
						get = function(info)
							return not db.minimapIcon.hide
						end,
						set = function(info, value)
							db.minimapIcon.hide = not value
							if value then
								self.icon:Show(self.name)
							else
								self.icon:Hide(self.name)
							end
						end,
					},
					showInfoPer = {
						name = L["Show info"],
						type = "select",
						values = {
							char = L["per Character"],
							realm = L["per Realm"]
						},
						style = "radio",
						order = 121
					},
					hideLevelUnder = {
						name = L["Hide info from level under"],
						type = "range",
						min = 1,
						max = 59,
						step = 1,
						order = 131
					},
				}
			},
			infoChar = {
				name = L["Tooltip - Character info."],
				type = "group",
				inline = true,
				order = 2,
				args = {
					info1 = {
						name = L["Line 1 of char info."],
						type = "toggle",
						order = 11
					},
					info2 = {
						name = L["Line 2 of char info."],
						type = "toggle",
						order = 21
					},
					info1_1 = {
						name = L["Left"],
						type = "input",
						width = "full",
						order = 12
					},
					info1_2 = {
						name = L["Right"],
						type = "input",
						width = "full",
						order = 13
					},
					info2_1 = {
						name = L["Left"],
						type = "input",
						width = "full",
						order = 22
					},
					info2_2 = {
						name = L["Right"],
						type = "input",
						width = "full",
						order = 23
					},
					descChar = {
						name = L["Desc_Char"],
						type = "description",
						order = 99
					},
				},
			},

			infoInst = {
				name = L["Tooltip - Instance info"],
				type = "group",
				inline = true,
				order = 3,
				args = {
					info3 = {
						name = L["Lines of instance info"],
						type = "toggle",
						order = 31
					},
					info3_1 = {
						name = L["Left"],
						type = "input",
						width = "full",
						order = 32
					},
					info3_2 = {
						name = L["Right"],
						type = "input",
						width = "full",
						order = 33
					},
					descChar = {
						name = L["Desc_Inst"],
						type = "description",
						order = 99
					},

				},
			},
			resetButton1 = {
				name = L["Reset current character"],
				type = "execute",
				func = function() self:ResetCharDB() end,
				confirm = function() return L["Are you really want to reset?"] end,
				order = 91
			},
			resetButton2 = {
				name = L["Reset all characters"],
				type = "execute",
				func = function() self:ResetWholeDB() end,
				confirm = function() return L["Are you really want to reset?"] end,
				order = 92
			}
		},
	}
end
