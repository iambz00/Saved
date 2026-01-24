local addonName, _ = ...

local SavedClassic = LibStub("AceAddon-3.0"):GetAddon(addonName)
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)
local LibTable = LibStub:GetLibrary("LibTable")

local MSG_PREFIX = "|cff00ff00■ |cffffaa00Saved!|r "
local MSG_SUFFIX = " |cff00ff00■|r"

local player , _ = UnitName("player")
local _, class, _ = UnitClass("player")
local function p(str) print(MSG_PREFIX..str..MSG_SUFFIX) end
local function reverse(direction)
    if direction == "LEFT" then
        return "RIGHT"
    elseif direction == "RIGHT" then
        return "LEFT"
    elseif direction == "TOP" then
        return "BOTTOM"
    elseif direction == "BOTTOM" then
        return "TOP"
    end
end

local dbDefault = {
    global = {
        maxQty = { },
    },
    profile = {
        TOOLTIP_SCALE = 100,
        FLOAT_UI = false,
        FLOAT_UI_W = 100,    FLOAT_UI_H = 25,
        MINIMAP_ICON = { hide = false },
        DISPLAY_SCOPE = "realm",
        TOTAL_GOLD = true,
        HIDE_LEVEL = 1,
        CURRENT_1ST = true,
        SORT_BY = "level",
        SORT_ORDER = 0,
        EXCLUDE = "",

        INFO1 = true,
        INFO1_L = format("\n[%s/00ff00]■[%s] [[%s]] [%s] [%s/ffffff]([%s]: [%s])[%s]",
                    L["color"], L["color"], L["name"], L["ilvl"], L["color"], L["zone"], L["subzone"], L["color"]),
        INFO1_R = format("\n[%s:%s/ffee99]", L["currency"], L["gold"]),
        INFO2 = true,
        INFO2_L = format("   [%s/ffffff][%s:%s] [%s:%s] [%s:%s] [%s:%s] [%s:%s] [%s:%s] [%s:%s] [%s:%s][%s]",
                    L["color"], L["currency"], L["VP"], L["currency"], L["JP"], L["currency"], L["conquest"], L["currency"], L["honor"], L["currency"], L["Mogu"], L["currency"], L["Lesser"], L["currency"], L["Ironpaw"], L["currency"], L["August"], L["color"]),
        INFO2_R = format("[%s:256883/ffffff]", L["item"]),
        INFO3 = true,
        INFO3_SHORT = true,
        INFO3_L = format("   [%s] ([%s]) [%s]/[%s]", L["instName"], L["difficulty"], L["progress"], L["bosses"]),
        INFO3_R = format("[%s]", L["time"]),
        INFO4 = true,
        INFO4_SHORT = true,
        INFO4_L = format("   [%s/ffff99][%s] ([%s]) [%s]/[%s][/%s]", L["color"], L["instName"], L["difficulty"], L["progress"], L["bosses"], L["color"]),
        INFO4_R = format("[%s/ffff99]", L["time"]),
    },
    realm = {   -- Character-Specific
        ["**"] = {  -- Default for every Characters
            default = true,
            name = "",
            coloredName = "",

            raids = { },
            heroics = { },
            tradeSkills = { },
            itemCount = { },
            currencyCount = { },

            zone = "",
            subzone = "",

            expCurrent = -1, expMax = -1, expPercent = -1, ExpRest = -1,
            honorPoint = -1, arenaPoint = -1,
            dqComplete = -1, dqMax = -1, dqReset = -1,

            lastUpdate = -1,
            gearAvgLevel = -1,
            gearEquippedLevel = -1,
        },
    }
}

