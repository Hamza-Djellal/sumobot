#Directories

MSPGCC_ROOT_DIR = /home/hamza/dev/tools/msp430-elf-gcc
MSPGCC_BIN_DIR = $(MSPGCC_ROOT_DIR)/bin
MSPGCC_INCLUDE_DIR = $(MSPGCC_ROOT_DIR)/include
INCLUDE_DIRS = $(MSPGCC_INCLUDE_DIR)
BIN_DIRS = $(MSPGCC_BIN_DIR)

#toolchain 
CC = $(BIN_DIRS)/msp430-elf-gcc

#FLAGS
MCU = msp430g2253
WFLAGS = -Wall -Wextra -Werror -Wshadow -Wdouble-promotion
CFLAGS = -mmcu=$(MCU) $(WFLAGS) $(addprefix -I, $(INCLUDE_DIRS)) -Og -g
LDFLAGS = -mmcu=$(MCU) $(addprefix -L, $(INCLUDE_DIRS))
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj
BIN_DIR = $(BUILD_DIR)/bin
CPPCHECK = cppcheck

#Files
TARGET= $(BIN_DIR)/blink
SOURCES = src/app/main.c src/app/led.c

#Objects
OBJECTS_NAMES = $(SOURCES:.c=.o)
OBJECTS = $(addprefix $(OBJ_DIR)/, $(OBJECTS_NAMES))

#Build
##Link
$(TARGET):$(OBJECTS)
	@mkdir -p $(dir $@)
	$(CC) $(LDFLAGS) -o $@ $^

##Compile
$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $^


.PHONY:all clean cppcheck

all:$(TARGET)

clean:	
	@rm -rf $(BUILD_DIR)/
cppcheck:
	@$(CPPCHECK) --quiet --enable=all \
	 --error-exitcode=1 --inline-suppr \
	 -I $(INCLUDE_DIRS) \
	$(SOURCES)
