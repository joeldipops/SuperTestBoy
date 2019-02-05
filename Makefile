FILENAME := superTestBoy

all:
	rgbasm -o ./bin/$(FILENAME).o ./src/main.asm
	rgblink -o ./bin/$(FILENAME).gb -n ./bin/$(FILENAME).sym ./bin/$(FILENAME).o
	rgbfix -v -p 0xFF ./bin/$(FILENAME).gb

clean:
	rm ./bin/$(FILENAME).*