#Compiling
TRGT = arm-none-eabi-
CC  = $(TRGT)gcc
CPP = $(TRGT)g++

#Linking
CP = $(TRGT)objcopy
OD = $(TRGT)objdump
HEX = $(CP) -O ihex
BIN= $(CP) -O binary

MCPU = cortex-m3
BUILDFLAGS = -mcpu=$(MCPU) -mthumb --specs=nosys.specs -g -std=gnu11

#C warnings
CWARN  = -Wall -Wextra -Wstrict-prototypes
#CPP warnings
CPPWARN = -Wall -Wextra

#Directories and Files
INCDIR = inc
SRCDIR = src
OBJDIR = out
SRC    = $(wildcard $(SRCDIR)/*.c)
OBJ    = $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SRC))

BINDIR = bin

EXEC = $(BINDIR)/main.out

all: $(EXEC)

clean:
		rm -f $(EXEC)
		rm -f out/*.o

$(EXEC): $(OBJDIR)/$(OBJ) main.c
		@echo "  CC/LD  main"
		@$(CC) $(BUILDFLAGS) -I$(INCDIR) -o $(EXEC) main.c $(OBJDIR)/*.o	
		@$(HEX) $(EXEC) $(BINDIR)/main.hex
		@$(BIN) $(EXEC) $(BINDIR)/main.bin

$(OBJDIR)/%.o: $(SRCDIR)/%.c
		@echo "  CC    " $<
		@$(CC) $(BUILDFLAGS) -I$(INCDIR) -c $< -o $@