local _TranslationTable = {
    ["color"    ] = function(_, _, color) return ((color and color ~= "") and "|cff"..color or "|r"), true end,
    ["item"     ] = function(db, option)
                        local _, itemLink = C_Item.GetItemInfo(option)
                        if itemLink then
                            local id = SavedClassic:StripLink(itemLink)
                            local result = "|T"..C_Item.GetItemIconByID(id)..":14:14|t"..(db.itemCount[id] or "-")
                            return result
                        else
                            return ""
                        end
                    end,
    ["currency" ] = function(db, option)
                        local currency_type
                        option:gsub("([^-]*)-(.*)", function(a, b) -- Dash-Separated option
                            option = a
                            if type(option) == "string" then
                                option = option:lower()
                            end
                            currency_type = b
                        end)
                        local id = tonumber(option)
                        local currency = id and SavedClassic.currencies[id] or SavedClassic.currencies[option]
                        if currency then
                            local result = ""
                            id = currency.id
                            local saved_currency = db.currencyCount[id] or { }
                            local maxQuantity = SavedClassic.db.global.maxQty[id] or 0
                            if maxQuantity > 0 then -- if currency has max quantity
                                if not currency_type or currency_type == "" then
                                    -- Show 'Earnable' amount(Type-2) for Valor, Conquest when no type specified
                                    -- If MaxQuantity >= 10000 then hide 'Earnable' (Type-0)
                                    -- But 'Earnable' <= 1600 show 'Earnable' (For those who work hard every week)
                                    currency_type = "0"
                                    local totalEarned = saved_currency.totalEarned or 0
                                    local earnable = maxQuantity - totalEarned
                                    if (earnable <= 1600) or (maxQuantity < 10000) then
                                        currency_type = "2"
                                    end
                                end
                            else     -- if currency doesn't have max quantity, force type-0
                                currency_type = "0"
                            end
                            if     currency_type == "0" then  -- Type-0: [Icon][Quantity]
                                result = currency.icon..(saved_currency.quantity or "")
                            elseif currency_type == "1" then  -- Type-1: [Icon][Quantity]([Earnable])
                                local earnable = (saved_currency.totalEarned or 0) - maxQuantity     -- Earnable is MINUS value
                                result = currency.icon..(saved_currency.quantity or "").."("..earnable..")"
                            elseif currency_type == "2" then  -- Type-2: [Icon][Quantity]([Earnable])
                                local earnable = maxQuantity - (saved_currency.totalEarned or 0)     -- Earnable is RED font
                                result = currency.icon..(saved_currency.quantity or "").."(|c".."FFFF7575"..earnable.."|r)"
                            elseif currency_type == "3" then  -- Type-3: [Icon][Quantity]([Earned]/[MaxQuantity])
                                result = currency.icon..(saved_currency.quantity or "").."("..(saved_currency.totalEarned or 0).."/"..maxQuantity..")"
                            end
                            return result
                        else
                            return ""
                        end
                    end,
    ["name"     ] = "coloredName",
    ["name2"    ] = "name",
    ["zone"     ] = "zone",
    ["subzone"  ] = "subzone",
    ["cooldown" ] = "tsstr",
    ["elapsed"  ] = "elapsedTime",
    ["level"    ] = "level",
    ["expCur"   ] = "expCurrent",
    ["expMax"   ] = "expMax",
    ["exp%"     ] = "expPercent",
    ["expRest"  ] = "restXP",
    ["expRest%" ] = "restPercent",
    ["dqCom"    ] = "dqComplete",
    ["dqReset"  ] = "dqReset",
    ["ilvl_equip"] = "gearEquippedLevel",
    ["ilvl_avg" ] = "gearAvgLevel",
    ["ilvl"     ] = function(db) return db.gearEquippedLevel.."/"..db.gearAvgLevel end,
    ["playedtotal"] = function(db) return SecondsToTime(db.played_total or 0) end,
    ["playedlevel"] = function(db) return SecondsToTime(db.played_level or 0) end,
    ["instName" ] = "name",
    ["instID"   ] = "id",
    ["difficulty"]= "difficultyName",
    ["progress" ] = "progress",
    ["bosses"   ] = "numBoss",
    ["time"     ] = function(instance) return SecondsToTime(instance.reset - time()) end,
    byLocale = {
        [L["color"     ] ] = "color",
        [L["item"      ] ] = "item",
        [L["currency"  ] ] = "currency",
        [L["name"      ] ] = "name",
        [L["name2"     ] ] = "name2",
        [L["zone"      ] ] = "zone",
        [L["subzone"   ] ] = "subzone",
        [L["cooldown"  ] ] = "cooldown",
        [L["elapsed"   ] ] = "elapsed",
        [L["level"     ] ] = "level",
        [L["expCur"    ] ] = "expCur",
        [L["expMax"    ] ] = "expMax",
        [L["exp%"      ] ] = "exp%",
        [L["expRest"   ] ] = "expRest",
        [L["expRest%"  ] ] = "expRest%",
        [L["dqCom"     ] ] = "dqCom",
        [L["dqReset"   ] ] = "dqReset",
        [L["ilvl"      ] ] = "ilvl",
        [L["ilvl_equip"] ] = "ilvl_equip",
        [L["ilvl_avg"  ] ] = "ilvl_avg",
        [L["playedtotal"] ]= "playedtotal",
        [L["playedlevel"] ]= "playedlevel",
        [L["instName"  ] ] = "instName",
        [L["instID"    ] ] = "instID",
        [L["difficulty"] ] = "difficulty",
        [L["progress"  ] ] = "progress",
        [L["bosses"    ] ] = "bosses",
        [L["time"      ] ] = "time",
    }
}
setmetatable(_TranslationTable, { __index = function(t,k) return t.byLocale[k] and t[t.byLocale[k] ] or k end })

local profile_exchange = {
    scale =         "TOOLTIP_SCALE",
    frameShow =     "FLOAT_UI",
    frameX =        "FLOAT_UI_W",
    frameY =        "FLOAT_UI_H",
    minimapIcon =   "MINIMAP_ICON",
    showInfoPer =   "DISPLAY_SCOPE",
    showTotalGold = "TOTAL_GOLD",
    hideLevelUnder= "HIDE_LEVEL",
    currentFirst =  "CURRENT_1ST",
    sortOrder =     "SORT_BY",
    sortOption =    "SORT_ORDER",
    exclude =       "EXCLUDE",
    info1 =         "INFO1",
    info1_1 =       "INFO1_L",
    info1_2 =       "INFO1_R",
    info2 =         "INFO2",
    info2_1 =       "INFO2_L",
    info2_2 =       "INFO2_R",
    info3 =         "INFO3",
    info3oneline =  "INFO3_SHORT",
    info3_1 =       "INFO3_L",
    info3_2 =       "INFO3_R",
    info4 =         "INFO4",
    info4oneline =  "INFO4_SHORT",
    info4_1 =       "INFO4_L",
    info4_2 =       "INFO4_R",
}

local function SavedClassic_GetCurrencyInfo(id)
    id = tonumber(id) or 0
    if id > 3 then
        return C_CurrencyInfo.GetCurrencyInfo(id)
    else
        return nil
    end
end

function SavedClassic:OnInitialize()
    self:InitDB()
    self:SetOrder()

    self:InitUI()
    self:InitDBIcon()
    self:InitRaidTable()

    self:BuildCurrencyInfo()
    self:BuildOptions() -- Build self.optionsTable
    LibStub("AceConfig-3.0"):RegisterOptionsTable(self.name, self.optionsTable)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(self.name, self.name, nil)
    self:InitUsageTable()

    self:RegisterEvent("PLAYER_MONEY", "CurrencyUpdate")
    self:RegisterEvent("PLAYER_XP_UPDATE")
    self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
    self:RegisterEvent("PLAYER_LEAVING_WORLD", "SaveZone")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "SaveInfo")

    self:RegisterEvent("ZONE_CHANGED", "SaveInfo")
    self:RegisterEvent("ZONE_CHANGED_INDOORS", "SaveInfo")
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "RequestRaidInfo")
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "CurrencyUpdate")
    self:RegisterEvent("UPDATE_INSTANCE_INFO", "SaveInfo")  -- API RequestRaidInfo() triggers UPDATE_INSTANCE_INFO

    self:RegisterEvent("TRADE_SKILL_UPDATE", "SaveTSCooldowns")

    self:RegisterEvent("BAG_UPDATE_DELAYED")
    self:RegisterEvent("QUEST_TURNED_IN")

    self:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN", "CurrencyUpdate")

    self:RegisterEvent("TIME_PLAYED_MSG")
    ChatFrame_DisplayTimePlayed_Original = ChatFrame_DisplayTimePlayed
    self.requestTimePlayedPending = false
    ChatFrame_DisplayTimePlayed = function(...)
        if not self.requestTimePlayedPending then
            ChatFrame_DisplayTimePlayed_Original(...)
        end
        self.requestTimePlayedPending = false
    end

    self.totalMoney = 0 -- Total money except current character
    for character, saved in pairs(self.db.realm) do
        if character and (character ~= player) and saved.currencyCount and saved.currencyCount[0] then
            self.totalMoney = self.totalMoney + (saved.currencyCount[0].quantity or 0)
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

