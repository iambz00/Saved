local AddonName, Addon = ...
SavedClassic = LibStub("AceAddon-3.0"):NewAddon(AddonName, "AceEvent-3.0")

SavedClassic.name = AddonName
SavedClassic.version = GetAddOnMetadata(AddonName, "Version")
SavedClassic.prefix = "|cff00ff00■ |cffffaa00Saved!|r"
SavedClassic.suffix = "|cff00ff00■|r"

local SAVED_MSG_PREFIX = "|cff00ff00■ |cffffaa00Saved!|r"
local SAVED_MSG_SUFFIX = "|cff00ff00■|r"
local SAVED_GOLD_ICON = "|TInterface/MoneyFrame/UI-GoldIcon:14:14:2:0|t"
local SAVED_SILVER_ICON = "|TInterface/MoneyFrame/UI-SilverIcon:14:14:2:0|t"
local SAVED_COPPER_ICON = "|TInterface/MoneyFrame/UI-CopperIcon:14:14:2:0|t"

local player , _ = UnitName("player")
local _, class, _ = UnitClass("player")

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
	["!i"] = "ID" ,
	["!p"] = "progress" ,
	["!P"] = "numBoss" ,
	["!e"] = "extended" ,
	["!!"] = "return '!'" ,

--	["!t"] = "" ,
}

local dbDefault = {
	global = {
		version = SavedClassic.version
	},
	realm = {
		[player] = {
			frameX = 100,
			frameY = 25,
			showInfoPer = "realm",
			hideLevelUnder = 1,

			default = true,
			minimapIcon = { hide = true }
		}
	}
}

function SavedClassic:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SavedClassicDB", dbDefault)
	if self.db.global.version ~= self.version then
		print(SAVED_MSG_PREFIX.." - 버전 변경으로 모든 정보를 리셋합니다. ("..self.version..") "..SAVED_MSG_SUFFIX)
		self.db:ResetDB()
	end
	self.db.global.version = self.version

	if self.db.realm[player].default then self:InitPlayerDB() end

	self:InitDBIcon()
	self:InitUI()

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
end

function SavedClassic:OnDisable()
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
	playerdb.showMinimapIcon = false

end

function SavedClassic:SaveInfo()
	local db = self.db.realm[player]
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
				instance.extended = "(연장)"
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
		for character, _ in pairs(self.db.realm) do
			if character then
				self:ShowInstanceInfo(tooltip, character)
			end
		end
	else
		self:ShowInstanceInfo(tooltip, player)
	end
end

function SavedClassic:ShowInstanceInfo(tooltip, character)
	local db = self.db.realm[character]
	local currentTime = time()

	if db["info1"] then
		local line1_1 = string.gsub(db["info1_1"], "(%%[RP])", function(s)
				local r = floor(min(db.expRest + (currentTime - db.lastUpdate) / 28800 * 0.05 * db.expMax), db.expMax * 1.5)
				if s == "%R" then return r else return floor(r / db.expMax * 100) end
			end)
		line1_1 = string.gsub(line1_1, "(%%[%w%%])", function(s) return db[pt[s]] or loadstring(pt[s])() end)
		local line1_2 = string.gsub(db["info1_2"], "(%%[RP])", function(s)
				local r = floor(min(db.expRest + (currentTime - db.lastUpdate) / 28800 * 0.05 * db.expMax), db.expMax * 1.5)
				if s == "%R" then return r else return floor(r / db.expMax * 100) end
			end)
		line1_2 = string.gsub(line1_2, "(%%[%w%%])", function(s) return db[pt[s]] or loadstring(pt[s])() end)
		tooltip:AddDoubleLine(line1_1, line1_2)
	end
	if db["info2"] then
		local line2_1 = string.gsub(db["info2_1"], "(%%[RP])", function(s)
				local r = floor(min(db.expRest + (currentTime - db.lastUpdate) / 28800 * 0.05 * db.expMax), db.expMax * 1.5)
				if s == "%R" then return r else return floor(r / db.expMax * 100) end
			end)
		line2_1 = string.gsub(line2_1, "(%%[%w%%])", function(s) return db[pt[s]] or loadstring(pt[s])() end)
		local line2_2 = string.gsub(db["info2_2"], "(%%[RP])", function(s)
				local r = floor(min(db.expRest + (currentTime - db.lastUpdate) / 28800 * 0.05 * db.expMax), db.expMax * 1.5)
				if s == "%R" then return r else return floor(r / db.expMax * 100) end
			end)
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

	ui:SetUserPlaced(true)
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
	if self.db.realm[player].showMinimapIcon then
		self:RegisterDBIcon()
	end
