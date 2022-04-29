local addonName, addon = ...
SavedClassic = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")

SavedClassic.name = addonName
--SavedClassic.version = GetAddOnMetadata(addonName, "Version")
SavedClassic.version = "2.1.2"

local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

local MSG_PREFIX = "|cff00ff00■ |cffffaa00Saved!|r "
local MSG_SUFFIX = " |cff00ff00■|r"
local GOLD_ICON = "|TInterface/MoneyFrame/UI-GoldIcon:14:14:2:0|t"
local SILVER_ICON = "|TInterface/MoneyFrame/UI-SilverIcon:14:14:2:0|t"
local COPPER_ICON = "|TInterface/MoneyFrame/UI-CopperIcon:14:14:2:0|t"

local player , _ = UnitName("player")
local _, class, _ = UnitClass("player")
local p = function(str) print(MSG_PREFIX..str..MSG_SUFFIX) end

SavedClassic.drugs = {	-- Flasks and Elixirs([B]attle, [G]uardian)
-- Flasks 
	[17626] = { inv = 13510, }, -- Flask of Titan
	[17627] = { inv = 13511, }, -- Flask of Distilled Wisdom
	[17628] = { inv = 13512, }, -- Flask of Supreme Power
	[17629] = { inv = 13513, }, -- Flask of Chromatic Resistance
	[28518] = { inv = 22851, }, -- Flask of Fortification - Health/Defense
	[28519] = { inv = 22853, }, -- Flask of Mighty Restoration - Mana Regen
	[28520] = { inv = 22854, }, -- Flask of Relentless Assault - AP
	[28521] = { inv = 22861, }, -- Flask of Blinding Light - Arcane/Holy/Nature
	[28540] = { inv = 22866, }, -- Flask of Pure Death - Shadow/Fire/Frost
	[42735] = { inv = 33208, }, -- Flask of Chromatic Resistance
	[46839] = { inv = 35717, }, -- Shattrath Flask of Blinding Light
	[41608] = { inv = 32901, }, -- Shattrath Flask of Relentless Assault
	[41609] = { inv = 32898, }, -- Shattrath Flask of Fortification
	[41610] = { inv = 32899, }, -- Shattrath Flask of Mighty Restoration
	[41611] = { inv = 32900, }, -- Shattrath Flask of Supreme Power
	[46837] = { inv = 35716, }, -- Shattrath Flask of Pure Death
-- Elixirs
	[11406] = { inv =  9224, }, -- [B] Elixir of Demonslaying
	[17537] = { inv = 13453, }, -- [B] Elixir of Brute Force
	[33720] = { inv = 28102, }, -- [B] Onslaught Elixir
	[33721] = { inv = 28103, }, -- [B] Adept's Elixir
	[28490] = { inv = 22824, }, -- [B] Elixir of Major Strength
	[28491] = { inv = 22825, }, -- [B] Elixir of Major Healing Power
	[28493] = { inv = 22827, }, -- [B] Elixir of Major Frost Power
	[28497] = { inv = 22831, }, -- [B] Elixir of Major Agility
	[28501] = { inv = 22833, }, -- [B] Elixir of Major Firepower
	[28503] = { inv = 22835, }, -- [B] Elixir of Major Shadow Power
	[28104] = { inv = 33726, }, -- [B] Elixir of Mastery / All stats
	[28502] = { inv = 22834, }, -- [G] Major Armor
	[28509] = { inv = 22840, }, -- [G] Elixir of Major Mageblood / Greater Mana Regeneration
	[28514] = { inv = 22848, }, -- [G] Elixir of Empowerment / Target resist -30
	[39625] = { inv = 32062, }, -- [G] Elixir of Major Fortitude
	[39626] = { inv = 32063, }, -- [G] Earthen Elixir
	[39627] = { inv = 32067, }, -- [G] Elixir of Draenic Wisdom
	[39628] = { inv = 32068, }, -- [G] Elixir of Ironskin / Resilence
	[38954] = { inv = 31679, }, -- [B] Fel Strength Elixir / AP
	[45373] = { inv = 34537, }, -- [B] Bloodberry Elixir / All stats @ Sunwell
	[28489] = { inv = 22823, }, -- Elixir of Camouflage / Cannot be tracked
	[28496] = { inv = 22830, }, -- Elixir of the Searching Eye / Stealth detection
}
SavedClassic.ts = {	-- Tradeskills of long cooldowns
	[29688] = { altName = L["Transmute"], },	-- Transmute: Primal Might
	[26751] = { },	-- Primal Mooncloth
	[31373] = { },	-- SpellCloth
	[36686] = { },	-- Shadowcloth
}
SavedClassic.items = {	-- Items to count always
	[6265] = { },	-- Soulshard
	[29434] = { },	-- Badge of Justice
}
local pt = {
	["%n"] = "coloredName",	["%N"] = "name",
	["%Z"] = "zone" ,	["%z"] = "subzone" ,

	["%g"] = "gold" ,	["%G"] = GOLD_ICON ,
	["%s"] = "silver" ,	["%S"] = SILVER_ICON ,
	["%c"] = "copper" ,	["%C"] = COPPER_ICON ,

	["%B"] = "drugstr",	["%T"] = "tsstr",
	["%L"] = "elapsedTime",

	["%l"] = "level",
	["%e"] = "expCurrent",	["%E"] = "expMax",	["%p"] = "expPercent",
	["%R"] = "restXP",	["%P"] = "restPercent",

	["%F"] = "|cff" ,	["%f"] = "|r" ,	["%r"] = "|n" ,
	["%%"] = "%" ,

	["!n"] = "name" ,	["!d"] = "difficultyName" ,
	["!i"] = "id" ,	["!p"] = "progress" ,	["!P"] = "numBoss" ,
	["!!"] = "!" ,

--	["!t"] = "" ,
	["%h"] = "honorPoint",	["%H"] = "|T137000:14:14:0:0:14:14:0:8:0:8|t",
	["%a"] = "arenaPoint",	["%A"] = "|T136729:14:14|t",

	["%d"] = "dqComplete",	["%D"] = "dqMax",	["%Q"] = "dqReset",
}

