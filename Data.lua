local addonName, _ = ...
-- Global object
SavedClassic = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")
SavedClassic.name = addonName
--SavedClassic.version = GetAddOnMetadata(addonName, "Version")
SavedClassic.version = "1.15.6.1"

local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

SavedClassic.wb = {	-- World buffs and Flasks
	[23768] = { },	-- DF damage 세이지 공격력
	[23766] = { },	-- DF int 세이지 지능
	[22817] = { },	-- DM1 펜구스의 흉포
	[22818] = { },	-- DM2 몰다르의 투지
	[22820] = { },	-- DM3 슬립킥의 손재주
	[15366] = { },	-- SF 노래꽃의 세레나데
	[22888] = { }, [355363] = { },	-- Ony, Nef 용사냥꾼 재집결의 외침
	[24425] = { }, [355365] = { },	-- Zul'gurub 잔달라의 기백
	[16609] = { }, [355366] = { },	-- BoW 대족장의 축복
	[24382] = { }, 	-- Zanza 잔자의 기백
	[17626] = { },	-- Titan 티탄
	[17627] = { },	-- Distilled Wisdom 순지
	[17628] = { },	-- Supreme Power 강마
}
SavedClassic.cd = {	-- for Chronoboon Displacer
	22817, 22818, 22820, 22888, 16609, 24425, 15366, 23768, 23766
}
SavedClassic.ts = {	-- Tradeskills of long cooldowns
	[17187] = { icon = "|TInterface/Icons/INT_MISC_STONETABLET_05:14:14|t"  },  -- Transmute(Arcanite) - 24H
	[18560] = { icon = "|TInterface/Icons/INV_FABRIC_MOONRAG:14:14|t"       },  -- Mooncloth - 96H
	[19566] = { icon = "|TInterface/Icons/INV_EGG_05:14:14|t"               },  -- Salt Shaker - 72H
}
SavedClassic.items = {	-- Items to count always
	[6265] = { },	-- Soulshard
	[184937] = { },	-- Chronoboon Displacer
}

SavedClassic.currencies = {
    [1]   = { altName = L["gold"    ], icon = "|TInterface/MoneyFrame/UI-GoldIcon:14:14:2:0|t"},   -- Gold
    [2]   = { altName = L["silver"  ], icon = "|TInterface/MoneyFrame/UI-SilverIcon:14:14:2:0|t" },   -- Silver
    [3]   = { altName = L["copper"  ], icon = "|TInterface/MoneyFrame/UI-CopperIcon:14:14:2:0|t" },   -- Copper
    [1901]= { altName = L["honor"   ] }, -- Honor point
    order = {
        1,2,3,          -- Gold, Silver, Copper
    }
}
setmetatable(SavedClassic.currencies, { __index = 
        function(t,k)
            for id, v in pairs(t) do
                if v.altName and v.altName == k then
                    v.id = id   -- Will be used in _TranslationTable
                    return v
                end
            end
            return nil
        end }
)

SavedClassic.abbr = {}
SavedClassic.abbr.heroic = {
}

SavedClassic.abbr.raid = {
    -- Vanilla Raid                                                                   
    [C_Map.GetAreaInfo(3456)] = { order = -106, name = L["R1_Naxxramas"],               color = "FFA8DAF9" },
    [C_Map.GetAreaInfo(3428)] = { order = -105, name = L["R1_Temple of Ahn'Qiraj"],     color = "FF65350F" },
    [C_Map.GetAreaInfo(3429)] = { order = -104, name = L["R1_Ruins of Ahn'Qiraj"],      color = "FF80471C" },
    [C_Map.GetAreaInfo(2677)] = { order = -103, name = L["R1_Blackwing Lair"],          color = "FF795C34" },
    [C_Map.GetAreaInfo(2159)] = { order = -102, name = L["R1_Onyxia's Lair"],           color = "FF187BCD" },
    [C_Map.GetAreaInfo(2717)] = { order = -101, name = L["R1_Molten Core"],             color = "FF9A7B4F" },
}
