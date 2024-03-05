#include <stdint.h>

// Define the boot header structure
typedef struct {
    uint32_t magic;
    uint32_t version;
    uint32_t entry;
    uint32_t text_size;
    uint32_t data_size;
    uint32_t bss_size;
    uint32_t stack_size;
    uint32_t reserved[4];
} boot_header_t;

// Define the boot header magic number
#define BOOT_HEADER_MAGIC 0x1BADB002

// Define the boot header version
#define BOOT_HEADER_VERSION 0x00000001

// Define the entry point of the kernel
#define KERNEL_ENTRY_POINT 0x100000

// Define the sizes of the kernel sections
#define KERNEL_TEXT_SIZE 0x10000
#define KERNEL_DATA_SIZE 0x10000
#define KERNEL_BSS_SIZE 0x10000

// Define the stack size
#define KERNEL_STACK_SIZE 0x10000

// Define the boot header
boot_header_t boot_header = {
    .magic = BOOT_HEADER_MAGIC,
    .version = BOOT_HEADER_VERSION,
    .entry = KERNEL_ENTRY_POINT,
    .text_size = KERNEL_TEXT_SIZE,
    .data_size = KERNEL_DATA_SIZE,
    .bss_size = KERNEL_BSS_SIZE,
    .stack_size = KERNEL_STACK_SIZE,
};