local dbDefault = {
	realm = {
		[player] = {
			frameX = 100,	frameY = 25,
			showInfoPer = "realm",
			hideLevelUnder = 1,

			default = true,
			minimapIcon = { hide = false },

			expCurrent = -1, expMax = -1, expPercent = -1, ExpRest = -1,

			honorPoint = -1, arenaPoint = -1,
			dqComplete = -1, dqMax = -1, dqReset = -1,

			lastUpdate = -1,
		}
	}
}

function SavedClassic:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SavedClassicDB", dbDefault)

	-- Reset data from older versions
	if not self.db.global.version then
		self.db:ResetDB()
	elseif self.db.global.version < "2" then
		p(L["Reset due to update"](self.db.global.version, self.version))
		self.db:ResetDB()
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
	self:RegisterEvent("UPDATE_INSTANCE_INFO", "SaveInfo")	-- API RequestRaidInfo() triggers UPDATE_INSTANCE_INFO

	self:RegisterEvent("TRADE_SKILL_UPDATE", "SaveTSCooldowns")

	self:RegisterEvent("BAG_UPDATE_DELAYED")
	self:RegisterEvent("QUEST_TURNED_IN")

	self:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN", "PVPCurrency")

	self.totalMoney = 0	-- Total money except current character
	for character, saved in pairs(self.db.realm) do
		if character and (character ~= player) and saved.money then
			self.totalMoney = self.totalMoney + saved.money
		end
	end

	self:ClearItemCount()
	self:QUEST_TURNED_IN()
	self:BAG_UPDATE_DELAYED()
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
			local al = a.level or 0
			local bl = b.level or 0
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
	playerdb.info1_1 = ""
	playerdb.info1_2 = "%r%Fffee99%g%G%f  "
	playerdb.info2 = true
	playerdb.info2_1 = ""
	playerdb.info2_2 = ""

	if UnitLevel("player") < GetMaxPlayerLevel() then
		if class == "WARLOCK" then
			playerdb.info1_1 = "%r%F00ff00■%f [%Fffffff%l%f:%n] %Fcc66cc%I{6265}%f %Fffffff(%Z: %z)%f"
		else
			playerdb.info1_1 = "%r%F00ff00■%f [%Fffffff%l%f:%n] %Fffffff(%Z: %z)%f"
		end
		playerdb.info2_1 = "   %Fcc66ff%e/%E (%p%%)%f %F66ccff+%R (%P%%)%f"	-- Exp
	else
		if class == "WARLOCK" then
			playerdb.info1_1 = "%r%F00ff00■%f [%n] %Fcc66cc%I{6265}%f %Fffffff(%Z: %z)%f"
		else
			playerdb.info1_1 = "%r%F00ff00■%f [%n] %Fffffff(%Z: %z)%f"
		end
		playerdb.info2_1 = "   %Fffffff%I{29434} %A%a %H%h%f %Fcccccc%B%f"	-- BoJ, Arena, Honor, Flask
	end

	playerdb.info3 = true
	playerdb.info3_1 = "   !n (!d) %Fccccaa!p/!P%f"
	playerdb.info3_2 = "!t "
	playerdb.info4 = true
	playerdb.info4_1 = "   %Fffff99!n (!d)%f %Fccccaa!p/!P%f"
	playerdb.info4_2 = "!t "

	playerdb.drugs = { }
	playerdb.raids = { }
	playerdb.heroics = { }
	playerdb.tradeSkills = { }
	playerdb.itemCount = { }

	playerdb.zone = ""
	playerdb.subzone = ""

	playerdb.lastUpdate = currentTime
	playerdb.frameShow = false
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
	self:SaveDrugs()
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

