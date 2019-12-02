;;;
; Fills the screen with the "GRID" tile 
;;;
initPixelTest:
    push HL

    ld A, 0
    ld D, 0
    ld E, 0
    ld L, GRID
    ld BC, SCREEN_BYTE_WIDTH * SCREEN_BYTE_HEIGHT
    call setVRAM

    ldAny [stateInitialised], 1

    pop HL
    ret

;;;
; Returns to main menu.
;;;
backFromPixelTest:
    ldAny [state], MAIN_MENU_STATE
    backToPrevMenu
    ret

;;;
; Covers the screen in a grid texture so we can see what rows or columns are not being rendered correctly.
;;;
pixelTestStep:
    if0 [stateInitialised]
        call Z, initPixelTest

    cpAny B, B_BTN
        call Z, backFromPixelTest

    ret