local addonName, addon = ...
SavedClassic = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")

SavedClassic.name = addonName
--SavedClassic.version = GetAddOnMetadata(addonName, "Version")
SavedClassic.version = "2.0"

local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

local MSG_PREFIX = "|cff00ff00■ |cffffaa00Saved!|r "
local MSG_SUFFIX = " |cff00ff00■|r"
local GOLD_ICON = "|TInterface/MoneyFrame/UI-GoldIcon:14:14:2:0|t"
local SILVER_ICON = "|TInterface/MoneyFrame/UI-SilverIcon:14:14:2:0|t"
local COPPER_ICON = "|TInterface/MoneyFrame/UI-CopperIcon:14:14:2:0|t"


local player , _ = UnitName("player")
local _, class, _ = UnitClass("player")
local p = function(str) print(MSG_PREFIX..str..MSG_SUFFIX) end


SavedClassic.drugs = {	-- World buffs and Flasks
	[17626] = { },	-- Flask of Titan 티탄
	[17627] = { },	-- Flask of Distilled Wisdom 순지
	[17628] = { },	-- Flask of Supreme Power 강마
	[28518] = { },	-- Flask of Fortification  Health/Defense
	[28519] = { },	-- Flask of Mighty Restoration  Mana Regen
	[28520] = { },	-- Flask of Relentless Assault  AP
	[28521] = { },	-- Flask of Blinding Light  Arcane/Holy/Nature
	[28540] = { },	-- Flask of Pure Death  Shadow/Fire/Frost
	[17537] = { },	-- [B] Elixir of Brute Force
	[11406] = { },	-- [B] Elixir of Demonslaying
	[33721] = { },	-- [B] Adept's Elixir
	[28490] = { },	-- [B] Major Strength
	[28491] = { },	-- [B] Major Healing Power
	[28492] = { },	-- [B] Major Strength
	[28493] = { },	-- [B] Major Frost Power
	[28497] = { },	-- [B] Major Agility
	[28501] = { },	-- [B] Major Firepower
	[28503] = { },	-- [B] Major Shadow Power
	[28514] = { },	-- [G] Empowerment
	[39625] = { },	-- [G] Elixir of Major Fortitude
	[39626] = { },	-- [G] Earthen Elixir
	[39627] = { },	-- [G] Elixir of Draenic Wisdom
	[39628] = { },	-- [G] Elixir of Ironskin
	[28502] = { },	-- [G] Major Armor
}
SavedClassic.ts = {	-- Tradeskills of long cooldowns
	[29688] = { altName = L["Transmute"], },	-- Transmute: Primal Might
	[26751] = { },	-- Primal Mooncloth
	[31373] = { },	-- SpellCloth
	[36686] = { },	-- Shadowcloth
}
local pt = {
	["%n"] = "coloredName",	["%N"] = "name",
	["%Z"] = "zone" ,	["%z"] = "subzone" ,

	["%g"] = "gold" ,	["%G"] = GOLD_ICON ,
	["%s"] = "silver" ,	["%S"] = SILVER_ICON ,
	["%c"] = "copper" ,	["%C"] = COPPER_ICON ,

	["%w"] = "soulshards",	["%W"] = "|T"..GetItemIcon(6265)..":14:14|t",

	["%l"] = "level",
	["%e"] = "expCurrent",	["%E"] = "expMax",	["%p"] = "expPercent",
--	["%R"] = "expRest",	["%P"] = "expRestPercent",

	["%F"] = "|cff" ,	["%f"] = "|r" ,	["%r"] = "|n" ,
	["%%"] = "%" ,

	["!n"] = "name" ,	["!d"] = "difficultyName" ,
	["!i"] = "id" ,	["!p"] = "progress" ,	["!P"] = "numBoss" ,
	["!e"] = "" ,	-- classic doesn't support extened
	["!!"] = "!" ,

--	["!t"] = "" ,

	["%h"] = "honorPoint",
--	["%H"] = "honorMax",
	["%j"] = "justice",	-- Badge of justice

	["%dc"] = dqComplete,	["%dm"] = dqMax,	["%dr"] = dqReset,
}

local dbDefault = {
	realm = {
		[player] = {
			frameX = 100,	frameY = 25,
			showInfoPer = "realm",
			hideLevelUnder = 1,

			default = true,
			minimapIcon = { hide = false },
			tradeSkills = {},

			expCurrent = -1, expMax = -1, expPercent = -1, ExpRest = -1,

			honorPoint = -1, justice = -1,
			dqComplete = -1, dqMax = -1, dqReset = -1,

			soulshards = -1,
			lastUpdate = -1,
		}
	}
}