function SavedClassic:QUEST_TURNED_IN()
	local db = self.db.realm[player]
	local completed = GetDailyQuestsCompleted() or 0
	if (db.dqComplete or 0) == completed then
		C_Timer.After(2, function()
			db.dqComplete = GetDailyQuestsCompleted() or 0
		end)
	else
		db.dqComplete = completed
	end
	db.dqMax = GetMaxDailyQuests() or 0
	db.dqResetReal = time() + (GetQuestResetTime() or 0)	-- resolve game time to real time
end

function SavedClassic:PVPCurrency()
	local db = self.db.realm[player]
	db.honorPoint = PVPFrameHonorPoints:GetText()
	db.arenaPoint = PVPFrameArenaPoints:GetText()
end


function SavedClassic:PLAYER_XP_UPDATE()
	local db = self.db.realm[player]
	db.level = UnitLevel("player")
	db.expCurrent = UnitXP("player")
	local expMax = UnitXPMax("player")
	if expMax == 0 then expMax = db.expMax or 1 end
	db.expMax = expMax
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
	db.drugs = { }
	for i=1,40 do
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
		end)
end

function SavedClassic:SaveTSCooldowns()
	local db = self.db.realm[player]
	local currentTime = time()
	db.tradeSkills = db.tradeSkills or {}

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

function SavedClassic:ClearItemCount()
	self.db.realm[player].itemCount = { }
end

function SavedClassic:BAG_UPDATE_DELAYED()
	self:PVPCurrency()
	local db = self.db.realm[player]
	local infoStr = db.info1_1..db.info1_2..db.info2_1..db.info2_2
	local itemList = string.gmatch(infoStr, "%%[Iia]%{[^}]+%}")

	for itemLink in itemList do
		local itemID = self:StripLink(itemLink)
		db.itemCount[tonumber(itemID)] = GetItemCount(itemID) or 0
	end
	for id, _ in pairs(self.items) do
		db.itemCount[tonumber(id)] = GetItemCount(id) or 0
	end
end

function SavedClassic:StripLink(link)
	return string.match(link, "(%d+):") or string.match(link, "(%d+)")
end

function SavedClassic:FOR_CURRENCY_UPDATE(...)
	-- name, CurrentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered = GetCurrencyInfo(index)
	-- For honor point
--	local _, db.honorPoint, _, earnedThisWeek, weeklyMax, totalMax = GetCurrencyInfo(392)
--	local _, db,justice, _, earnedThisWeek, weeklyMax, totalMax = GetCurrencyInfo(395)
end

