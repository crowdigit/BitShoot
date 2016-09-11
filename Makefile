TARGET = hello

BIN = ./bin
OUT = ./out

OBJS = main.o loop.o shader.o obj.o error.o transform.o vec.o gl.o
FLAG = -felf64 -g

INCDIR = -I/usr/include/SDL2
LINKIN = -lSDL2main -lSDL2 -lGL

all : $(OBJS)
	g++ $(addprefix $(BIN)/, $(OBJS)) -o $(OUT)/$(TARGET) $(LINKIN) -g

%.o : %.asm
	nasm -o $(BIN)/$@ $< $(FLAG)

%.co : %.cpp
	g++ -Wall -c -o $@ $<

run :
	$(OUT)/$(TARGET)

clean:
	rm $(BIN)/*.o $(OUT)/$(TARGET)

debug:
	gdb ./$(TARGET)
