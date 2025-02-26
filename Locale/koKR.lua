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
L["worldbuff" ] = "월드버프"
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
}
L["Usage_Instance"] = {
    { "|cff00ff00■|r |cffccaa00인스턴스 정보 키워드|r", },
    { "[인스턴스명]"    , "인스턴스명"          , "[난이도]"        , "인원 및 난이도"  },
    { "[진행도]"        , "진행 상황(킬 수)"    , "[전체보스]"      , "전체 보스 수"    },
    { "[리셋시간]"      , "리셋까지 남은 시간"  , "[인스턴스ID]"    , "인스턴스 ID"     },
}
-- Raid abbr. Vanilla
L["R1_Naxxramas"] = "낙스"
L["R1_Onyxia's Lair"]  = "오닉"
L["R1_Temple of Ahn'Qiraj"] = "사원"
L["R1_Ruins of Ahn'Qiraj"] = "폐허"
L["R1_Blackwing Lair"] = "검둥"
L["R1_Molten Core"] = "화심"
end
