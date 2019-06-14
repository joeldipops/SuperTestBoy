SECTION "HEADER", ROM0[$100]
    nop
    jp main

SECTION "TEST", ROM0[$150]
main:
;;;;;;;;;;;;;;;; RLC
    ld A, %01011010
    rlc A
;Z=0 N=0 H=0 C = 0 A = 10110100
    rlc A
;Z=0 N=0 H=0 C=1, A = 01101001

;;;;;;;;;;;;;;;; RL
    rl A
; Z=0 N=0 H=0 C=0 A=11010011
    rl A
; Z=0 N=0 H=0 C=1 A=10100110

;;;;;;;;;;;;;;;; SLA
    sla A
; Z=0 N=0 H=0 C=1 A=01001100
    sla A
; Z=0 N=0 H=0 C=0 A=10011000

;;;;;;;;;;;;;;;; SRA
    sra A
; Z=0 N=0 H=0 C=0 A=11001100
    sra A
; Z=0 N=0 H=0 C=0 A=11100110
    ld A, %01100111
    sra A
; Z=0 N=0 H=0 C=1 A=00110011

;;;;;;;;;;;;;;; SLA
    sla A
; Z=0 N=0 H=0 C=0 A=01100110
    sla A
    sla A
; Z=0 N=0 H=0 C=1 A=10011000

;;;;;;;;;;;;;;;; SWAP
    swap A
; Z=0 N=0 H=0 C=0 A=10001001

;;;;;;;;;;;;;;;; RRC
    rrc A
; Z=0 N=0 H=0 C=1 A=11000100

    rrc A
; Z=0 N=0 H=0 C=0 A=01100010

;;;;;;;;;;;;;;;; RR
    rr A
; Z=0 N=0 H=0 C=0 A=00110001
    rr A
; Z=0 N=0 H=0 C=1 A=00011000
    rr A
; Z=0 N=0 H=0 C=0 A=10001100

;;;;;;;;;;;;;;;;; SRA
    sra A
; Z=0 N=0 H=0 C=0 A=11000110
    ld A, %01000001
    sra A
; Z=0 N=0 H=0 C=1 A=00100000

;;;;;;;;;;;;;;;;; SRL
    ld A, %10100001
    srl A
; Z=0 N=0 H=0 C=1 A=01010000
    srl A
; Z=0 N=0 H=0 C=0 A=00101000

;;;;;;;;;;;;;;;; BIT
    ld A, %10101010
    bit 0, A
    ; Z=0 N=0 H=1 C=0 A=10101010
    bit 1, A
    ; Z=1 N=0 H=1 C=0 A=10101010    
    bit 2, A
    ; Z=0 N=0 H=1 C=0 A=10101010    
    bit 3, A
    ; Z=1 N=0 H=1 C=0 A=10101010    
    bit 4, A
    ; Z=0 N=0 H=1 C=0 A=10101010        
    bit 5, A
    ; Z=1 N=0 H=1 C=0 A=10101010        
    bit 6, A
    ; Z=0 N=0 H=1 C=0 A=10101010        
    bit 7, A
    ; Z=1 N=0 H=1 C=0 A=10101010   

;;;;;;;;;;;;;;;; RES
    ld A, %11111111
    res 0, A
    ; Z=0 N=0 H=1 C=0 A=11111110
    res 1, A
    ; Z=0 N=0 H=1 C=0 A=11111100
    res 2, A
    ; Z=0 N=0 H=1 C=0 A=11111000
    res 3, A
    ; Z=0 N=0 H=1 C=0 A=11110000
    res 4, A
    ; Z=0 N=0 H=1 C=0 A=11100000
    res 5, A
    ; Z=0 N=0 H=1 C=0 A=11000000
    res 6, A
    ; Z=0 N=0 H=1 C=0 A=10000000
    res 7, A
    ; Z=0 N=0 H=1 C=0 A=00000000 

    set 0, A
    ; Z=0 N=0 H=1 C=0 A=00000001
    set 1, A
    ; Z=0 N=0 H=1 C=0 A=00000011
    set 2, A
    ; Z=0 N=0 H=1 C=0 A=00000111
    set 3, A
    ; Z=0 N=0 H=1 C=0 A=00001111
    set 4, A
    ; Z=0 N=0 H=1 C=0 A=00011111
    set 5, A
    ; Z=0 N=0 H=1 C=0 A=00111111
    set 6, A
    ; Z=0 N=0 H=1 C=0 A=01111111
    set 7, A
    ; Z=0 N=0 H=1 C=0 A=11111111                                     