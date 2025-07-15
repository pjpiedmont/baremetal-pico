CFLAGS  ?=  -W -Wall -Wextra -Werror -Wundef -Wshadow -Wdouble-promotion \
			-Wformat-truncation -fno-common -Wconversion \
			-g3 -Os -ffunction-sections -fdata-sections -I. \
			-mcpu=cortex-m0plus -mthumb $(EXTRA_CFLAGS)
LDFLAGS ?=  -Tlink.ld -nostartfiles -nostdlib --specs nano.specs -lc -lgcc \
			-Wl,--gc-sections -Wl,-Map=$@.map
SOURCES = main.c

build: firmware.elf

firmware.elf: $(SOURCES)
	arm-none-eabi-gcc $(SOURCES) $(CFLAGS) $(LDFLAGS) -o $@