function SavedClassic:InitDB()
    self.db = LibStub("AceDB-3.0"):New("SavedClassicDB", dbDefault, L["Common"])

    -- Reset Old DB
    self.db.global.version = self.db.global.version or "5.5.3.3"
    if self.db.global.version < "5.5.3.3" then
        p(L["Reset due to update"](self.db.global.version, self.version))
        self:ResetWholeDB()
    elseif self.db.global.version < "5.5.3.4" then
        for _, profile in pairs(SavedClassicDB.profiles) do
            for old, new in pairs(profile_exchange) do
                if profile[old] ~= nil then
                    profile[new] = profile[old]
                    profile[old] = nil
                end
            end
        end
    end
    self.db.global.version = self.version

    local db = self.db.realm[player]
    db = self.db.realm[player] or { }
    db.name = player
    db.coloredName = RAID_CLASS_COLORS[class]:WrapTextInColorCode(player)

    if db.default then
        if UnitLevel("player") < GetMaxPlayerLevel() then
            self.db:SetProfile(L["LowLevel"])
            if not tContains(self.db:GetProfiles(), L["LowLevel"]) then
                self.db.profile.INFO1_L = format("\n[%s/00ff00]■[%s] [[%s/ffffff]:[%s]] [%s] [%s/ffffff]([%s]: [%s])[%s]",
                                        L["color"], L["color"], L["level"], L["name"], L["ilvl"], L["color"], L["zone"], L["subzone"], L["color"])
                self.db.profile.INFO2_L = format("   [%s/cc66ff][%s]/[%s] ([%s]%%)[%s] [%s/66ccff]+[%s] ([%s]%%)[%s]",
                                        L["color"], L["expCur"], L["expMax"], L["exp%"], L["color"], L["color"], L["expRest"], L["expRest%"], L["color"])
                self.db.profile.INFO2_R = format("[%s/ffffff][%s:%s] [%s]",
                                        L["color"], L["currency"], L["JP"], L["color"])
            end
        end
    end
    db.default = false
end

function SavedClassic:SetOrder()
    self.order = self:GetSorted(self.db.realm)
end

function SavedClassic:GetSorted(rdb)
    local profile = self.db.profile
    local exclude = { }
    local order = { }

    for ch in string.gmatch(profile.EXCLUDE, "[^%s,;]*") do
        exclude[ch] = true
    end
    for ch, cdb in pairs(rdb) do
        if not exclude[ch] then
            table.insert(order, cdb)
        end
    end
    table.sort(order,
        function(a, b)
            if profile.CURRENT_1ST then
                if a.name == player then return true end
                if b.name == player then return false end
            end
            local aa = a[profile.SORT_BY] or 0
            local bb = b[profile.SORT_BY] or 0

            if profile.SORT_BY == "gold" then
                aa = a.currencyCount[0] and a.currencyCount[0].quantity or 0
                bb = b.currencyCount[0] and b.currencyCount[0].quantity or 0
            end

            if aa == bb then
                return a.name < b.name
            else
                if profile.SORT_ORDER == 1 then
                    return aa < bb
                else
                    return aa > bb
                end
            end
        end
    )
    return order
end

function SavedClassic:ResetWholeDB()
    self.db:ResetDB()
    self:InitDB()
    self:SetOrder()
    self.totalMoney = 0
    self:SaveInfo()
end

function SavedClassic:RequestRaidInfo()
    RequestRaidInfo()   -- RequestRaidInfo() triggers UPDATE_INSTANCE_INFO
end

function SavedClassic:SaveInfo()
    local db = self.db.realm[player]
    db.coloredName = RAID_CLASS_COLORS[class]:WrapTextInColorCode(player)
    local quests = GetQuestsCompleted()
    local raids, heroics = { }, { }
    local currentTime = time()

    -- instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName
    --      = GetSavedInstanceInfo(index)
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

    table.sort(raids, function(a,b)
        local aa, bb = self.abbr.raid[a.name], self.abbr.raid[b.name]
        if aa and aa.order and bb and bb.order then
            return ( aa.order < bb.order ) or ( aa.order == bb.order and a.difficultyName < b.difficultyName )
        else
            return ( a.name < b.name ) or ( a.name == b.name and a.difficultyName < b.difficultyName )
        end
    end)
    table.sort(heroics, function(a,b) return ( a.name < b.name ) or ( a.name == b.name and a.difficultyName > b.difficultyName ) end)

    db.raids = raids
    db.heroics = heroics

    -- World Boss
    local worldboss = {}
    local seconds_to_weekly_reset = C_DateAndTime.GetSecondsUntilWeeklyReset()
    for id, name in pairs(self.worldBoss) do
        local boss = {}
        if quests[id] then
            boss.name = name
            boss.reset = currentTime + seconds_to_weekly_reset
            worldboss[id] = boss
        end
    end
    db.worldboss = worldboss

    self:PLAYER_XP_UPDATE()
    self:PLAYER_EQUIPMENT_CHANGED()
    self:CurrencyUpdate()
    self:SaveZone()
    self:SaveTSCooldowns()
    self:QUEST_TURNED_IN()
    self:BAG_UPDATE_DELAYED()
    self:RequestTimePlayed()
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
    db.dqResetReal = time() + (GetQuestResetTime() or 0)    -- resolve game time to real time
end

function SavedClassic:RequestTimePlayed()
    self.requestTimePlayedPending = true
    RequestTimePlayed()
end

