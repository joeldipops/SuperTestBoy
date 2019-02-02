cd src
rgbasm -o ../bin/superTestBoy.o ./main.asm
cd ..
rgblink -o ./bin/superTestBoy.gb -n ./bin/superTestBoy.sym ./bin/superTestBoy.o
rgbfix -v -p 0xC7 ./bin/superTestBoy.gb
cp ./bin/superTestBoy.gb ../TransferBoy/assets/superTestBoy.gb
cp ./includes/addresses.asm ../gbz80-pseudoOps/addresses.inc
cp ./includes/ops.asm ../gbz80-pseudoOps/ops.inc
wine ~/Projects/tools/bgb/bgb64.exe ./bin/superTestBoy.gb
