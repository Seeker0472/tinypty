CC ?= gcc
CFLAGS ?=    
LDFLAGS ?=                  

SRC_DIR = src
OBJ_DIR = build
TARGET = myapp             

SRCS = $(wildcard $(SRC_DIR)/*.c) 
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)  	$(CC) $(CFLAGS) -c $< -o $@

run:$(TARGET)
	./myapp

clean:
	rm -rf $(OBJ_DIR) $(TARGET)

.PHONY: all clean
