-- Korean localization By gygabyte

if( GetLocale() == "koKR" ) then

SHEEPWATCH_SPELL = "변이"
SHEEPWATCH_SPELL2 = "변이: 돼지"

SHEEPWATCH_TEXT_LOADED = "SheepWatch " .. SHEEPWATCH_VERSION .. " loaded - 설정명령어 : /sheepwatch"
SHEEPWATCH_TEXT_WORLD_NOT_LOADED = "로딩중입니다. 잠시만 기다려주세요..."
SHEEPWATCH_TEXT_PROFILECLEARED = "SheepWatch: 이 버전에 현재 설정이 호환성이 없어서 프로화일을 삭제합니다.\nSheepWatch: /sheepwatch 명령어로 다시 설정해 주세요."
SHEEPWATCH_TEXT_LOCKED = "SheepWatch: 창 고정."
SHEEPWATCH_TEXT_UNLOCKED = "SheepWatch: 창 해제."
SHEEPWATCH_TEXT_RANK  = "의 변이 주문 저장."
SHEEPWATCH_TEXT_NORANK  = "SheepWatch: 오류: " .. SHEEPWATCH_SPELL .. " 주문을 찾을 수 없습니다!\nSheepWatch: 이번 세션에는 비활성화 됩니다."
SHEEPWATCH_TEXT_ANNOUNCE_NOTARGET = "SheepWatch: 잘못된 알림 대상.\nSheepWatch: \'/sheepwatch target <value>\'로 설정하세요.\nSheepWatch: 설정 가능 대상 : say party guild raid auto"
SHEEPWATCH_TEXT_ANNOUNCE = "($l레벨) $t에게 $s를 시전합니다."
SHEEPWATCH_TEXT_ANNOUNCE_CAST = " 시전 : 대상 - " -- FIXME
SHEEPWATCH_TEXT_ANNOUNCE_BREAK = SHEEPWATCH_SPELL .. " 중단 : 대상 - "
SHEEPWATCH_TEXT_ANNOUNCE_FADE = SHEEPWATCH_SPELL .. " 사라짐 : 대상 - "
SHEEPWATCH_TEXT_ANNOUNCE_LEAVECOMBAT = "SheepWatch: 비전투상태. 초기화.."
SHEEPWATCH_TEXT_ANNOUNCE_TARGETSUCCESS = "SheepWatch: 재타겟팅 성공."
SHEEPWATCH_TEXT_ANNOUNCE_TARGETFAILED = "SheepWatch: 재타겟팅 실패."
SHEEPWATCH_TEXT_ANNOUNCE_ABORTCAST = "SheepWatch: 시전 실패."
SHEEPWATCH_TEXT_RESETPOS = "SheepWatch: 바 위치 초기화"
SHEEPWATCH_TOOLTIP_TRANSPARENCY = "바 투명도를 변경할려면 슬라이더를\n드래그 하세요!" 
SHEEPWATCH_TOOLTIP_SCALING = "바의 크기를 변경할려면 슬라이더를\n드래그 하세요!"
SHEEPWATCH_LABEL_ENABLE = "SheepWatch 활성화"
SHEEPWATCH_LABEL_ANNOUNCE = "변이 알림"
SHEEPWATCH_LABEL_VERBOSE = "상세 보고"
SHEEPWATCH_LABEL_CLOSE = "닫기"
SHEEPWATCH_LABEL_MOVE = "바 이동"
SHEEPWATCH_LABEL_MOVE2 = "바 잠금"
SHEEPWATCH_LABEL_ANNOUNCE_TARGET_LABEL = "알림 형태:"
SHEEPWATCH_LABEL_ANNOUNCE_TIME_LABEL = "알림 메시지:"
SHEEPWATCH_LABEL_COUNTER = "변이 시간 표시"
SHEEPWATCH_LABEL_COUNTER_DIGITS = "초단위 표시"
SHEEPWATCH_LABEL_DIRECTION_LABEL = "바 방향:"
SHEEPWATCH_LABEL_COLOR_LABEL = "바 색상:"
SHEEPWATCH_LABEL_TRANSPARENCY = "바 투명도"
SHEEPWATCH_LABEL_SCALING = "바 크기조절"
SHEEPWATCH_LIST_DIRECTIONS = { 
					{ name = "증가형", value = 1 },
					{ name = "감소형", value = 2 }
}
SHEEPWATCH_LIST_ANNOUNCETIME = {
					{ name = "시전하기 전에", value = 1 },
					{ name = "시전한 후에", value = 2 }
}
-- DON'T LOCALIZE THIS
SHEEPWATCH_LIST_ANNOUNCETARGETS = {
					{ name = "SAY", value = 1 },
					{ name = "YELL", value = 2 },
					{ name = "PARTY", value = 3 },
					{ name = "RAID", value = 4 },
					{ name = "GUILD", value = 5 },
					{ name = "AUTO", value = 6 }
}


SHEEPWATCH_HELP1  = " - 설정 명령어 : '/sheepwatch'"

SHEEPWATCH_EVENT_ON = "(.+)|1이;가; (.+)에 걸렸습니다."
SHEEPWATCH_EVENT_CAST = "(.+)에게 (.+)|1을;를; 시전합니다."
SHEEPWATCH_EVENT_BREAK = "(.+)에서 (.+) 효과가 사라집니다."
SHEEPWATCH_EVENT_FADE = "(.+)의 몸에서 (.+) 효과가 사라졌습니다."
SHEEPWATCH_EVENT_DEATH = "(.+)|1이;가; 죽었습니다."

end