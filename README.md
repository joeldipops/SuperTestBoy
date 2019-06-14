# SuperTestBoy
Companion project to TransferBoy. The goal being to comprehensively test each SuperGameBoy command.

## Testable Commands
* PAL01, PAL23, PAL12, PAL03 - Set the seven colours per command by setting a high bits low libbles for the RGBs of each colour.
* MASK_EN - Can choose whether to Freeze, Black-out or Colour-out the screen.  Pressing any key after masking unmacks

## In-progress Commands
* MLT_REQ - Can send the command for 1, 2 or 4 player mode, but doesn't seem to be working properly in BGB.  No way to test if command was succesful.
* PCT_TRN - Sends the packets successfully, but haven't set up any data, so just overlays the screen with junk.
* Initialisation packet - I can't recall what this does or if there's any way to test it, but I read somewhere that it's a thing, and SuperTestBoy will send it if you want it to.

## Coming soon/next
* ATTR_LIN - SO I can exercise all the palettes set up by the PALpq commands
* PAL_PRI - Cos it should be easy

