setupRet: macro
    ; these rets will need some setup...
    ld A, LOW(\1)
    ld [$d000], A
    ld A, HIGH(\1)
    ld [$d001], A
    ld SP, $d000
endm    

SECTION "rst 00", ROM0[$0000]
    jp rst00
SECTION "rst 08", ROM0[$0008]
    jp rst08
SECTION "rst 10", ROM0[$0010]
    jp rst10
SECTION "rst 18", ROM0[$0018]
    jp rst18
SECTION "rst 20", ROM0[$0020]
    jp rst20
SECTION "rst 28", ROM0[$0028]
    jp rst28
SECTION "rst 30", ROM0[$0030]
    jp rst30
SECTION "rst 38", ROM0[$0038]
    jp rst38
SECTION "home", ROM0[$0100]
    nop
    jp $0150

SECTION "main", ROM0[$0150]
testEachOp:
    ; 0x00
    nop
    ld BC, $c000
    ld [BC], A
    inc BC
    inc B
    dec B
    ld B, $d0
    rlca
    ld [$d000], SP
    add HL, BC
    ld A, [BC]
    dec BC
    inc C
    dec C
    ld C, $10
    rrca

    ; 0x10
    ;stop
    ld DE, $a000
    ld [DE], A
    inc DE
    inc D
    dec D
    ld D, $a1
    rla
    jr @+2
    add HL, DE
    ld A, [DE]
    dec DE
    inc E
    dec E
    ld E, $1a
    rra

    ; 0x20
    jr NZ, @+2
    ld HL, $b000
    ldi [HL], A
    inc HL
    inc H
    dec H
    ld H, $af
    daa
    jr Z, @+2
    add HL, HL
    ldi A, [HL]
    dec HL
    inc L
    dec L
    ld L, $31
    cpl

    ; 0x30
    jr NC, @+2
    ld SP, $fffe
    ldd [HL], A
    inc SP
    inc [HL]
    dec [HL]
    ld [HL], $42
    scf
    jr C, @+2
    add HL, SP
    ldd A, [HL]
    dec SP
    inc A
    dec A
    ld A, $42
    ccf

    ; 0x40
    ld B, B
    ld B, C
    ld B, D
    ld B, E
    ld B, H
    ld B, L
    ld B, [HL]
    ld B, A
    ld C, B  
    ld C, C  
    ld C, D   
    ld C, E   
    ld C, H   
    ld C, L   
    ld C, [HL]   
    ld C, A   

    ; 0x50
    ld D, B
    ld D, C
    ld D, D
    ld D, E
    ld D, H
    ld D, L
    ld D, [HL]
    ld D, A
    ld E, B  
    ld E, C  
    ld E, D   
    ld E, E   
    ld E, H   
    ld E, L   
    ld E, [HL]   
    ld E, A   

    ; 0x60
    ld H, B
    ld H, C
    ld H, D
    ld H, E
    ld H, H
    ld H, L
    ld H, [HL]
    ld H, A
    ld L, B  
    ld L, C  
    ld L, D   
    ld L, E   
    ld L, H   
    ld L, L   
    ld L, [HL]   
    ld L, A   

    ; 0x70
    ld [HL], B
    ld [HL], C
    ld [HL], D
    ld [HL], E
    ld [HL], H
    ld [HL], L
    ;halt
    ld [HL], A
    ld A, B  
    ld A, C  
    ld A, D   
    ld A, E   
    ld A, H   
    ld A, L   
    ld A, [HL]   
    ld A, A    

    ; 0x80
    add A, B
    add A, C
    add A, D
    add A, E
    add A, H
    add A, L
    add A, [HL]
    add A, A
    sbc A, B
    sbc A, C
    sbc A, D 
    sbc A, E
    sbc A, H
    sbc A, L
    sbc A, [HL]
    sbc A, A

    ; 0x90
    sub A, B
    sub A, C
    sub A, D
    sub A, E
    sub A, H
    sub A, L
    sub A, [HL]
    sub A, A
    sbc A, B
    sbc A, C
    sbc A, D 
    sbc A, E
    sbc A, H
    sbc A, L
    sbc A, [HL]
    sbc A, A

    ; 0xA0
    and A, B
    and A, C
    and A, D
    and A, E
    and A, H
    and A, L
    and A, [HL]
    and A, A
    xor A, B
    xor A, C
    xor A, D 
    xor A, E
    xor A, H
    xor A, L
    xor A, [HL]
    xor A, A   

    ; 0xB0
    or A, B
    or A, C
    or A, D
    or A, E
    or A, H
    or A, L
    or A, [HL]
    or A, A
    cp A, B
    cp A, C
    cp A, D 
    cp A, E
    cp A, H
    cp A, L
    cp A, [HL]
    cp A, A


    ; 0xC0
    setupRet retNZ
    ret NZ
retNZ: pop BC
    jp NZ, jpNZ
jpNZ: jp jpn16
jpn16: call NZ, callNZ
callNZ: push BC
    add A, $22
    rst $00
rst00: setupRet retZ
    ret Z
retZ: setupRet _ret
    ret
_ret: jp Z, jpZ
jpZ: ; cbs go here, but not today...
    call Z, callZ
callZ: call _call
_call: adc A, $22
    rst $08

    ; 0xD0
rst08: setupRet retNC
    ret NC
retNC: pop DE
    jp NC, jpNC
jpNC: call NC, callNC
callNC: push DE
    sub A, $22
    rst $10
rst10:
    setupRet retC
retC: setupRet _reti
    reti
_reti: jp C, jpC
jpC:    call C, callC
callC: sbc A, $22
    rst $18

    ; 0xE0
rst18: ldh [$ff00], A
    pop HL
    ld [C], A
    push HL
    and A, $22
    rst $20
rst20:
    add SP, 1
    ld HL, jpHL
    jp HL
jpHL: ld [$c234], A
    xor A, $22
    rst $28

    ; 0xF0
rst28: ldh A, [$ff00]
    pop AF
    ld A, [C]
    di
    push AF
    or A, $22
    rst $30
rst30: ld HL, SP+$22
    ld SP, HL
    ld A, [$4321]
    ei
    cp A, $22
    rst $38
rst38: nop