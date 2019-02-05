make
cp ./bin/superTestBoy.gb ../TransferBoy/assets/superTestBoy.gb
cp ./includes/addresses.asm ../gbz80-pseudoOps/addresses.inc
cp ./includes/ops.asm ../gbz80-pseudoOps/ops.inc
wine ~/Projects/tools/bgb/bgb64.exe ./bin/superTestBoy.gb
