TARGET = hello

BIN = ./bin
OUT = ./out
SRC = ./src

OBJS = main.o loop.o shader.o obj.o error.o transform.o vec.o gl.o
FLAG = -felf64 -g

INCDIR = -I/usr/include/SDL2
LINKIN = -lSDL2main -lSDL2 -lGL

all : setEntry $(addprefix $(BIN)/, $(OBJS))
	@echo ----- Linking
	@echo		$(OBJS)
	@g++ $(addprefix $(BIN)/, $(OBJS)) -o $(OUT)/$(TARGET) $(LINKIN)
	@echo ----- Used flags
	@echo $(FLAG)

test : setEntry testflag $(addprefix $(BIN)/, $(OBJS)) $(addprefix $(BIN)/, test.o)
	@echo ----- Linking
	@echo		$(OBJS) test.o
	@g++ $(addprefix $(BIN)/, $(OBJS)) $(addprefix $(BIN)/, test.o) -o $(OUT)/$(TARGET) $(LINKIN)
	@echo ----- Used flags
	@echo $(FLAG)

setEntry:
	@rm $(addprefix $(BIN)/, main.o test.o) | true
	@echo ----- Removed main.o, test.o

testflag:
	$(eval FLAG += -DTEST)

$(BIN)/%.o : $(SRC)/%.asm
	@echo ----- Compiling $(notdir $<)
	@cd src; \
	nasm -o ../$@ $(notdir $<) $(FLAG)

run :
	@echo ----- Excute
	@cd $(OUT); \
	./$(TARGET)

clean:
	@rm $(BIN)/*.o $(OUT)/$(TARGET) | true
	@echo ----- Removed object files and excutable file

debug:
	@cd $(OUT); \
	gdb -q ./$(TARGET)