function SavedClassic:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SavedClassicDB", dbDefault)
	self.db.global.version = self.db.global.version or self.version

	-- Clean old data
	if self.db.global.version < "2.0" then
		self.db.realm = { }
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
	self:RegisterEvent("ZONE_CHANGED", "SaveInfo")
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "SaveInfo")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "RequestRaidInfo")
	-- API RequestRaidInfo() triggers UPDATE_INSTANCE_INFO
	self:RegisterEvent("UPDATE_INSTANCE_INFO", "SaveInfo")

	self:RegisterEvent("TRADE_SKILL_UPDATE", "SaveTSCooldowns")

	self:RegisterEvent("QUEST_TURNED_IN")

--[[
	HONOR_CURRENCY_UPDATE
	TRADE_CURRENCY_CHANGED
	PLAYER_TRADE_CURRENCY
]]
	if class == "WARLOCK" then
		self:RegisterEvent("BAG_UPDATE", "SaveSoulShards")
	end

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
	table.sort(self.order,
		function(a,b)
			al = a.level or 0
			bl = b.level or 0
			if al == bl then
				return a.name < b.name
			else
				return al > bl
			end
		end)
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
	playerdb.info1_1 = "%r%F00ff00■%f [%n] %Fffffff(%Z: %z)%f"
	playerdb.info1_2 = "%r%Fffee99%g%G%f  "
	playerdb.info2 = false
	playerdb.info2_1 = "   %Fcccccc%T%f"	-- Tradeskill cooldowns
	playerdb.info2_2 = ""

	-- Show level and exp for characters under 70
	if UnitLevel("player") < GetMaxPlayerLevel() then
		playerdb.info2 = true
		playerdb.info1_1 = "%r%F00ff00■%f [%Fffffff%l%f:%n] %Fffffff(%Z: %z)%f"
		playerdb.info2_1 = "   %Fcc66ff%e/%E (%p%%)%f %F66ccff+%R (%P%%)%f"	-- for exp
	end

	playerdb.info3 = true
	playerdb.info3_1 = "   !n (!d) %Fccccaa!p/!P%f"
	playerdb.info3_2 = "!t "
	playerdb.info4 = true
	playerdb.info4_1 = "   %Fcffff99!n (!d)%f %Fccccaa!p/!P%f"
	playerdb.info4_2 = "!t "

	playerdb.raids = { }
	playerdb.heroics = { }

	playerdb.zone = ""
	playerdb.subzone = ""

	playerdb.lastUpdate = currentTime
	playerdb.frameShow = true
end

function SavedClassic:ResetPlayerDB()
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
	self.db.global.version = self.version
	self:InitPlayerDB()
	self:SetOrder()
	self.totalMoney = 0
	self:SaveInfo()
end

function SavedClassic:RequestRaidInfo()
	RequestRaidInfo()	-- RequestRaidInfo() triggers UPDATE_INSTANCE_INFO
end

function SavedClassic:SaveInfo()
	local db = self.db.realm[player]
	local classColor = RAID_CLASS_COLORS[class]
	db.coloredName = string.format("|cff%.2x%.2x%.2x%s|r", classColor.r*255, classColor.g*255, classColor.b*255, player)

	local raids, heroics = { }, { }
	local currentTime = time()

	-- instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName
	--		= GetSavedInstanceInfo(index)
	for i = 1, GetNumSavedInstances() do
		local instance = { }
		local isLocked, extended, remain, isRaid
		instance.name, instance.id, remain, _, isLocked, extended, _, isRaid, _, instance.difficultyName, instance.numBoss, instance.progress = GetSavedInstanceInfo(i)
		if isLocked or extended then
			instance.reset = remain + currentTime
			if extended then
				instance.extended = L["extended"]
			else
				instance.extended = ""
			end
			if isRaid then
				table.insert(raids, instance)
			else
				table.insert(heroics, instance)
			end
		end
	end

	table.sort(raids, function(a,b) return ( a.name < b.name ) or ( a.name == b.name and a.difficultyName < b.difficultyName ) end)
	table.sort(heroics, function(a,b) return ( a.name < b.name ) or ( a.name == b.name and a.difficultyName < b.difficultyName ) end)

	db.raids = raids
	db.heroics = heroics

	self:PLAYER_MONEY()
	self:PLAYER_XP_UPDATE()
	self:SaveZone()	
	self:SaveTSCooldowns()
