local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(AddonName, "koKR")

if L then
L["Transmute"] = "변환"

L["Reset due to update"] = function(oldv, newv) return "업데이트로 인해 일부 또는 모든 정보를 리셋합니다. ("..oldv.." -> "..newv.. ")" end
L["extended"] = "(연장)"

L["minites"] = "분"
L["Enabled"] = "활성화"
L["Disabled"] = "비활성화"

L["Display settings"] = "표시 설정"
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

L["Tooltip - Character info."] = "툴팁 설정 - 캐릭터별 정보" --"캐릭터별 정보"
L["Line 1 of char info."] = "캐릭터별 정보 첫번째 줄"
L["Line 2 of char info."] = "캐릭터별 정보 두번째 줄"
L["Left"] = "왼쪽"
L["Right"] = "오른쪽"
L["Desc_Char"] = "|cff00ff00■|r |cffccaa00캐릭터별 정보 키워드|r|n"
    .."|cffccaa00[이름]|r 캐릭터명(직업색상)|n"
    .."|cffccaa00[이름2]|r 캐릭터명(색상없음)|n"
    .."|cffccaa00[레벨] [현재경험치] [최대경험치] [경험치%]|r|n"
    .."|cffccaa00[휴경] [휴경%] [위치] [상세위치]|r|n"
    .."|cffccaa00[경과시간]|r 최종 업데이트 후 경과 시간|n"
    .."|cffccaa00[아이템:|cffffeeaa이름 또는 ID|r]|r 아이템 아이콘과 수량|n"
    .."|cffccaa00[전문기술]|r 주요 전문기술 쿨다운|n"
    .."|cffccaa00[일퀘완료] [일퀘최대]|r|n"
    .."|cffccaa00[일퀘리셋]|r 일퀘 리셋까지 남은 시간|n"
    .."|cffccaa00[기코] [템렙]|r|n"
    .."|cffccaa00[색/######]|r 색 지정 시작(RGB코드)|n|cffccaa00[색]|r 색 지정 종료|n"
    .."  끝에 /######를 붙여 색 지정 가능|n"
    .."|cffffeeaa(예시) |r|cffccaa00[색/ffffff]흰색[색] =>|r |cffffffff흰색|r|n   |cffccaa00[아이템:6265|cffcc3333/cc66cc|r] => |r|cffcc66cc".."|T"..GetItemIcon(6265)..":14:14|t12|r|n"
    .."|cffccaa00[화폐:|cffffeeaa이름 또는 ID|r]|r 화폐 아이콘과 수량|n"
L["Tooltip - Raid instances"] = "툴팁 설정 - 공격대 귀속 정보"
L["Lines of raid instances"] = "공격대 귀속 정보 표시줄"
L["Desc_Inst"] = "|cff00ff00■|r |cffccaa00인스턴스 정보 키워드|r|n"
    .."|cffccaa00[인스턴스명]|r 인스턴스명|n"
    .."|cffccaa00[난이도]|r 인원 및 난이도|n"
    .."|cffccaa00[진행도]|r 진행 상황(보스 킬 수)|n"
    .."|cffccaa00[전체보스]|r 보스 수|n"
    .."|cffccaa00[리셋시간]|r 리셋까지 남은 시간|n"
    .."|cffccaa00[인스턴스ID]|r 인스턴스 ID|n"
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
L["gs"        ] = "기코"
L["ilvl"      ] = "템렙"
L["instName"  ] = "인스턴스명"
L["instID"    ] = "인스턴스ID"
L["difficulty"] = "난이도"
L["progress"  ] = "진행도"
L["bosses"    ] = "전체보스"
L["time"      ] = "리셋시간"
-- 화폐명
L["gold"    ] = "골드"
L["silver"  ] = "실버"
L["copper"  ] = "코퍼"
L["honor"   ] = "명예"
L["arena"   ] = "투기장"
L["jewel"   ] = "보세"
L["cook"    ] = "요리"
L["heroism" ] = "무용"
L["valor"   ] = "용맹"
L["conquest"] = "정복"
L["triumph" ] = "승전"
L["frost"   ] = "서리"
L["champion"] = "용사"
L["AV"      ] = "알방"
L["AB"      ] = "아라시"
L["EotS"    ] = "폭눈"
L["SotA"    ] = "고대"
L["WSG"     ] = "노래방"
L["WG"      ] = "겨손"
L["IoC"     ] = "정섬"
L["shard"   ] = "바위"
L["venture" ] = "투자"
L["justice" ] = "정의"
L["sidereal"] = "항성"
L["defilers"] = "모독"
L["TOK"] = "안카"
L[ "AN"] = "아졸"
L["DTK"] = "드락"
L["Gun"] = "군드"
L["HoL"] = "번전"
L["HoS"] = "돌전"
L["CoS"] = "솔름"
L["Nex"] = "마탑"
L["Ocu"] = "마눈"
L[ "VH"] = "보요"
L[ "UK"] = "성채"
L[ "UP"] = "첨탑"
L["ToCh"] = "용사"
L["HoR"] = "투영"
L["PoS"] = "사론"
L["FoS"] = "제련"
-- 레이드 던전 약자
L["Naxx"] = "낙스"
L["OS"]   = "흑요"
L["EoE"]  = "영눈"
L["ULD"]  = "울두"
L["Ony"]  = "오닉"
L["ToC"]  = "십자군"
L["ICC"]  = "얼왕"
L["RS"]   = "루비"
L["VoA"]  = "아카본"
-- Raid abbr. TBC
L["SP"] = "태양샘"
L["ZA"] = "줄아만"
L["BT"] = "검사"
L["MH"] = "하이잘"
L["SC"] = "불뱀"
L["TK"] = "폭요"
L["KZ"] = "카라잔"
L["GL"] = "그룰"
L["ML"] = "마그"
-- Raid abbr. Vanilla
L["AQ"] = "사원"
L["RA"] = "폐허"
L["ZG"] = "줄구룹"
L["BW"] = "검둥"
L["MC"] = "화심"
end
