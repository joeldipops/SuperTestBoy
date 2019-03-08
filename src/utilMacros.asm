    IF (!DEF(MACROS_INCLUDED))
MACROS_INCLUDED SET 1

;;;
; Defines arrays spriteXOffsets, spriteYOffsets to save cycles
; when moving sprites to a certain row or column.
;;;
defineSpriteOffsetArray: macro
    IF (!DEF(SPRITE_ARRAY_DEFINED))
SPRITE_ARRAY_DEFINED SET 1

spriteXOffsets:
    db 0
    db SPRITE_WIDTH
spriteYOffsets:
I SET 2
        REPT 25
            db I * SPRITE_WIDTH
I SET I + 1
        ENDR
    ENDC
endm



;;; 
; Places the cursor according to the value at [HL]
; @param \1 Top margin
; @reg [HL] Logical y-position of the cursor
;;;
moveCursor: macro
    ld A, [HL]
    mult SPRITE_WIDTH
    ld A, L
    add \1
    ld [PcY], A
endm

;;;
; Puts HL at address of index \2 of array \1
; @param \1 label of the array
; @param \2 array index
; @affects 
; * B = 0
; * C = \2
; * HL = address of \1[\2]
;;;
loadIndexAddress: macro
    ld B, 0
    ld C, \2
    ld HL, \1
    add HL, BC    
endm

;;;
; Push all registers on to the stack so we can interrupt safely.
;;;
pushAll: macro
    push AF
    push BC
    push DE
    push HL
endm

;;;
; Pushes a 16bit colour on to the stack.
; @param \1 red 5yte
; @param \2 green 5yte 
; @param \3 blue 5yte
;;;
pushColour: macro
    pushAny 1 << 15 | (\3 << 10 | \2 << 5 | \1)
endm

;;;
; Pop all registers when we're done with an interrupt.
;;;
popAll: macro
    pop HL
    pop DE
    pop BC
    pop AF
endm

;;; 
; Lets us put a break point on a nop
;;;
debugger: macro
    or A
    jr NZ .skip
    nop
.skip 
endm

;;;
; Jumps back to the previous menu level.
;;;
backToPrevMenu: macro
    call resetBackground
    call resetForeground
    
    ; Set position to 0 and dec depth.
    ld16 HL, [cursorPosition]
    xor A
    ld [HL], A
    decAny [cursorPosition + 1]

    ldAny [stateInitialised], 0 
endm

    ENDC