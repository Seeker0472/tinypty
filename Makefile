Q ?= @
CC ?= gcc
CFLAGS ?=    
LDFLAGS ?=                  

override NAME = tinypty
SRC_DIR = src
OBJ_DIR = build
TARGET = $(OBJ_DIR)/$(NAME)
TARGET_SO = $(OBJ_DIR)/lib$(NAME).so
ARCHIVE = $(OBJ_DIR)/lib$(NAME).a

SRCS = $(wildcard $(SRC_DIR)/*.c) 
ifneq ($(filter $(MAKECMDGOALS), archive test),)
  $(info 1 MAKECMDGOALS=$(MAKECMDGOALS))
  # 构建 archive: 排除 main.c
  SRCS_NO_MAIN = $(filter-out $(SRC_DIR)/main.c, $(SRCS))
  OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS_NO_MAIN))

else
  # 构建 run: 包含 main.c
  $(info 2 MAKECMDGOALS=$(MAKECMDGOALS))
  OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))
endif

CFLAGS += -Iinc/ -fPIC
all: $(TARGET)

$(TARGET): $(OBJS)
	@echo + ELF $^ -> $@
	$(Q) $(CC) $(CFLAGS) $(OBJS) -o $@ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@echo + CC $<
	@mkdir -p $(@D) 
	$(Q) $(CC) $(CFLAGS) -c $< -o $@

run:$(TARGET)
	./$(TARGET)

$(TARGET_SO): $(OBJS)
	@ echo "+ SO $^ \n     -> `pwd`$@"
	$(Q) $(CC) -shared $(LDFLAGS) -o $@  $(OBJS) 

$(ARCHIVE): $(OBJS)
	@ echo "+ AR $^ \n     -> `pwd`$@"
	$(Q) $(AR) rcs  $@ $^

archive:$(ARCHIVE)

install:$(TARGET_SO)
	install -d /usr/local/lib
	install -m 0755 $(TARGET_SO) /usr/local/lib/
	ldconfig

uninstall:
	rm /usr/local/lib/lib$(NAME).so
	ldconfig

test-so:clean $(TARGET_SO)
	gcc -I./inc/ -o ./build/tinypty src/main.c -L./build -ltinypty && LD_LIBRARY_PATH=./build:$LD_LIBRARY_PATH ./build/tinypty
test-a:clean $(ARCHIVE)
	gcc -I./inc/ -o ./build/tinypty src/main.c -L./build -ltinypty && ./build/tinypty
test-install:clean 
	@mkdir -p ./build/
	gcc -I./inc/ -o ./build/tinypty src/main.c  -ltinypty  && ./build/tinypty
test:test-a test-so

clean:
	rm -rf $(OBJ_DIR) $(TARGET) $(TARGET_SO) $(ARCHIVE)

.PHONY: all clean archive test install
