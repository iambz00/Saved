local addonName, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "koKR")

if L then
L["Transmute"] = "변환"

L["Reset due to update"] = function(oldv, newv) return "업데이트로 인해 일부 또는 모든 정보를 리셋합니다. ("..oldv.." -> "..newv.. ")" end
L["extended"] = "(연장)"

L["minites"] = "분"
L["Enabled"] = "활성화"
L["Disabled"] = "비활성화"

L["Raid Table Notice"] = "좌클릭: 레이드 귀속 창 열기, 우클릭: 설정창 열기"
L["Display settings"] = "표시 설정"
L["Desc - Common"] = "|cff00ff00■|r |cffccaa00Saved의 모든 옵션은 캐릭터별로 저장됩니다.|r"
L["Show floating UI frame"] = "별도프레임 표시"
L["Floating UI width"] = "프레임 너비"
L["Floating UI height"] = "프레임 높이"
L["Desc - Frame"] = "|cff00ff00■|r |cffccaa00Shift키를 누르고 드래그하여 프레임 이동 가능|r"
L["Show minimap icon"] = "미니맵 아이콘 표시"
L["Show info"] = "정보표시"
L["per Character"] = "캐릭터별"
L["per Realm"] = "서버별"
L["Show total gold"] = "총 골드 표시"
L["Hide info from level under"] = "다음 레벨 미만 감추기"
L["Show current chracter first"] = "현재 캐릭터 가장 위에 표시"
L["Sort Order"] = "정렬 기준"
L["Sort Option"] = "정렬 순서"
L["Exclude Characters"] = "보지 않을 캐릭터(쉼표 또는 빈칸으로 구분)"
L["Descending"] = "내림차순"
L["Asscending"] = "오름차순"
L["Tooltip - Character info."] = "툴팁 설정 - 캐릭터별 정보" --"캐릭터별 정보"
L["Line 1 of char info."] = "캐릭터별 정보 첫번째 줄"
L["Line 2 of char info."] = "캐릭터별 정보 두번째 줄"
L["Left"] = "왼쪽"
L["Right"] = "오른쪽"
L["Tooltip - Raid instances"] = "툴팁 설정 - 공격대 귀속 정보"
L["Lines of raid instances"] = "공격대 귀속 정보 표시줄"
L["Tooltip - Heroic instances"] = "툴팁 설정 - 영던 귀속 정보"
L["Lines of heroic instances"] = "영던 귀속 정보 표시줄"
L["Show in one-line"] = "한 줄로 보기"

L["Select character"] = "캐릭터 선택"
L["Reset selected character"] = "초기화(선택된 캐릭터)"
L["Are you really want to reset?"] = "정말로 초기화합니까?"
L["Reset all characters"] = "초기화(전체 캐릭터)"
L["Copy settings to"] = "설정 복사하기"
L["Copy"] = "복사"
L["Confirm copy"] = "현재 설정을 대상 캐릭터에 적용합니다."

