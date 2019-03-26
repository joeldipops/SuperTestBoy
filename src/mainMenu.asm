    IF !DEF(MAIN_MENU_INCLUDED)
MAIN_MENU_INCLUDED SET 1

MENU_ITEMS_COUNT EQU 3


;;;
; Handle interactions with the main menu
; @param B The joypad state 
;;;
mainMenuStep:
    if0 [stateInitialised]
        call Z, initMainMenu

    ; if no relevant buttons pressed.
    andAny B, START | A_BTN | DOWN | UP
        ret Z

    andAny B, START | A_BTN
    jr Z, .notA
        call mainMenuItemSelected
        ret    

.notA
    ld16 HL, [cursorPosition]
    adjustCursor .moveCursor, MENU_ITEMS_COUNT - 1, UP, DOWN

.moveCursor
    ; Move the cursor
    loadIndexAddress spriteYOffsets, [HL]
    ldAny [PcY], [HL]
    ret

;;;
; Sets up the screen for the main menu page
;;;
initMainMenu:
    ; Set up cursor
    ldAny [inputThrottleAmount], INPUT_THROTTLE
    ldAny [PcX], MENU_MARGIN_LEFT
    ldAny [PcImage], CURSOR
    ldAny [PcSpriteFlags], HAS_PRIORITY | USE_PALETTE_0

    ld16 HL, [cursorPosition]
    loadIndexAddress spriteYOffsets, [HL]
    ldAny [PcY], [HL]

    ldAny [stateInitialised], 1

    ; Set up menu items
    ld HL, SGBLabel
    ld D, 3
    ld E, 0
    call printString

    ld HL, JoypadLabel
    ld D, 3
    ld E, 1
    call printString

    ld HL, AudioLabel
    ld D, 3
    ld E, 2
    call printString
    ret

;;;
; When a menu item is selected, jumps to the next screen.
;;;
mainMenuItemSelected:
    push HL

    ld16 HL, [cursorPosition]
    cpAny 1, [HL]
        jr NZ, .notJoypad
        ldAny [state], JOYPAD_TEST_STATE
        jr .return

.notJoypad
    orAny 0, [HL]
        jr NZ, .notSGB
        ldAny [state], SGB_TEST_STATE
        jr .return

.notSGB
    cpAny 2, [HL]
        jr NZ, .notAudio
        ldAny [state], AUDIO_TEST_STATE
        jr .return  

.notAudio
    throw

.return
    ; We're changing menu levels, so inc the cursor pointer.
    incAny [cursorPosition + 1]
    ldAny [stateInitialised], 0

    pop HL
    ret

    ENDC