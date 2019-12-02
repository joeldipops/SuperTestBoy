    IF(!DEF(JOYPAD_TEST_INCLUDED))
JOYPAD_TEST_INCLUDED SET 1

A_SPRITE EQU 1
B_SPRITE EQU 2
START_SPRITE EQU 3
SELECT_SPRITE EQU 4
UP_SPRITE EQU 5
DOWN_SPRITE EQU 6
LEFT_SPRITE EQU 7
RIGHT_SPRITE EQU 8

;;;
; Sets up sprites for each buttons.
;;;
initJoypadTest:
    push HL
    call resetBackground
    ldAny [PcX], 0
    ldAny [PcY], 0

    ldAny [SpritePalette1], %01001110    

    updateSprite \
        A_SPRITE, \
        MARGIN_LEFT, MENU_MARGIN_TOP, \
        "A", HAS_PRIORITY | USE_PALETTE_1, 0
    
    updateSprite \
        B_SPRITE, \
        MARGIN_LEFT * 2, MENU_MARGIN_TOP, \
        "B", HAS_PRIORITY | USE_PALETTE_1, 0

    updateSprite \
        START_SPRITE, \
        MARGIN_LEFT * 3, MENU_MARGIN_TOP, \
        "S", HAS_PRIORITY | USE_PALETTE_1, 0

    updateSprite \
        SELECT_SPRITE, \
        MARGIN_LEFT * 4, MENU_MARGIN_TOP, \
        "s", HAS_PRIORITY | USE_PALETTE_1, 0

    updateSprite \
        UP_SPRITE, \
        MARGIN_LEFT * 5, MENU_MARGIN_TOP, \
        "U", HAS_PRIORITY | USE_PALETTE_1, 0

    updateSprite \
        DOWN_SPRITE, \
        MARGIN_LEFT * 6, MENU_MARGIN_TOP, \
        "D", HAS_PRIORITY | USE_PALETTE_1, 0

    updateSprite \
        LEFT_SPRITE, \
        MARGIN_LEFT * 7, MENU_MARGIN_TOP, \
        "L", HAS_PRIORITY | USE_PALETTE_1, 0

    updateSprite \
        RIGHT_SPRITE, \
        MARGIN_LEFT * 8, MENU_MARGIN_TOP, \
        "R", HAS_PRIORITY | USE_PALETTE_1, 0                                        

    ; Message at the bottom of the screen.
    ld HL, JoypadTestInstructions
    ld D, 0
    ld E, BACKGROUND_HEIGHT - 1
    call printString 

    ; Turn off input throttle so holding down the button counts.
    ldAny [inputThrottleAmount], 0
    ldAny [stateInitialised], 1

    pop HL
    ret

;;;
; Puts us back to how we were before we entered this screen.
;;;
backFromJoypadTest:
    ldAny [SpritePalette1], FG_PALETTE

    ; hide all the sprites off screen.
    xor A
    setSpriteY A_SPRITE, A
    setSpriteY B_SPRITE, A
    setSpriteY START_SPRITE, A
    setSpriteY SELECT_SPRITE, A
    setSpriteY UP_SPRITE, A
    setSpriteY DOWN_SPRITE, A
    setSpriteY LEFT_SPRITE, A
    setSpriteY RIGHT_SPRITE, A

    ; Wait a bit before allowing the next input so we don't keep jumping back in to joypad test after holding down A & START 
    ldAny [inputThrottleCount], 32

    ldAny [state], MAIN_MENU_STATE
    backToPrevMenu
    ret

;;;
; Lights up the indicator if the button is pressed, turns it off if it is not.
; @param \1 The button
; @param \2 Sprite for the button.
; @reg B pressed buttons.
;;; 
setButtonIndicator: macro
    andAny B, \1
    jr NZ, .else\@
        setSpriteFlags \2, HAS_PRIORITY | USE_PALETTE_1    
        jr .end\@
.else\@
        setSpriteFlags \2, HAS_PRIORITY | USE_PALETTE_0    
.end\@
endm

;;;
; Screen that reacts to each button press.
; @param B pressed buttons.
;;;
joypadTestStep:
    ; Init if haven't already
    if0 [stateInitialised]
        call Z, initJoypadTest
    
    ; Go back if A, B, START, SELECT all held down.
    cpAny B, A_BTN | B_BTN | START | SELECT 
        call Z, backFromJoypadTest

    setButtonIndicator A_BTN, A_SPRITE
    setButtonIndicator B_BTN, B_SPRITE
    setButtonIndicator START, START_SPRITE 
    setButtonIndicator SELECT, SELECT_SPRITE
    setButtonIndicator UP, UP_SPRITE
    setButtonIndicator DOWN, DOWN_SPRITE
    setButtonIndicator LEFT, LEFT_SPRITE
    setButtonIndicator RIGHT, RIGHT_SPRITE

    ret
    
    ENDC
