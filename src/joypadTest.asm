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

    ldhAny [SpritePalette1], %01001110    

    ; The first parameter to ldHLi is ignored, but we can use it to keep track of where we're up to ldi wise.
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
    ld A, 0
    setSpriteY A_SPRITE, A, 1
    setSpriteY B_SPRITE, A, 1
    setSpriteY START_SPRITE, A, 1
    setSpriteY SELECT_SPRITE, A, 1
    setSpriteY UP_SPRITE, A, 1
    setSpriteY DOWN_SPRITE, A, 1
    setSpriteY LEFT_SPRITE, A, 1
    setSpriteY RIGHT_SPRITE, A, 1                        
                           
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
    ld A, [stateInitialised]
    or A
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