end

function SavedClassic:PLAYER_MONEY()
	local money = abs(GetMoney())
	local db = self.db.realm[player]
	db.money = money
	db.gold = floor(money / 10000)
	db.silver = floor(money % 10000 / 100)
	db.copper = floor(money % 100)
end

function SavedClassic:FOR_CURRENCY_UPDATE(...)
	local db = self.db.realm[player]
	-- name, CurrentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered = GetCurrencyInfo(index)
	-- For honor point
--	local _, db.honorPoint, _, earnedThisWeek, weeklyMax, totalMax = GetCurrencyInfo(392)
	
--	local _, db,justice, _, earnedThisWeek, weeklyMax, totalMax = GetCurrencyInfo(395)
	db.honorPoint = 0
	db.justice = 0

end

function SavedClassic:QUEST_TURNED_IN()
	local db = self.db.realm[player]
	
	db.dqComplete = GetDailyQuestsCompleted() or 0
	db.dqMax = GetMaxDailyQuests or 0
	db.dqReset = time() + (GetQuestResetTime or 0)	-- resolve game time to real time
end

function SavedClassic:PLAYER_XP_UPDATE()
	local db = self.db.realm[player]
	db.level = UnitLevel("player")
	db.expCurrent = UnitXP("player")
	db.expMax = UnitXPMax("player")
	if db.expMax == 0 then db.expMax = 1 end
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
	db.lastUpdate = time()
end

function SavedClassic:SaveDrugs()
	local db = self.db.realm[player]
	db.drugs = {}
	for i=1,32 do
		local name,icon,_,_,_,expire,_,_,_,id = UnitBuff("player", i)
		if id and self.drugs[id] then
			table.insert(db.drugs, { id = id, remain = floor((expire-GetTime())/60) })
		end
	end
	table.sort(db.drugs,
		function(a,b)
			ar = a.remain or 0
			br = b.remain or 0
			return ar > br
		end
	)
end

function SavedClassic:SaveTSCooldowns()
	local db = self.db.realm[player]
	local currentTime = time()

	for id,alt in pairs(self.ts) do
		local start, duration = GetSpellCooldown(id)
		if duration > 0 then
			local remain =  start + duration - GetTime()
			if remain > 0 and remain < duration+100 then
				local ends = currentTime + remain	-- resolve game time to real time
				db.tradeSkills[id] = db.tradeSkills[id] or {}
				db.tradeSkills[id].ends = ends
				db.tradeSkills[id].name = alt.altName or GetSpellInfo(id)
			end
		else
			db.tradeSkills[id] = nil
		end
	end
end

function SavedClassic:SaveSoulShards()
	self.db.realm[player].soulshards = GetItemCount(6265) or 0
end

