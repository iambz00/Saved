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

SavedClassic.wb = {	-- Texture pathes of world buffs
	[23768] = "Interface/Icons/INV_Misc_orb_02",	-- DF damage 세이지 공격력
	[23766] = "Interface/Icons/INV_Misc_orb_02",	-- DF int 세이지 지능
	[22888] = "Interface/Icons/INV_Misc_Head_Dragon_01",	-- Ony, Nef 용사냥꾼 재집결의 외침
	[24425] = "Interface/Icons/Ability_Creature_Poison_05",	-- Zul'gurub 잔달라의 기백
	[22817] = "Interface/Icons/Spell_Nature_UndyingStrength",	-- DM1 펜구스의 흉포
	[22818] = "Interface/Icons/Spell_Nature_MassTeleport",	-- DM2 몰다르의 투지
	[22820] = "Interface/Icons/Spell_Holy_LesserHeal02",	-- DM3 슬립킥의 손재주
	[24382] = "Interface/Icons/INV_Potion_30",	-- Zanza 잔자의 기백
	[15366] = "Interface/Icons/Spell_Holy_MindVision",	-- SF 노래꽃의 세레나데
	[16609] = "Interface/Icons/Spell_Arcane_TeleportOrgrimmar",	-- 대족장의 축복
}

SavedClassic.ts = {	-- Tradeskills of long cooldowns
	17187, 	-- 변환식: 아케이나이트 48
	17559, 	-- 변환식: 바람을 불로 24
	17560, 	-- 변환식: 불을 대지로 24
	17561, 	-- 변환식: 대지를 물로 24
	17562, 	-- 변환식: 물을 바람으로 24
	17563, 	-- 변환식: 불사를 물로 24
	17564, 	-- 변환식: 물을 불사로 24
	17565, 	-- 변환식: 생명을 대지로 24
	17566, 	-- 변환식: 대지를 생명으로 24
	18560, 	-- 달빛 옷감 96
	19566, 	-- 소금 정제기 72
}



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
--	["%B"] = ""

	["%F"] = "return '|cff'" , 
	["%f"] = "return '|r'" , 
	["%r"] = "return '\\n'" ,

	["%%"] = "return '%'" ,

	["!n"] = "name" ,
	["!d"] = "difficultyName" ,
	["!i"] = "id" ,
	["!p"] = "progress" ,
	["!P"] = "numBoss" ,
	["!e"] = "return ''" ,	-- classic doesn't support extened
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
			minimapIcon = { hide = false },
			worldBuffs = {},
			tradeSkills = {},
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
	self:RegisterEvent("ZONE_CHANGED", "SaveInfo")
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "SaveInfo")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "RequestRaidInfo")
	-- API RequestRaidInfo() triggers UPDATE_INSTANCE_INFO
	self:RegisterEvent("UPDATE_INSTANCE_INFO", "SaveInfo")

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
	-- Hide exp info on max level
	if UnitLevel("player") < GetMaxPlayerLevel() then
		playerdb.info2 = true
		playerdb.info1_1 = "%r%F00ff00■%f [%Fffffff%l%f:%n] %Fffffff(%Z: %z)%f"
		playerdb.info2_1 = "   %Fcc66ff%e/%E (%p%%)%f %F66ccff+%R (%P%%)%f"	-- for exp
	else
		--playerdb.info2 = false
		playerdb.info2 = true
		playerdb.info1_1 = "%r%F00ff00■%f [%n] %Fffffff(%Z: %z)%f"
		playerdb.info2_1 = "   %Fcccccc%B%f"	-- for world buffs
	end
	playerdb.info3 = true

	playerdb.info1_2 = "%r%Fffee99%g%G%f  "
	playerdb.info2_2 = ""
	playerdb.info3_1 = "   !n (!d) %Fccccaa!p/!P%f"
	playerdb.info3_2 = "!t "
	playerdb.instances = { }
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
	self:SaveWorldBuff()
	self:SaveTSCooldowns()
--	db.lastUpdate = currentTime -- Moved into SaveZone()
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
	db.lastUpdate = time()
end

function SavedClassic:SaveWorldBuff()
	local db = self.db.realm[player]
	db.worldBuffs = {}
	for i=1,32 do
		local name,icon,_,_,_,expire,_,_,_,id = UnitBuff("player", i)
		if id and self.wb[id] then
			db.worldBuffs[id] = floor((expire-GetTime())/60)	-- remining time in minutes
		end
	end
end

