    IF !DEF(UTILS_INCLUDED)
UTILS_INCLUDED SET 1

INCLUDE "includes/ops.asm"
INCLUDE "includes/constants.asm"

;;;
; For sprite updates to work, we need to know where in memory they sit.
; Call this before using any sprite macros.
; @param \1 Memory address of sprite attributes before they are copied to V-RAM
;;;
setOAMStage: macro
OAMStage SET \1
endm

;;;
; Updates the flags of a given sprite.
; @param \1 Sprite number
; @param \2 The flag byte.
;;;
setSpriteFlags: macro
    ldAny [OAMStage + (\1 * SPRITE_SIZE) + 3], \2
endm

;;;
; Sets the sprite to a new Y location.
; @param \1 Sprite number
; @param \2 Y co-ordinate.
;;;
setSpriteY: macro
    ldAny [OAMStage + (\1 * SPRITE_SIZE)], \2
endm

;;;
; Sets all of a given sprite's attributes at once.
; @param \1 Sprite number
; @param \2 X position
; @param \3 Y position
; @param \4 Pointer to image tile
; @param \5 Flags
; @param \6 preserve HL - if 0, HL will be affected but will use fewer cycles/bytes, if 1, HL will be unchanged.
;;;
updateSprite: macro
    IF (\6 == 1)
        ldAny [OAMStage + (\1 * SPRITE_SIZE)], \3
        ldAny [OAMStage + (\1 * SPRITE_SIZE) + 1], \2
        ldAny [OAMStage + (\1 * SPRITE_SIZE) + 1], \4        
        ldAny [OAMStage + (\1 * SPRITE_SIZE) + 1], \5        
    ELSE
        ld HL, OAMStage + (\1 * SPRITE_SIZE)
        ldiAny [HL], \3
        ldiAny [HL], \2
        ldiAny [HL], \4
        ldiAny [HL], \5
    ENDC
endm

;;;
; ors a register/value with itself to see if it's zero
; @param \1 The value.
;;; 
if0: macro
    ld A, \1
    or A, A
endm

;;;
; Pad out a number of bytes.
; @param \1 number of bytes required.
; @param \2 0 to pad with $00 (nop), 1 to pad with $ff (rst $38)
;;;
pad: macro
    IF \2 == 0
        REPT \1
            nop
        ENDR
    ELIF \2 == 1
        REPT \1
            rst $38
        ENDR
    ENDC
endm   


;;; 
; jpx cc, [r16]
;
; this op is stupid, never use it just thought it would be fun
; jpx NN, [onSubtract]
;;;
jpx: macro
NF EQU %01000000
HF EQU %00100000

    IF "\1" == "NH" OR "\1" == "H"
        push AF
        pop BC
        ld A, C
        and HF
        IF "\1" == "H"
            jp NZ, \2
        ELSE
            jp Z, \2
        ENDC
    ELIF "\1" == "NN" OR "\1" == "N"
        push AF
        pop BC
        ld A, C
        and NF
        IF "\1" == "N"
            jp NZ, \2
        ELSE
            jp Z, \2
        ENDC        
    ELSE   
        jp \1, \2
    ENDC

endm

    ENDC