function SavedClassic:ShowInfoTooltip(tooltip)
	local mode = ""
	local db = self.db.realm[player]
	local realm = ""
	if db.showInfoPer == "realm" then realm = " - " .. GetRealmName() end

	local totalGold = floor((self.totalMoney + db.money) / 10000)
	tooltip:AddDoubleLine(MSG_PREFIX .. realm .. MSG_SUFFIX, totalGold.. GOLD_ICON)

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
	self:SaveZone()

	local db = self.db.realm[character]
	local currentTime = time()
	local restXP = floor(min(db.expRest + (currentTime - (db.lastUpdate or 0)) / 28800 * 0.05 * db.expMax, db.expMax * 1.5))
	local restPercent = floor(restXP / db.expMax * 100)
	local elapsedTime = SecondsToTime(currentTime - db.lastUpdate)
	local tsstr, drugstr = "", ""
	if db.drugs then
		for _, d in ipairs(db.drugs) do
			if d.id and d.remain then
				local icon = GetSpellTexture(d.id) or ""
				drugstr = drugstr .. "|T".. icon ..":14:14|t".. d.remain ..L["minites"].." "
			end
		end
	end
	if db.tradeSkills then
		for id,ts in pairs(db.tradeSkills) do
			if ts and ts.ends then
				ts.name = ts.name or GetSpellInfo(id)
				local remain = ts.ends - currentTime
				if remain > 0 then
					tsstr = tsstr..ts.name.."(|cffcccccc"..SecondsToTime(remain).."|r) "
				end
			end
		end
	end

	if db["info1"] then
		local line1_1 = string.gsub(db["info1_1"], "(%%[RP])", function(s) if s == "%R" then return restXP else return restPercent end end)
		line1_1 = string.gsub(line1_1, "(%%L)", function(s) return elapsedTime end)
		line1_1 = string.gsub(line1_1, "(%%B)", function(s) return drugstr end)
		line1_1 = string.gsub(line1_1, "(%%T)", function(s) return tsstr end)
		line1_1 = string.gsub(line1_1, "(%%[%w%%])", function(s) if pt[s] then return db[pt[s]] or pt[s] else return s end end)
		local line1_2 = string.gsub(db["info1_2"], "(%%[RP])", function(s) if s == "%R" then return restXP else return restPercent end end)
		line1_2 = string.gsub(line1_2, "(%%L)", function(s) return elapsedTime end)
		line1_2 = string.gsub(line1_2, "(%%B)", function(s) return drugstr end)
		line1_2 = string.gsub(line1_2, "(%%T)", function(s) return tsstr end)
		line1_2 = string.gsub(line1_2, "(%%d?[%w%%])", function(s) if pt[s] then return db[pt[s]] or pt[s] else return s end end)
		tooltip:AddDoubleLine(line1_1, line1_2)
	end

	if db["info2"] then
		local line2_1 = string.gsub(db["info2_1"], "(%%[RP])", function(s) if s == "%R" then return restXP else return restPercent end end)
		line2_1 = string.gsub(line2_1, "(%%L)", function(s) return elapsedTime end)
		line2_1 = string.gsub(line2_1, "(%%B)", function(s) return drugstr end)
		line2_1 = string.gsub(line2_1, "(%%T)", function(s) return tsstr end)
		line2_1 = string.gsub(line2_1, "(%%d?[%w%%])", function(s) if pt[s] then return db[pt[s]] or pt[s] else return s end end)
		local line2_2 = string.gsub(db["info2_2"], "(%%[RP])", function(s) if s == "%R" then return restXP else return restPercent end end)
		line2_2 = string.gsub(line2_2, "(%%L)", function(s) return elapsedTime end)
		line2_2 = string.gsub(line2_2, "(%%B)", function(s) return drugstr end)
		line2_2 = string.gsub(line2_2, "(%%T)", function(s) return tsstr end)
		line2_2 = string.gsub(line2_2, "(%%d?[%w%%])", function(s) if pt[s] then return db[pt[s]] or pt[s] else return s end end)
		tooltip:AddDoubleLine(line2_1, line2_2)
	end

	for i = 1, #db.raids do
		local raidInstance = db.raids[i]
		local remain = SecondsToTime(raidInstance.reset - time())
		if remain and ( remain ~= "" ) then
			if db["info3"] then
				local line3_1 = string.gsub(db["info3_1"], "(!t)", remain)
				line3_1 = string.gsub(line3_1, "([!%%][!%w])", function(s) if pt[s] then return instance[pt[s]] or pt[s] else return s end end)
				local line3_2 = string.gsub(db["info3_2"], "(!t)", remain)
				line3_2 = string.gsub(line3_2, "([!%%][!%w])", function(s) if pt[s] then return instance[pt[s]] or pt[s] else return s end end)
				tooltip:AddDoubleLine(line3_1, line3_2)
			end
		end
	end

	for i = 1, #db.heroics do
		local heroicInstance = db.heroics[i]
		local remain = SecondsToTime(heroicInstance.reset - time())
		if remain and ( remain ~= "" ) then
			if db["info4"] then
				local line4_1 = string.gsub(db["info4_1"], "(!t)", remain)
				line4_1 = string.gsub(line4_1, "([!%%][!%w])", function(s) if pt[s] then return heroicInstance[pt[s]] or pt[s] else return s end end)
				local line4_2 = string.gsub(db["info4_2"], "(!t)", remain)
				line4_2 = string.gsub(line4_2, "([!%%][!%w])", function(s) if pt[s] then return heroicInstance[pt[s]] or pt[s] else return s end end)
				tooltip:AddDoubleLine(line4_1, line4_2)
			end
		end
	end

end

function SavedClassic:InitUI()
--[[	local db = self.db.realm[player]
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
	end]]
end

function SavedClassic:InitDBIcon()
	self.icon = LibStub("LibDBIcon-1.0")
	self.iconLDB = LibStub("LibDataBroker-1.1"):NewDataObject(self.name .."Icon", {
		type = "data source",
		text = "Saved!",
		icon = "135757",
		OnClick = function() LibStub("AceConfigDialog-3.0"):Open(self.name) end,
		OnTooltipShow = function(tooltip) self:ShowInfoTooltip(tooltip) end,
	})
	self.icon:Register(self.name, self.iconLDB, self.db.realm[player].minimapIcon)
