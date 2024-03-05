ROM_HEADER:
    .db "QEMU18"
    .dw INIT
    .dw STATEMENT
    .dw DEVICE
    .dw TEXT_POINTER
    .dw 0
    .dw 0
    .dw 0
    .dw 0
    .dw 0
    .dw 0
    .dw 0

TEXT_POINTER:
    .dw "qemu18 OS"

INIT:
    ; Initialize the qemu18 OS
    LOAD QEMU18_OS
    LOAD KERNEL

    ; Set up the kernel in the OS
    STORE OS, KERNEL

    ; Start the main loop
    JP MAIN_LOOP

STATEMENT:
    ; Statement routine for the qemu18 OS
    RET

DEVICE:
    ; Device routine for the qemu18 OS
    RET

MAIN_LOOP:
    ; Main loop for the qemu18 OS
    ; TODO: Add code for the main loop

    ; Halt the program
    HALT

QEMU18_OS:
    .dw 0x966c83cbf88d0f91f65f938e569b72ef

KERNEL:
    .dw 0x8379cf9e0ee29438aad3cf6f281b4aeb