function SavedClassic:TIME_PLAYED_MSG(_, played_total, played_level)
    local db = self.db.realm[player]
    db.played_total = played_total
    db.played_level = played_level
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

function SavedClassic:PLAYER_EQUIPMENT_CHANGED()
    local db = self.db.realm[player]
    db.gearAvgLevel, db.gearEquippedLevel = GetAverageItemLevel()
    db.gearAvgLevel = floor(db.gearAvgLevel)
    db.gearEquippedLevel = floor(db.gearEquippedLevel)
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

function SavedClassic:SaveTSCooldowns()
    local db = self.db.realm[player]
    local currentTime = time()
    db.tradeSkills = db.tradeSkills or {}

    for id, ts in pairs(self.ts) do
        local info = C_Spell.GetSpellCooldown(id)
        if info.duration > 0 then
            local remain =  info.startTime + info.duration - GetTime()
            if remain > 0 and remain < info.duration + 100 then
                local ends = currentTime + remain   -- Resolve game time to real time
                id = ts.share or id
                db.tradeSkills[id] = db.tradeSkills[id] or {}
                db.tradeSkills[id].ends = math.max(db.tradeSkills[id].ends or 0, ends)
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
    local profile = self.db.profile
    local db = self.db.realm[player]
    local infoStr = profile.INFO1_L..profile.INFO1_R..profile.INFO2_L..profile.INFO2_R
    local itemList = string.gmatch(infoStr, "%["..L["item"]..":([^]/]+)[%]/]")

    for item in itemList do -- item link or ID or name
        local _, itemLink = C_Item.GetItemInfo(item)
        if itemLink then
            local itemID = self:StripLink(itemLink)
            db.itemCount[itemID] = C_Item.GetItemCount(itemLink, true) or 0
        end
    end
end

function SavedClassic:StripLink(link)
    return tonumber(string.match(link, "(%d+):") or string.match(link, "(%d+)")) or ""
end

function SavedClassic:PLAYER_MONEY()
    local money = abs(GetMoney())
    local db = self.db.realm[player]
    db.currencyCount[0] = { quantity = money }
    db.currencyCount[1] = { quantity = floor(money / 10000) }
    db.currencyCount[2] = { quantity = floor(money % 10000 / 100) }
    db.currencyCount[3] = { quantity = floor(money % 100) }
end

function SavedClassic:CurrencyUpdate()
    local db = self.db.realm[player]
    for _, currencyID in pairs(self.currencies.order) do
        local info = SavedClassic_GetCurrencyInfo(currencyID)
        if info then
            db.currencyCount[currencyID] = { quantity = tonumber(info.quantity) }
            if info.useTotalEarnedForMaxQty then
                db.currencyCount[currencyID]["totalEarned"] = info.totalEarned or 0
                if info.maxQuantity and info.maxQuantity > 0 then
                    self.db.global.maxQty = self.db.global.maxQty or {}
                    self.db.global.maxQty[currencyID] = info.maxQuantity
                end
            end
        end
    end
    self:PLAYER_MONEY()
end

function SavedClassic:ShowInfoTooltip(tooltip)
    local profile = self.db.profile
    local db = self.db.realm[player]

    if not self.ui.noticed then
        p(L["Raid Table Notice"])
        self.ui.noticed = true
    end
    self:SaveInfo()

    if profile.DISPLAY_SCOPE == "char" then
        tooltip:AddDoubleLine(MSG_PREFIX .. MSG_SUFFIX)
        self:ShowInstanceInfo(tooltip, player)
    else
        -- if profile.DISPLAY_SCOPE == "realm" then
        local totalGold = ""
        if profile.TOTAL_GOLD then
            totalGold = floor((self.totalMoney + db.currencyCount[0].quantity) / 10000).. self.currencies[1].icon
        end
        tooltip:AddDoubleLine(MSG_PREFIX .. " - " .. GetRealmName() .. MSG_SUFFIX, totalGold)
        for _, cdb in ipairs(self.order) do
            if cdb.level < profile.HIDE_LEVEL then
            else
                self:ShowInstanceInfo(tooltip, cdb.name)
            end
        end
    end

    if profile.DISPLAY_SCOPE == "account" then
        local n = 2
        for realm, rdb in pairs(SavedClassicDB.realm) do
            if realm ~= GetRealmName() then
                if not tooltip.nextTooltip then
                    tooltip.nextTooltip = CreateFrame("GameTooltip", tooltip:GetName()..addonName..n, tooltip, "GameTooltipTemplate")
                end
                tooltip.nextTooltip:SetOwner(tooltip, "ANCHOR_NONE")
                tooltip.nextTooltip.attachDirection = tooltip.attachDirection or "LEFT"
                tooltip.nextTooltip:SetPoint("TOP"..reverse(tooltip.attachDirection), tooltip, "TOP"..tooltip.attachDirection)
                tooltip = tooltip.nextTooltip
                local totalGold = ""
                local order = self:GetSorted(rdb)
                if profile.TOTAL_GOLD then
                    totalGold = 0
                    for _, cdb in ipairs(order) do
                        totalGold = totalGold + floor((cdb.currencyCount[0].quantity) / 10000)
                    end
                    totalGold = totalGold .. self.currencies[1].icon
                end

                tooltip:AddDoubleLine(MSG_PREFIX .. realm .. MSG_SUFFIX, totalGold)
                for _, cdb in ipairs(order) do
                    if (cdb.level or 0) < profile.HIDE_LEVEL then
                    else
                        self:ShowInstanceInfo(tooltip, cdb.name, realm)
                    end
                end
                tooltip:Show()
                n = n + 1
            end
        end
    end
end

function SavedClassic:GetProfile(character, realm)
    local profileName = SavedClassicDB.profileKeys[character.." - "..realm]
    return profileName, SavedClassicDB.profiles[profileName]
end

