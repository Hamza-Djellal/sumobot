# Directories
TOOLS_DIR = /home/hamza/dev/tools
MSPGCC_ROOT_DIR = $(TOOLS_DIR)/msp430-gcc
MSPGCC_BIN_DIR = $(MSPGCC_ROOT_DIR)/bin
MSPGCC_INCLUDE_DIR = $(MSPGCC_ROOT_DIR)/include
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj

LIB_DIRS = $(MSPGCC_INCLUDE_DIR)
INCLUDE_DIRS = $(MSPGCC_INCLUDE_DIR) \
			   ./src \
			   ./external/ \
			   ./

# Toolchain
CC = $(MSPGCC_BIN_DIR)/msp430-elf-gcc
RM = rm
CPPCHECK = cppcheck

# Files
TARGET = $(BUILD_DIR)/bin/sumbot

SOURCES_WITH_HEADERS = \
		src/drivers/io.c \

SOURCES = \
		src/main.c \
		$(SOURCES_WITH_HEADERS)

HEADERS = \
		$(SOURCES_WITH_HEADERS:.c=.h) \
		src/common/defines.h

OBJECT_NAMES = $(SOURCES:.c=.o)
OBJECTS = $(patsubst %,$(OBJ_DIR)/%,$(OBJECT_NAMES))



# Static Analysis
## Don't check the msp430 helper headers (they have a LOT of ifdefs)
CPPCHECK_INCLUDES = ./src ./
IGNORE_FILES_FORMAT_CPPCHECK = \
	external/printf/printf.h \
	external/printf/printf.c
CPPCHECK_FLAGS = \
	--quiet --enable=all --error-exitcode=1 \
	--inline-suppr \
	--suppress=missingIncludeSystem \
	--suppress=unmatchedSuppression \
	--suppress=unusedFunction \
	--suppress=checkersReport \
	$(addprefix -I,$(CPPCHECK_INCLUDES)) \

# Flags
MCU = msp430g2553
WFLAGS = -Wall -Wextra -Werror -Wshadow
CFLAGS = -mmcu=$(MCU) $(WFLAGS) -fshort-enums $(addprefix -I,$(INCLUDE_DIRS)) $(DEFINES) -Og -g
LDFLAGS = -mmcu=$(MCU) $(DEFINES) $(addprefix -L,$(LIB_DIRS)) $(addprefix -I,$(INCLUDE_DIRS))

# Build
## Linking
$(TARGET): $(OBJECTS) $(HEADERS)
	echo $(OBJECTS)
	@mkdir -p $(dir $@)
	$(CC) $(LDFLAGS) $^ -o $@

## Compiling
$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $^

# Phonies
.PHONY: all clean cppcheck 

all: $(TARGET)

clean:
	@$(RM) -rf $(BUILD_DIR)

cppcheck:
	@$(CPPCHECK) $(CPPCHECK_FLAGS) $(SOURCES)