-- Localized Translation Table
L["color"     ] = "색"
L["item"      ] = "아이템"
L["currency"  ] = "화폐"
L["name"      ] = "이름"
L["name2"     ] = "이름2"
L["zone"      ] = "위치"
L["subzone"   ] = "상세위치"
L["cooldown"  ] = "전문기술"
L["elapsed"   ] = "경과시간"
L["level"     ] = "레벨"
L["expCur"    ] = "현재경험치"
L["expMax"    ] = "최대경험치"
L["exp%"      ] = "경험치%"
L["expRest"   ] = "휴경"
L["expRest%"  ] = "휴경%"
L["dqCom"     ] = "일퀘완료"
L["dqMax"     ] = "일퀘최대"
L["dqReset"   ] = "일퀘리셋"
L["ilvl"      ] = "템렙"
L["ilvl_avg"  ] = "평균템렙"
L["ilvl_equip"] = "착용템렙"
L["instName"  ] = "인스턴스명"
L["instID"    ] = "인스턴스ID"
L["difficulty"] = "난이도"
L["progress"  ] = "진행도"
L["bosses"    ] = "전체보스"
L["time"      ] = "리셋시간"
-- Localized Currency Name
L["gold"    ] = "골드"
L["silver"  ] = "실버"
L["copper"  ] = "코퍼"
L["honor"   ] = "명예"
L["arena"   ] = "투기장"
L["conquest"] = "정복"
L["jewel"   ] = "보세"
L["cook"    ] = "요리"
L["JP"      ] = "정점"
L["VP"      ] = "용점"
L["TBC"     ] = "톨바"
L["MOW"     ] = "징표"
L["CAM"     ] = true
L["CRB"     ] = true
L["DPT"     ] = "다크문"
L["MOD"     ] = "티끌"
L["EOC"     ] = "정수"
-- Usage
L["Usage_Character"] = {
    { "|cff00ff00■|r |cffccaa00캐릭터별 정보 키워드|r" },
    { "[이름]"          , "캐릭터명(직업색상)"  , "[이름2]"         , "캐릭터명(색상없음)"  },
    { "[레벨]"          , "[현재경험치]"        , "[최대경험치]"    , "[경험치%]"   },
    { "[휴경]"          , "[휴경%]"             , "[위치]"          , "[상세위치]"  },
    { "[경과시간]"      , "최종 접속 시간"      , "[전문기술]"      , "주요 전문기술 쿨다운"    },
    { "[아이템:이름]"   , "[아이템:ID]"         , "아이콘과 수량"   ,   },
    { "[일퀘완료]"      , "[일퀘최대]"          , "[일퀘리셋]"      ,   },
    { "[템렙]"          , "[평균템렙]"          , "[착용템렙]"      ,   },
    { "[색/|cffff0000##|r|cff00ff00##|r|cff0000ff##|r]"
                        , "색지정 시작(RGB)"    , "[색]"            , "색지정 끝"   },
    { " |cffff0000!|r 모든 키워드 끝에 /###### 를 붙여 색 지정 가능",   },
    { "[화폐:이름]"     , "[화폐:ID]"           , "아이콘과 수량"   ,   },
    { " |cffff0000!|r 용점/정복 표기 방식" ,  "", "[화폐:용맹-3]"   , "|T463447:14:14|t960(4460/9600)"   },
    { "[화폐:용맹-2]"   , "|T463447:14:14|t960(|cFFFF75755140|r)", "[화폐:용맹-1]"   , "|T463447:14:14|t960(-5140)"   },
}
L["Usage_Instance"] = {
    { "|cff00ff00■|r |cffccaa00인스턴스 정보 키워드|r", },
    { "[인스턴스명]"    , "인스턴스명"          , "[난이도]"        , "인원 및 난이도"  },
    { "[진행도]"        , "진행 상황(킬 수)"    , "[전체보스]"      , "전체 보스 수"    },
    { "[리셋시간]"      , "리셋까지 남은 시간"  , "[인스턴스ID]"    , "인스턴스 ID"     },
}
-- Heroic abbr. Cataclysm
L["H4_Blackrock Caverns"] = "검바"
L["H4_Throne of the Tides"] = "파도"
L["H4_Vortex Pinnacle"] = "누각"
L["H4_The Stonecore"] = "바심"
L["H4_Lost City of the Tol'vir"] = "톨비르"
L["H4_Halls of Origination"] = "시초"
L["H4_Grim Batol"] = "그림"
L["H4_End Time"] = "시끝"
L["H4_Well of Eternity"] = "영샘"
L["H4_Hour of Twilight"] = "황시"
L["H4_Deadmines"] = "폐광"
L["H4_Shadowfang Keep"] = "그송"
L["H4_Zul'Gurub"] = "줄구룹"
L["H4_Zul'Aman"] = "줄아만"
-- Raid abbr. Cataclysm
L["R4_Blackwing Descent"] = "검날"
L["R4_Bastion of Twilight"] = "황요"
L["R4_Throne of the Four Winds"] = "네바람"
L["R4_Firelands"] = "불땅"
L["R4_Dragon Soul"] = "용영"
L["R4_Baradin Hold"] = "바라딘"
-- Heroic abbr. WotLK
L["H3_Ahn'kahet: The Old Kingdom"] = "안카"
L["H3_Azjol-Nerub"] = "아졸"
L["H3_Drak'Tharon Keep"] = "드락"
L["H3_Gundrak"] = "군드"
L["H3_Halls of Lightning"] = "번전"
L["H3_Halls of Stone"] = "돌전"
L["H3_Culling of Stratholme"] = "솔름"
L["H3_The Nexus"] = "마탑"
L["H3_The Oculus"] = "마눈"
L["H3_Violet Hold"] = "보요"
L["H3_Utgarde Keep"] = "성채"
L["H3_Utgarde Pinnacle"] = "첨탑"
L["H3_Trial of the Champion"] = "용사"
L["H3_Halls of Reflection"] = "투영"
L["H3_Pit of Saron"] = "사론"
L["H3_Forge of Souls"] = "제련"
-- Raid abbr. WotLK
L["R3_Naxxramas"] = "낙스"
L["R3_Obsidian Sanctum"] = "흑요"
L["R3_Eye of Eternity"] = "영눈"
L["R3_Ulduar"] = "울두"
L["R3_Onyxia's Lair"] = "오닉"
L["R3_Trial of the Crusader"] = "십자군"
L["R3_Icecrown Citadel"] = "얼왕"
L["R3_Ruby Sanctum"] = "루비"
L["R3_Vault of Archavon"] = "아카본"
-- Raid abbr. TBC
L["R2_Sunwell Plateau"] = "태양샘"
L["R2_Black Temple"] = "검사"
L["R2_Battle for Mount Hyjal"] = "하이잘"
L["R2_Serpentshrine CavernC"] = "불뱀"
L["R2_The Eye"] = "폭요"
L["R2_Karazhan"] = "카라잔"
L["R2_Gruul's Lair"] = "그룰"
L["R2_Magtheridon's Lair"] = "마그"
-- Raid abbr. Vanilla
L["R1_Temple of Ahn'Qiraj"] = "사원"
L["R1_Ruins of Ahn'Qiraj"] = "폐허"
L["R1_Blackwing Lair"] = "검둥"
L["R1_Molten Core"] = "화심"
end
