TARGET = hello

OBJS = main.o loop.o shader.o obj.o error.o transform.o vec.o
FLAG = -felf64 -g

INCDIR = -I/usr/include/SDL2
LINKIN = -lSDL2main -lSDL2 -lGL

all : $(OBJS)
	g++ $(OBJS) -o $(TARGET) $(LINKIN) -g

%.o : %.asm
	nasm -o $@ $< $(FLAG)

%.co : %.cpp
	g++ -Wall -c -o $@ $<

run :
	./$(TARGET)

clean:
	rm *.o $(TARGET)

debug:
	gdb ./$(TARGET)