end

function SavedClassic:RegisterDBIcon()
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
				name = "표시 설정",
				type = "group",
				inline = true,
				order = 1,
				args = {
					frameShow = {
						name = "별도프레임 표시",
						type = "toggle",
						order = 101,
						set = function(info, value)
							db.frameShow = value
							if value then
								self.ui:Show()
							else
								self.ui:Hide()
							end
						end,
					},
					frameX = {
						name = "프레임 너비",
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
						name = "프레임 높이",
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
					showMinimapIcon = {
						name = "미니맵 아이콘 표시",
						type = "toggle",
						order = 111,
						set = function(info, value)
							db.showMinimapIcon = value
							if value then
								if self.icon:IsRegistered(self.name) then
									self.icon:Show(self.name)
								else
									self:RegisterDBIcon()
								end
							else
								self.icon:Hide(self.name)
							end
						end,
					},
					showInfoPer = {
						name = "정보표시",
						type = "select",
						values = {
							char = "캐릭터별",
							realm = "서버별"
						},
						style = "radio",
						order = 121
					},
					hideLevelUnder = {
						name = "다음 레벨 미만 감추기",
						type = "range",
						min = 1,
						max = 59,
						step = 1,
						order = 131
					},
				}
			},
			infoChar = {
				name = "캐릭터별 정보",
				type = "group",
				inline = true,
				order = 2,
				args = {
					info1 = {
						name = "캐릭터별 정보 첫번째 줄",
						type = "toggle",
						order = 11
					},
					info2 = {
						name = "캐릭터별 정보 두번째 줄",
						type = "toggle",
						order = 21
					},
					info1_1 = {
						name = "왼쪽",
						type = "input",
						width = "full",
						order = 12
					},
					info1_2 = {
						name = "오른쪽",
						type = "input",
						width = "full",
						order = 13
					},
					info2_1 = {
						name = "왼쪽",
						type = "input",
						width = "full",
						order = 22
					},
					info2_2 = {
						name = "오른쪽",
						type = "input",
						width = "full",
						order = 23
					},
					descChar = {
						name = "|cff00ff00■|r |cffccaa00캐릭터별 정보 사용법|r|n"
							.."|cffccaa00%n|r 캐릭터명(직업색상)     |cffccaa00%N|r 캐릭터명(색상없음)|n"
							.."%g 골드  %G |TInterface/MoneyFrame/UI-GoldIcon:14:14:2:0|t     "
							.."%s 실버  %S |TInterface/MoneyFrame/UI-SilverIcon:14:14:2:0|t     "
							.."%c 코퍼  %C |TInterface/MoneyFrame/UI-CopperIcon:14:14:2:0|t|n"
							.."%e 현재 경험치     %E 최대 경험치     %R 휴식경험치(예상치)|n"
							.."%Z 현재 위치       %z 세부 위치       %r 한 줄 띄우기|n"
							.."%F###### |cffffffff컬러 시작. RGB코드 000000~ffffff|r     "
							.."%Fffffff흰색%f => |cffffffff흰색, |r %Fff0000빨간색%f => |cffff0000빨간색|r"
						,
						type = "description",
						order = 99
					},
				},
			},

			infoInst = {
				name = "귀속 정보",
				type = "group",
				inline = true,
				order = 3,
				args = {
					info3 = {
						name = "공격대 귀속 정보 표시줄",
						type = "toggle",
						order = 31
					},
					info3_1 = {
						name = "왼쪽",
						type = "input",
						width = "full",
						order = 32
					},
					info3_2 = {
						name = "오른쪽",
						type = "input",
						width = "full",
						order = 33
					},
					descChar = {
						name = "|cff00ff00■|r 인스턴스 정보 사용법|n"
							.."!n 인스턴스명             !d 인원 및 난이도     "
							.."!t 리셋까지 남은 시간     !i 인스턴스 ID        "
							.."!p 진행 상황(보스 킬 수)  !P 보스 수      !e 연장 표시"
						,
						type = "description",
						order = 99
					},

				},
			},
			resetButton = {
				name = "설정 초기화",
				type = "execute",
				func = function()
					self.db.realm[player] = {}
					self:InitPlayerDB()
				end,
				confirm = function() return "정말로 초기화합니까?" end,
				order = 99
			}
		},
	}
end