function SavedClassic:ShowInstanceInfo(tooltip, character, realm)
    local db
    if realm then
        db = SavedClassicDB.realm[realm][character]
        if not getmetatable(db) then
            setmetatable(db, { __index = function(_, k) return dbDefault.realm["**"][k] end })
        end
    else
        realm = GetRealmName()
        db = self.db.realm[character]
    end

    local _, profile = self:GetProfile(character, realm)
    if not getmetatable(profile) then
        setmetatable(profile, { __index = function(_, k) return dbDefault.profile[k] end })
    end

    local currentTime = time()

    local tsstr = ""
    if db.tradeSkills then
        for id, cooldown in pairs(db.tradeSkills) do
            local ts = self.ts[id]
            if ts and cooldown and cooldown.ends then
                --if ts.share then ts = self.ts[ts.share] end
                local remain = cooldown.ends - currentTime
                if remain > 0 then
                    local hh, mm = floor(remain / 3600), floor(remain % 3600 / 60)
                    local cooldown_str
                    if hh > 72 then
                        cooldown_str = format("%dd", floor(hh / 24))
                    else
                        cooldown_str = format("%02d:%02d", hh, mm)
                    end
                    tsstr = tsstr..(ts.icon or ts.altName or "")..cooldown_str
                else
                    db.tradeSkills[id] = nil
                end
            else
                db.tradeSkills[id] = nil
            end
        end
    end
    db.tsstr = tsstr

    if db.dqResetReal and currentTime > db.dqResetReal then
        db.dqComplete = 0
    end

    db.dqReset = SecondsToTime(GetQuestResetTime() or 0)
    db.elapsedTime = SecondsToTime(currentTime - db.lastUpdate)
    db.restXP = floor(min(db.expRest + (currentTime - db.lastUpdate) / 28800 * 0.05 * db.expMax, db.expMax * 1.5))
    db.restPercent = floor(db.restXP / db.expMax * 100)

    if profile.INFO1 then
        local line1_1 = self:TranslateCharacter(profile.INFO1_L, db)
        local line1_2 = self:TranslateCharacter(profile.INFO1_R, db)
        tooltip:AddDoubleLine(line1_1, line1_2)
    end
    if profile.INFO2 then
        local line2_1 = self:TranslateCharacter(profile.INFO2_L, db)
        local line2_2 = self:TranslateCharacter(profile.INFO2_R, db)
        tooltip:AddDoubleLine(line2_1, line2_2)
    end

    local worldboss = ""
    if db.worldboss then
        for _, boss in pairs(db.worldboss) do
            local remain = SecondsToTime(boss.reset - time())
            if remain and ( remain ~= "" ) then
                local name = boss.name
                worldboss = worldboss..name.." "
            end
        end
    end
    db.raids = db.raids or {}
    if profile.INFO3 then
        if profile.INFO3_SHORT then
            local oneline = ""
            local lit = {}
            for i = 1, #db.raids do
                local instance = db.raids[i]
                local remain = SecondsToTime(instance.reset - time())
                if remain and ( remain ~= "" ) then
                    local name = self.abbr.raid[instance.name] and self.abbr.raid[instance.name].name or instance.name
                    local size = instance.difficultyName:gsub("[^0-9]*","")
                    local li  = lit[#lit]
                    if not li or li and li.name ~= name then
                        li = {}
                        lit[#lit+1] = li
                    end
                    li.name = name
                    li.size = li.size or size
                    if li.size ~= size then
                        li.size = li.size.."/"..size
                    end
                end
            end
            for _, li in ipairs(lit) do
                oneline = oneline..li.name.."("..li.size..") "
            end
            if oneline ~= "" or worldboss ~= "" then
                tooltip:AddLine("   "..oneline..worldboss)
            end
        else
            for i = 1, #db.raids do
                local instance = db.raids[i]
                local remain = SecondsToTime(instance.reset - time())
                if remain and ( remain ~= "" ) then
                    local line3_1 = self:TranslateInstance(profile.INFO3_L, instance)
                    local line3_2 = self:TranslateInstance(profile.INFO3_R, instance)
                    tooltip:AddDoubleLine(line3_1, line3_2)
                end
            end
            if worldboss ~= "" then
                tooltip:AddDoubleLine("   "..worldboss, SecondsToTime(C_DateAndTime.GetSecondsUntilWeeklyReset()))
            end
        end
    end

    db.heroics = db.heroics or {}
    if profile.INFO4 then
        if profile.INFO4_SHORT then
            local oneline = ""
            for i = 1, #db.heroics do
                local instance = db.heroics[i]
                local remain = SecondsToTime(instance.reset - time())
                if remain and ( remain ~= "" ) then
                    oneline = oneline.." "..(self.abbr.heroic[instance.name] or instance.name)
                end
            end
            if oneline ~= "" then
                oneline = oneline:gsub("^ ","") -- trim leading space
                tooltip:AddLine("|cffffff99   "..oneline.."|r")
            end
        else
            for i = 1, #db.heroics do
                local instance = db.heroics[i]
                local remain = SecondsToTime(instance.reset - time())
                if remain and ( remain ~= "" ) then
                    local line4_1 = self:TranslateInstance(profile.INFO4_L, instance)
                    local line4_2 = self:TranslateInstance(profile.INFO4_R, instance)
                    tooltip:AddDoubleLine(line4_1, line4_2)
                end
            end
        end
    end
end

function SavedClassic:TranslateCharacter(line, db)
    -- [keyword] [keyword:option] [keyword/color] [keyword:option/color]
    return line:gsub("%]?|h%[?", "|h"):gsub("(%[([^]^[^/^:]*):?([^]^[^/]*)/?([^]^[]*)%])", function(...) return self:TranslateCharacterWord(db, ...) end )
end

function SavedClassic:TranslateCharacterWord(db, strBefore, keyword, option, color)
    local tKeyword = _TranslationTable[keyword]
    local result = strBefore
    local colorKeyword = false
    if tKeyword then
        if type(tKeyword) == "function" then    -- [color], [item], [currency] need option
            result, colorKeyword = tKeyword(db, option, color)  -- Don't escape for 'color' keyword
        else
            result = db[tKeyword] or strBefore
            if type(result) == "table" then
                result = strBefore
            end
        end
        if color and color~= "" then
            if colorKeyword then
                result = result
            else
                result = "|cff"..color..result.."|r"
            end
        end
    end
    return result
end

function SavedClassic:TranslateInstance(line, instance)
    -- [keyword] [keyword/color]
    return line:gsub("(%[([^]^[^/]*)/?([^]^[]*)%])", function(...) return self:TranslateInstanceWord(instance, ...) end )
end

function SavedClassic:TranslateInstanceWord(instance, strBefore, keyword, color)
    local tKeyword = _TranslationTable[keyword]
    local result = strBefore
    local colorKeyword = false
    if tKeyword then
        if type(tKeyword) == "function" then
            result, colorKeyword = tKeyword(instance, _, color) -- Don't escape for 'color' keyword
        else
            result = instance[tKeyword] or strBefore
        end
        if color and color~= "" then
            if colorKeyword then
                result = result
            else
                result = "|cff"..color..result.."|r"
            end
        end
    end
    return result
end

function SavedClassic:InitUI()
    local profile = self.db.profile
    local ui = CreateFrame("Button", self.name.."FloatingUI", UIParent, "BackdropTemplate")
    self.ui = ui
    ui:EnableMouse(true)
    ui:SetWidth(profile.FLOAT_UI_W)
    ui:SetHeight(profile.FLOAT_UI_H)
    ui:SetMovable(true)
    ui:SetBackdrop({
        bgFile = "Interface/TutorialFrame/TutorialFrameBackground",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    ui:SetBackdropBorderColor(1,0.82,0,1)
    ui:SetPoint("CENTER")

    local text = ui:CreateFontString()
    text:SetAllPoints()
    text:SetFontObject("GameFontNormal")
    text:SetText("|cff00ff00Saved|r ")

    ui:RegisterForDrag("LeftButton")
    ui:RegisterForClicks("LeftButtonDown", "RightButtonDown")

    --ui:SetUserPlaced(true)
    ui:SetScript("OnEnter", function(s)
        GameTooltip:Hide()
        GameTooltip:SetOwner(s, "ANCHOR_NONE")
        local cursorX, cursorY = GetCursorPosition()
        local anchorY = (cursorY < GetScreenHeight() / 2) and "TOP" or "BOTTOM"
        local anchorX = (cursorX < GetScreenWidth() / 2) and "RIGHT" or "LEFT"
        GameTooltip:SetPoint(reverse(anchorY)..anchorX, s, anchorY..anchorX)
        GameTooltip.attachDirection = anchorX

        self:ShowInfoTooltip(GameTooltip)
        GameTooltip:SetScale((profile.TOOLTIP_SCALE or 100) / 100)
        GameTooltip:Show()
    end)
    ui:SetScript("OnLeave", function() GameTooltip:Hide() end)
    ui:SetScript("OnClick", function(s, btn)
        if btn == "LeftButton" then
            if not IsShiftKeyDown() then
                self:ToggleRaidTable()
            end
        else
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

    if profile.FLOAT_UI then
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
        OnClick = function(_, btn)
            if btn == "LeftButton" then
                self:ToggleRaidTable()
            else
                self:ToggleConfig()
            end
        end,
        OnTooltipShow = function(tooltip)
            local cursorX, _ = GetCursorPosition()
            tooltip.attachDirection = (cursorX < GetScreenWidth() / 2) and "RIGHT" or "LEFT"
            self:ShowInfoTooltip(tooltip)
            tooltip:SetScale((self.db.profile.TOOLTIP_SCALE or 100) / 100)
        end,
    })
    self.icon:Register(self.name, self.iconLDB, self.db.profile.MINIMAP_ICON)
end

function SavedClassic:ToggleConfig()
    if self.configOpened then
        LibStub("AceConfigDialog-3.0"):Close(self.name)
        self.configOpened = nil
    else
        LibStub("AceConfigDialog-3.0"):Open(self.name)
        self.configOpened = true
    end
end

function SavedClassic:InitRaidTable()
    self.raidTable = self.raidTable or LibTable:CreateTable(self.name.."RaidTable", UIParent, nil,
        { SetMovable = true, SetUserPlaced = true, SetPoint = "CENTER", SetClampedToScreen = true, ESCClosable = true, PlaceCloseButton = true })
end

function SavedClassic:ToggleRaidTable()
    local raidTable = self.raidTable

    if raidTable:IsShown() then
        raidTable:Hide()
        return
    end

    local rdb = self.db.realm
    local maxLv = GetMaxPlayerLevel()
    local ilt = {}  -- Instance Lock Table(Ordered)

    for _, v in ipairs(self.order) do
        local name, level = v.name, v.level
        local db = rdb[name]

        if level < maxLv then
        else
            local locked = {}   -- locked[instance name] = 'size'
            for i = 1, #db.raids do
                local instance = db.raids[i]
                local remain = SecondsToTime(instance.reset - time())
                if remain and ( remain ~= "" ) then
                    local size = instance.difficultyName:gsub("[^0-9]*","")
                    locked[instance.name] = locked[instance.name] or size
                    if locked[instance.name] ~= size then
                        locked[instance.name] = locked[instance.name].."/"..size
                    end
                end
            end
            local worldboss = ""
            for _, boss in pairs(db.worldboss) do
                local remain = SecondsToTime(boss.reset - time())
                if remain and ( remain ~= "" ) then
                    local bossname = boss.name
                    worldboss = worldboss..bossname.." "
                end
            end
            if worldboss ~= "" then
                locked[L["World Boss"]] = worldboss
            end
            table.insert(ilt, { name = name, locked = locked })
        end
    end

    local lit = {}  -- Locked raids only(Exclude not-locked)
    for _, info in ipairs(ilt) do
        local locked = info and info.locked
        if locked then
            for instancename, size in pairs(locked) do
                if instancename then 
                    lit[instancename] = 1
                end
            end
        end
    end
    local olit = {} -- Ordered lit
    for k, _ in pairs(lit) do
        table.insert(olit, k)
    end
    table.sort(olit, function(a,b)
        return (self.abbr.raid[a].order or -400) < (self.abbr.raid[b].order or -400)
    end)

    local data = {}
    -- 1st Row(Title, Headers)
    local row1 = { MSG_PREFIX }
    for _, v in ipairs(olit) do
        local color = self.abbr.raid[v].color
        if color then
            table.insert(row1, WrapTextInColorCode(v, color))
        else
            table.insert(row1, v)
        end
    end
    table.insert(data, row1)
    -- Rows
    for _, info in ipairs(ilt) do
        local name, locked = info.name, info.locked
        local coloredName = (rdb[name] and rdb[name].coloredName) or name
        local row = { coloredName }
        for _, raidname in ipairs(olit) do table.insert(row, locked[raidname] or "-") end
        table.insert(data, row)
    end

--[[ Table [data] should be like
■ Saved     Raid1       Raid2       Raids3      ...
Character1  10/25       -           10/25       ...
Character2  -           10          -           ...
Character3  25          -           -           ...
...
]]
    raidTable:Resize({ rows = #data, cols = #data[1], widths = 80, heights = 24, })
    raidTable:SetRangeJustify(true, true, "CENTER")
    raidTable:SetTable(data)
    raidTable:SetRangeOption(true, true, { SetTextColor={ 1, 1, 1 } })

    self.raidTable:Show()
end

function SavedClassic:InitUsageTable()
    local uc = LibTable:CreateTable(self.name.."UsageCharacterTable", UIParent, nil,
        { SetMovable = true, SetPoint = "TOPLEFT", SetClampedToScreen = true, ESCClosable = true, PlaceCloseButton = true }
    )
    local ui = LibTable:CreateTable(self.name.."UsageInstanceTable", uc, nil,
        { SetPoint = { "TOPLEFT", uc, "BOTTOMLEFT" }, SetClampedToScreen = true }
    )
    ui:SetCallback({
        OnMouseDown = function() uc:StartMoving() end,
        OnMouseUp   = function() uc:StopMovingOrSizing() end,
        OnShow      = function()
                        if not self.usage_character.loaded then
                            self:BuildUsageTable()
                            self.usage_character.loaded = true
                        end
                    end
    })
    self.usage_character = uc
    self.usage_instance = ui
    self:BuildUsageTable()
end

function SavedClassic:BuildUsageTable()
    local uc = self.usage_character
    local uctbl = L["Usage_Character"]
    local ucdtbl = { }
    local function CreateHyperlinkAndColor(_, cell)
        local text = cell:GetText() or ""
        text = text:gsub("|c[Ff][Ff]......", ""):gsub("|r", "") -- strip color
        local _, _, keyword = text:find("^(%[[^]]+%])")
        if cell.data or keyword then
            local link = format("|Haddon:%s:|h%s|h", addonName, cell.data or keyword)
            cell:SetTextColor(0.8, 0.67, 0)  -- #ccaa00 - gold color
            cell:SetText(link)
            cell.data = nil
        end
    end
    uc:Resize({ rows = #uctbl, cols = 4, widths = 100 })
    uc:SetRangeOption(true, true, { SetTextColor={ 0.9, 0.9, 0.9 } })
    --
    for i, _ in ipairs(uctbl) do
        ucdtbl[i] = { }
    end

    -- Here goes Currencies
    -- Gold, Silver, Copper at 1st line
    table.insert(uctbl, {
        format("%s %s", self.currencies[1].icon, self.currencies[1].altName),
        format("%s %s", self.currencies[2].icon, self.currencies[2].altName),
        format("%s %s", self.currencies[3].icon, self.currencies[3].altName),
    })
    table.insert(ucdtbl, {
        format("[%s:%s]", L["currency"], self.currencies[1].altName),
        format("[%s:%s]", L["currency"], self.currencies[2].altName),
        format("[%s:%s]", L["currency"], self.currencies[3].altName),
    })
    -- Next, 4 currencies at one line
    table.insert(uctbl, {})
    table.insert(ucdtbl, {})
    for _, id in pairs(self.currencies.order) do
        if id > 3 then
            local currency = self.currencies[id]
            if currency then
                if #uctbl[#uctbl] >= 4 then
                    table.insert(uctbl, {})
                    table.insert(ucdtbl, {})
                end
                table.insert(uctbl[#uctbl], format("%s %s", currency.icon, currency.altName))
                table.insert(ucdtbl[#ucdtbl], format("[%s:%s]", L["currency"], currency.altName))
            end
        end
    end

    uc:SetTable(uctbl)
    uc:SetTableData(ucdtbl)
    uc:RangeFunction(true, true, CreateHyperlinkAndColor)

    local ui = self.usage_instance
    local uitbl = L["Usage_Instance"]
    ui:Resize({ rows = #uitbl, cols = 4, widths = 100 })
    ui:SetRangeOption(true, true, { SetTextColor={ 0.9, 0.9, 0.9 } })
    ui:SetTable(uitbl)
    ui:RangeFunction(true, true, CreateHyperlinkAndColor)
end

function SavedClassic:BuildCurrencyInfo()
    for _, id in pairs(self.currencies.order) do
        local currency = self.currencies[id]
        if currency then
            if not currency.icon then
                local info = SavedClassic_GetCurrencyInfo(id)
                if info then
                    currency.name = info.name
                    currency.icon = "|T"..info.iconFileID..":14:14|t"
                end
            end
        end
    end
end

function SavedClassic:BuildOptions()
    SavedClassic.optionsTable = {
        name = self.name,
        handler = self,
        type = "group",
        childGroups = "tab",
        get = function(info) return self.db.profile[info[#info]] end,
        set = function(info, value) self.db.profile[info[#info]] = value end,
        args = {
            display = {
                name = L["DISPLAY"],
                type = "group",
                order = 10,
                args = {
                    TOOLTIP_SCALE = {
                        name = L["TOOLTIP_SCALE"],
                        type = "range",
                        min = 60,
                        max = 150,
                        step = 5,
                        order = 51,
                    },
                    blank11 = { name = "", type = "description", order = 52, },
                    FLOAT_UI = {
                        name = L["FLOAT_UI"],
                        type = "toggle",
                        order = 101,
                        set = function(info, value)
                            self.db.profile[info[#info]] = value
                            if value then self.ui:Show() else self.ui:Hide() end
                        end,
                    },
                    FLOAT_UI_W = {
                        name = L["FLOAT_UI_W"],
                        type = "range",
                        min = 80,
                        max = 200,
                        step = 1,
                        order = 102,
                        set = function(info, value)
                            self.db.profile[info[#info]] = value
                            self.ui:SetWidth(value)
                        end
                    },
                    FLOAT_UI_H = {
                        name = L["FLOAT_UI_H"],
                        type = "range",
                        min = 20,
                        max = 50,
                        step = 1,
                        order = 103,
                        set = function(info, value)
                            self.db.profile[info[#info]] = value
                            self.ui:SetHeight(value)
                        end
                    },
                    frameDesc = {
                        name = L["FLOAT_UI_DESCRIPTION"],
                        type = "description",
                        order = 104
                    },
                    MINIMAP_ICON = {
                        name = L["MINIMAP_ICON"],
                        type = "toggle",
                        order = 111,
                        get = function(_)
                            return not self.db.profile.MINIMAP_ICON.hide
                        end,
                        set = function(info, value)
                            self.db.profile[info[#info]].hide = not value
                            if value then self.icon:Show(self.name) else self.icon:Hide(self.name) end
                        end,
                    },
                    DISPLAY_SCOPE = {
                        name = L["DISPLAY_SCOPE"],
                        type = "select",
                        values = {
                            char = L["Character"],
                            realm = L["Realm"],
                            account = L["Account"],
                        },
                        style = "radio",
                        order = 121
                    },
                    TOTAL_GOLD = {
                        name = L["TOTAL_GOLD"],
                        type = "toggle",
                        order = 122,
                    },
                    HIDE_LEVEL = {
                        name = L["HIDE_LEVEL"],
                        type = "range",
                        min = 1,
                        max = GetMaxPlayerLevel(),
                        step = 1,
                        order = 131
                    },
                    CURRENT_1ST = {
                        name = L["CURRENT_1ST"],
                        type = "toggle",
                        set = function(info, value)
                            self.db.profile[info[#info]] = value
                            self:SetOrder()
                        end,
                        order = 141
                    },
                    SORT_BY = {
                        name = L["SORT_BY"],
                        type = "select",
                        values = {
                            name    = L["name"],
                            level   = L["level"],
                            gold    = L["gold"],
                            gearEquippedLevel = L["ilvl_equip"],
                            gearAvgLevel = L["ilvl_avg"],
                            zone    = L["zone"],
                            elapsed = L["elapsed"],
                        },
                        set = function(info, value)
                            self.db.profile[info[#info]] = value
                            self:SetOrder()
                        end,
                        order = 151,
                    },
                    SORT_ORDER = {
                        name = L["SORT_ORDER"],
                        type = "select",
                        values = {
                            [0] = L["Descending"],
                            [1] = L["Ascending"],
                        },
                        style = "radio",
                        order = 152,
                    },
                    EXCLUDE = {
                        name = L["EXCLUDE"];
                        type = "input",
                        width = "full",
                        order = 161,
                        set = function(info, value)
                                self.db.profile[info[#info]] = value
                                self:SetOrder()
                            end,
                    },
                },
            },
            tooltip = {
                name = L["TOOLTIP"],
                type = "group",
                order = 20,
                args = {
                    infoChar = {
                        name = L["TOOLTIP_CHARACTER"],
                        type = "group",
                        inline = true,
                        order = 31,
                        args = {
                            INFO1 = {
                                name = L["INFO1"],
                                type = "toggle",
                                width = "full",
                                order = 11
                            },
                            INFO1_L = {
                                name = L["Left"],
                                type = "input",
                                width = 2,
                                multiline = 2,
                                desc = function() self.usage_character:Show() end,
                                order = 12
                            },
                            INFO1_R = {
                                name = L["Right"],
                                type = "input",
                                width = 1,
                                multiline = 2,
                                desc = function() self.usage_character:Show() end,
                                order = 13
                            },
                            INFO2 = {
                                name = L["INFO2"],
                                type = "toggle",
                                width = "full",
                                order = 21
                            },
                            INFO2_L = {
                                name = L["Left"],
                                type = "input",
                                width = 2,
                                multiline = 2,
                                desc = function() self.usage_character:Show() end,
                                order = 22
                            },
                            INFO2_R = {
                                name = L["Right"],
                                type = "input",
                                width = 1,
                                multiline = 2,
                                desc = function() self.usage_character:Show() end,
                                order = 23
                            },
                        },
                    },
                    infoRaid = {
                        name = L["TOOLTIP_RAID"],
                        type = "group",
                        inline = true,
                        order = 41,
                        args = {
                            INFO3 = {
                                name = L["INFO3"],
                                type = "toggle",
                                order = 1
                            },
                            INFO3_SHORT = {
                                name = L["INFO_SHORT"],
                                type = "toggle",
                                order = 2,
                            },
                            blank31 = { name = "", type = "description", order = 10, },
                            INFO3_L = {
                                name = L["Left"],
                                type = "input",
                                width = 2,
                                multiline = 2,
                                desc = function() self.usage_character:Show() end,
                                order = 21
                            },
                            INFO3_R = {
                                name = L["Right"],
                                type = "input",
                                width = 1,
                                multiline = 2,
                                desc = function() self.usage_character:Show() end,
                                order = 22
                            },
                        },
                    },
                    infoHeroic = {
                        name = L["TOOLTIP_HEROIC"],
                        type = "group",
                        inline = true,
                        order = 51,
                        args = {
                            INFO4 = {
                                name = L["INFO4"],
                                type = "toggle",
                                order = 1,
                            },
                            INFO4_SHORT = {
                                name = L["INFO_SHORT"],
                                type = "toggle",
                                order = 2,
                            },
                            blank41 = { name = "", type = "description", order = 10, },
                            INFO4_L = {
                                name = L["Left"],
                                type = "input",
                                width = 2,
                                multiline = 2,
                                desc = function() self.usage_character:Show() end,
                                order = 21
                            },
                            INFO4_R = {
                                name = L["Right"],
                                type = "input",
                                width = 1,
                                multiline = 2,
                                desc = function() self.usage_character:Show() end,
                                order = 22
                            },
                        },
                    },
                },
            },
            profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
        },
    }
end