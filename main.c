// Startup code
__attribute__((naked, noreturn)) void _reset(void) {
    while (1) (void) 0;
}

extern void _estack(void);  // Defined in link.ld

// 16 standard ARM and 26 RP2040-specific IRQ handlers
__attribute__((section(".vectors"))) void (*const tab[16 + 26])(void) = {
    _estack, _reset
};