ENTRY(_reset);
MEMORY {
  flash(rx) : ORIGIN = 0x10000000, LENGTH = 16M
  sram(rwx) : ORIGIN = 0x20000000, LENGTH = 264k
}
_estack = ORIGIN(sram) + LENGTH(sram);  /* stack points to end of SRAM */

SECTIONS {
  .vectors : { KEEP(*(.vectors)) } > flash
  .text    : { *(.text*) }         > flash
  .rodata  : { *(.rodata*) }       > flash

  .data : {
    _sdata = .;  /* .data section start */
    *(.first_data)
    *(.data SORT(.data.*))
    _edata = .;  /* .data section end */
  } > sram AT > flash
  _sidata = LOADADDR(.data);

  .bss : {
    _sbss = .;  /* .bss section start */
    *(.bss SORT(.bss.*) COMMON)
    _ebss = .;  /* .bss section end */
  } > sram

  . = ALIGN(8);
  _end = .;  /* for cmsis_gcc.h */
}