function SavedClassic:SaveTSCooldowns()
	local db = self.db.realm[player]
	db.tradeSkills = {}
	for _,id in pairs(self.ts) do
		local start,dur = GetSpellCooldown(id)
		if dur > 0 then
			db.tradeSkills[id] = {
				start = start,
				duration = dur,
			}
		end
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
	local elapsedTime = SecondsToTime(currentTime - db.lastUpdate)
	local wbstr,tsstr = "",""
	if db.worldBuffs then
		for id,t in pairs(db.worldBuffs) do
			wbstr = wbstr .. "|T".. self.wb[id] ..":14:14|t".. t..L["minites"].." "
		end
	end
	if db.tradeSkills then
		for id,v in pairs(db.tradeSkills) do
			local name = GetSpellInfo(id)
			local remain = v.start + v.duration - GetTime()
			if remain > 345600 then	-- if cooldown is over 96h, we've met server reset and addon's not able to calc it
				remain = "확인 필요"
			else
				remain = SecondsToTime(remain)
			end
			tsstr = tsstr..name.."(|cffcccccc"..remain.."|r) "
		end
	end


	if db["info1"] then
		local line1_1 = string.gsub(db["info1_1"], "(%%[RP])", function(s) if s == "%R" then return restXP else return restPercent end end)
		line1_1 = string.gsub(line1_1, "(%%L)", function(s) return elapsedTime end)
		line1_1 = string.gsub(line1_1, "(%%B)", function(s) return wbstr end)
		line1_1 = string.gsub(line1_1, "(%%T)", function(s) return tsstr end)
		line1_1 = string.gsub(line1_1, "(%%[%w%%])", function(s) if pt[s] then return db[pt[s]] or loadstring(pt[s])() else return s end end)
		local line1_2 = string.gsub(db["info1_2"], "(%%[RP])", function(s) if s == "%R" then return restXP else return restPercent end end)
		line1_2 = string.gsub(line1_2, "(%%L)", function(s) return elapsedTime end)
		line1_2 = string.gsub(line1_2, "(%%B)", function(s) return wbstr end)
		line1_2 = string.gsub(line1_2, "(%%T)", function(s) return tsstr end)
		line1_2 = string.gsub(line1_2, "(%%[%w%%])", function(s) if pt[s] then return db[pt[s]] or loadstring(pt[s])() else return s end end)
		tooltip:AddDoubleLine(line1_1, line1_2)
	end
	if db["info2"] then
		local line2_1 = string.gsub(db["info2_1"], "(%%[RP])", function(s) if s == "%R" then return restXP else return restPercent end end)
		line2_1 = string.gsub(line2_1, "(%%L)", function(s) return elapsedTime end)
		line2_1 = string.gsub(line2_1, "(%%B)", function(s) return wbstr end)
		line2_1 = string.gsub(line2_1, "(%%T)", function(s) return tsstr end)
		line2_1 = string.gsub(line2_1, "(%%[%w%%])", function(s) if pt[s] then return db[pt[s]] or loadstring(pt[s])() else return s end end)
		local line2_2 = string.gsub(db["info2_2"], "(%%[RP])", function(s) if s == "%R" then return restXP else return restPercent end end)
		line2_2 = string.gsub(line2_2, "(%%L)", function(s) return elapsedTime end)
		line2_2 = string.gsub(line2_2, "(%%B)", function(s) return wbstr end)
		line2_2 = string.gsub(line2_2, "(%%T)", function(s) return tsstr end)
		line2_2 = string.gsub(line2_2, "(%%[%w%%])", function(s) if pt[s] then return db[pt[s]] or loadstring(pt[s])() else return s end end)
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
				line3_1 = string.gsub(line3_1, "([!%%][!%w])", function(s) if pt[s] then return instance[pt[s]] or loadstring(pt[s])() else return s end end)
				local line3_2 = string.gsub(db["info3_2"], "(!t)", remain)
				line3_2 = string.gsub(line3_2, "([!%%][!%w])", function(s) if pt[s] then return instance[pt[s]] or loadstring(pt[s])() else return s end end)
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
		--names[i] = rdb[order[i].name].coloredName /run for k,v in pairs(SavedClassic.orderedList) do print(k,v) end
	end
--	self.orderedList = names

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
						max = 59,
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

			infoInst = {
				name = L["Tooltip - Instance info"],
				type = "group",
				inline = true,
				order = 41,
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
				end,
				confirm = function() return L["Dupe settings will overwirte character/instance info."] end,
				order = 92
			},
		},
	}
end
