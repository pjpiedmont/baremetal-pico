int main(void) {
    return 0;
}

// Startup code
__attribute__((naked, noreturn)) void _reset(void) {
    // memset .bss to zero and copy .data section to RAM region
    extern long _sbss;
    extern long _ebss;
    extern long _sdata;
    extern long _edata;
    extern long _sidata;

    for (long *dst = &_sbss; dst < &_ebss; dst++)
    {
        *dst = 0;
    }

    for (long *dst = &_sdata, *src = &_sidata; dst < &_edata;)
    {
        *dst++ = *src++;
    }

    main();

    while (1) {
        (void) 0;  // infinite loop if main ever returns
    }
}

extern void _estack(void);  // Defined in link.ld

// 16 standard ARM and 26 RP2040-specific IRQ handlers
__attribute__((section(".vectors"))) void (*const tab[16 + 26])(void) = {
    _estack, _reset
};