function SavedClassic:ShowInfoTooltip(tooltip)
	local mode = ""
	local db = self.db.realm[player]
	local realm = ""
	if db.showInfoPer == "realm" then realm = " - " .. GetRealmName() end

	local totalGold = floor((self.totalMoney + db.money) / 10000)
	tooltip:AddDoubleLine(MSG_PREFIX .. realm .. MSG_SUFFIX, totalGold.. GOLD_ICON)

	self:SaveZone()
	self:SaveDrugs()
	self:QUEST_TURNED_IN()
	self:BAG_UPDATE_DELAYED()

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

	local drugstr, tsstr = "", ""
	if db.drugs then
		for _, d in ipairs(db.drugs) do
			if d.id and d.remain then
				local drug = self.drugs[d.id]
				if drug then
					local icon = drug.inv and GetItemIcon(drug.inv) or GetSpellTexture(d.id)
					drugstr = drugstr .. "|T".. icon ..":14:14|t".. d.remain ..L["minites"].." "
				end
			end
		end
	end
	if db.chrono then
		local cdstr = ""
		for i,b in ipairs(db.chrono) do
			if b.id and b.remain and b.remain > 0 then
				local icon = GetSpellTexture(b.id) or ""
				cdstr = cdstr .. "|T".. icon ..":14:14|t".. b.remain ..L["minites"].." "
			end
		end
		if cdstr ~= "" then
			cdstr = string.sub(cdstr,1,-2)	-- trim trailing space
			drugstr = drugstr.."("..cdstr..")"
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
	db.tsstr = tsstr

	if db.dqResetReal and currentTime > db.dqResetReal then
		db.dqComplete = 0
	end

	db.dqReset = SecondsToTime(GetQuestResetTime() or 0)
	db.drugstr = drugstr
	db.elapsedTime = SecondsToTime(currentTime - db.lastUpdate)
	db.restXP = floor(min(db.expRest + (currentTime - db.lastUpdate) / 28800 * 0.05 * db.expMax, db.expMax * 1.5))
	db.restPercent = floor(db.restXP / db.expMax * 100)

	local function getItemStr(opt, link)
		local itemID = self:StripLink(link)
		local t = { }
		t.i = "|T"..GetItemIcon(itemID)..":14:14|t"
		t.a = db.itemCount[tonumber(itemID)] or 0
		t.I = t.i..t.a
		return t[opt]
	end
	if db.info1 then
		local line1_1 = string.gsub(db.info1_1, "%%([Iia])%{([^}]+)%}", getItemStr)
		line1_1 = string.gsub(line1_1, "(%%[%w%%])", function(s) if pt[s] then return db[pt[s]] or pt[s] else return s end end)
		local line1_2 = string.gsub(db.info1_2, "%%([Iia])%{([^}]+)%}", getItemStr)
		line1_2 = string.gsub(line1_2, "(%%[%w%%])", function(s) if pt[s] then return db[pt[s]] or pt[s] else return s end end)
		tooltip:AddDoubleLine(line1_1, line1_2)
	end
	if db.info2 then
		local line2_1 = string.gsub(db.info2_1, "%%([Iia])%{([^}]+)%}", getItemStr)
		line2_1 = string.gsub(line2_1, "(%%[%w%%])", function(s) if pt[s] then return db[pt[s]] or pt[s] else return s end end)
		local line2_2 = string.gsub(db.info2_2, "%%([Iia])%{([^}]+)%}", getItemStr)
		line2_2 = string.gsub(line2_2, "(%%[%w%%])", function(s) if pt[s] then return db[pt[s]] or pt[s] else return s end end)
		tooltip:AddDoubleLine(line2_1, line2_2)
	end

	db.raids = db.raids or {}
	for i = 1, #db.raids do
		local raidInstance = db.raids[i]
		local remain = SecondsToTime(raidInstance.reset - time())

		if remain and ( remain ~= "" ) then
			if db.info3 then
				local line3_1 = string.gsub(db.info3_1, "(!t)", remain)
				line3_1 = string.gsub(line3_1, "([!%%][!%w])", function(s) if pt[s] then return raidInstance[pt[s]] or pt[s] else return s end end)
				local line3_2 = string.gsub(db.info3_2, "(!t)", remain)
				line3_2 = string.gsub(line3_2, "([!%%][!%w])", function(s) if pt[s] then return raidInstance[pt[s]] or pt[s] else return s end end)
				tooltip:AddDoubleLine(line3_1, line3_2)
			end
		end
	end

	db.heroics = db.heroics or {}
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
	local db = self.db.realm[player]
	local ui = CreateFrame("Button", self.name.."FloatingUI", UIParent, "BackdropTemplate")
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
	local copyTo = ""
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
							db[info[#info] ] = value
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
				name = L["Select character"],
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

			copySettings = {
				name = L["Copy settings to"],
				type = "select",
				values = names,
				set = function(info, k) copyTo = k return k end,
				get = function(info) return copyTo end,
				order = 91
			},
			copyButton = {
				name = L["Copy"],
				type = "execute",
				func = function()
					local tdb = self.db.realm[copyTo]
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
				confirm = function() return L["Confirm copy"] end,
				order = 92
			},
		},
	}
end