end

function SavedClassic:BuildOptions()
	local rdb = self.db.realm
	local ch = player
	local dupeTo = ""
	local names = {}
	local order = self.order
	for i = 1, #order do
		names[order[i].name] = rdb[order[i].name].coloredName
	end

	local db = self.db.realm[player]
	self.optionsTable = {
		name = self.name .. " option",
		handler = self,
		type = 'group',
		get = function(info) return rdb[ch][info[#info]] end,
		set = function(info, value) rdb[ch][info[#info]] = value end,
		args = {
			show = {
				name = L["Display settings"],
				type = "group",
				inline = true,
				order = 11,
				get = function(info) return db[info[#info]] end,
				set = function(info, value) db[info[#info]] = value end,
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
						max = GetMaxPlayerLevel(),
						step = 1,
						order = 131
					},
				}
			},
			character = {
				name = "캐릭터 선택",
				type = "select",
				values = names,
				set = function(info, k) ch = k return k end,
				get = function(info) return ch end,
				order = 21
			},
			resetButton1 = {
				name = L["Reset selected character"],
				type = "execute",
				func = function()
						if player == ch then
							self:ResetPlayerDB()
						else
							rdb[ch] = nil
							ch = player
							self:SetOrder()
						end
					end,
				confirm = function() return L["Are you really want to reset?"] end,
				order = 22
			},
			resetButton2 = {
				name = L["Reset all characters"],
				type = "execute",
				func = function() self:ResetWholeDB() end,
				confirm = function() return L["Are you really want to reset?"] end,
				order = 23
			},
			infoChar = {
				name = L["Tooltip - Character info."],
				type = "group",
				inline = true,
				order = 31,
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
						desc = L["Desc_Char"],
						order = 12
					},
					info1_2 = {
						name = L["Right"],
						type = "input",
						width = "full",
						desc = L["Desc_Char"],
						order = 13
					},
					info2_1 = {
						name = L["Left"],
						type = "input",
						width = "full",
						desc = L["Desc_Char"],
						order = 22
					},
					info2_2 = {
						name = L["Right"],
						type = "input",
						width = "full",
						desc = L["Desc_Char"],
						order = 23
					},
				},
			},

			infoRaid = {
				name = L["Tooltip - Raid instances"],
				type = "group",
				inline = true,
				order = 41,
				args = {
					info3 = {
						name = L["Lines of raid instances"],
						type = "toggle",
						order = 31
					},
					info3_1 = {
						name = L["Left"],
						type = "input",
						width = "full",
						desc = L["Desc_Inst"],
						order = 32
					},
					info3_2 = {
						name = L["Right"],
						type = "input",
						width = "full",
						desc = L["Desc_Inst"],
						order = 33
					},
				},
			},

			infoHeroic = {
				name = L["Tooltip - Heroic instances"],
				type = "group",
				inline = true,
				order = 51,
				args = {
					info4 = {
						name = L["Lines of heroic instances"],
						type = "toggle",
						order = 31
					},
					info4_1 = {
						name = L["Left"],
						type = "input",
						width = "full",
						desc = L["Desc_Inst"],
						order = 32
					},
					info4_2 = {
						name = L["Right"],
						type = "input",
						width = "full",
						desc = L["Desc_Inst"],
						order = 33
					},
				},
			},

			dupeSettings = {
				name = L["Dupe settings to"],
				type = "select",
				values = names,
				set = function(info, k) dupeTo = k return k end,
				get = function(info) return dupeTo end,
				order = 91
			},
			dupeButton = {
				name = L["Dupe"],
				type = "execute",
				func = function()
					local tdb = self.db.realm[dupeTo]
					tdb.info1 = rdb[ch].info1
					tdb.info1_1 = rdb[ch].info1_1
					tdb.info1_2 = rdb[ch].info1_2
					tdb.info2 = rdb[ch].info2
					tdb.info2_1 = rdb[ch].info2_1
					tdb.info2_2 = rdb[ch].info2_2
					tdb.info3 = rdb[ch].info3
					tdb.info3_1 = rdb[ch].info3_1
					tdb.info3_2 = rdb[ch].info3_2
					tdb.info4 = rdb[ch].info4
					tdb.info4_1 = rdb[ch].info4_1
					tdb.info4_2 = rdb[ch].info4_2
				end,
				confirm = function() return L["Dupe settings will overwirte character/instance info."] end,
				order = 92
			},
		},
	}
end
