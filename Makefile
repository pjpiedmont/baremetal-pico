CFLAGS  ?=  -W -Wall -Wextra -Werror -Wundef -Wshadow -Wdouble-promotion \
			-Wformat-truncation -fno-common -Wconversion \
			-g3 -Os -ffunction-sections -fdata-sections -I. \
			-mcpu=cortex-m0plus -mthumb $(EXTRA_CFLAGS)
LDFLAGS ?=  -Tlink.ld -nostartfiles -nostdlib --specs nano.specs -lc -lgcc \
			-Wl,--gc-sections -Wl,-Map=$@.map
SOURCES = main.c

build: firmware.uf2

firmware.elf: $(SOURCES)
	arm-none-eabi-gcc $(SOURCES) $(CFLAGS) $(LDFLAGS) -o $@

firmware.bin: firmware.elf
	arm-none-eabi-objcopy -O binary $< $@

firmware.uf2: firmware.bin bin2uf2
	./bin2uf2 $< $@

bin2uf2: tools/bin2uf2.c
	$(CC) -W -Wall $< -o $@
