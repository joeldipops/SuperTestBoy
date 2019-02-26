    IF !DEF(SOFTWARE_CONSTANTS_INCLUDED)
SOFTWARE_CONSTANTS_INCLUDED SET 1

BG_PALETTE EQU %11100100
FG_PALETTE EQU %11000110
TILE_SIZE EQU 16

INPUT_THROTTLE EQU 4

START   EQU %10000000
SELECT  EQU %01000000
A_BTN   EQU %00100000
B_BTN   EQU %00010000
DOWN    EQU %00001000
UP      EQU %00000100
LEFT    EQU %00000010
RIGHT   EQU %00000001

; Tile pointers
DARKEST EQU 3
CURSOR EQU 3 ; Will have a proper image at some point.
DARK EQU 2
LIGHT EQU 1
LIGHTEST EQU 0

; Program states
STATE_BASE EQU __LINE__ + 1
INIT_STATE          EQU __LINE__ - STATE_BASE
MAIN_MENU_STATE     EQU __LINE__ - STATE_BASE
JOYPAD_TEST_STATE   EQU __LINE__ - STATE_BASE
SGB_TEST_STATE      EQU __LINE__ - STATE_BASE
AUDIO_TEST_STATE    EQU __LINE__ - STATE_BASE
MLT_REQ_STATE       EQU __LINE__ - STATE_BASE
PALPQ_STATE         EQU __LINE__ - STATE_BASE
MASK_EN_STATE       EQU __LINE__ - STATE_BASE
MASKED_EN_STATE     EQU __LINE__ - STATE_BASE
PALPQ_COLOUR_STATE  EQU __LINE__ - STATE_BASE
MAX_STATE           EQU __LINE__ - STATE_BASE

MAX_MENU_DEPTH EQU 4

; Layout Constants
MARGIN_LEFT EQU 8
MENU_MARGIN_LEFT EQU 16
MENU_MARGIN_TOP EQU 16

; Software Addresses 
stackFloor EQU $ffff ; Might change to DFFF when actually start using the stack
runDma EQU $ff80


    ENDC