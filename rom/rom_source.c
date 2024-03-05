#include <stdint.h>

typedef struct {
    char system_name[8];
    char copyright[16];
    char title_domestic[16];
    char title_overseas[16];
    char serial_number[12];
    uint16_t checksum;
    char device_support[4];
    uint32_t rom_address_range_start;
    uint32_t rom_address_range_end;
    uint32_t ram_address_range_start;
    uint32_t ram_address_range_end;
    char save_ram_type;
    uint32_t save_ram_start_address;
    uint32_t save_ram_end_address;
    char modem[4];
    char regions[4];
    uint8_t random_data[64];
} qemu18_rom_header_t;

qemu18_rom_header_t qemu18_rom_header = {
    {'q', 'e', 'm', 'u', '1', '8', ' ', ' '},
    {'C', 'o', 'p', 'y', 'r', 'i', 'g', 'h', 't', ' ', '(', 'C', ')', ' ', '2', '0', '2', '3', ' ', 'M', 'y', ' ', 'N', 'a', 'm', 'e'},
    {'q', 'e', 'm', 'u', '1', '8', ' ', 'O', 'S'},
    {'q', 'e', 'm', 'u', '1', '8', ' ', 'O', 'S'},
    {'G', 'M', ' ', '0', '0', '0', '0', '1', '2', '3', '4', '-', '0', '0'},
    0,
    {'J', ' ', ' ', ' '},
    0,
    0xFFFFFF,
    0,
    0xFFFFFF,
    'R',
    0x200001,
    0x20FFFF,
    {' ', ' ', ' ', ' '},
    {'J', 'U', 'E', ' '},
    {
        0x96, 0x6c, 0x83, 0xcb, 0xf8, 0x8d, 0x0f, 0x91,
        0xf6, 0x5f, 0x93, 0x8e, 0x56, 0x9b, 0x72, 0xef,
        0x83, 0x79, 0xcf, 0x9e, 0x0e, 0xe2, 0x94, 0x38,
        0xaa, 0xd3, 0xcf, 0x6f, 0x28, 0x1b, 0x4a, 0xeb,
        0x82, 0x18, 0xe2, 0xcd, 0xda, 0x06, 0x2d, 0xe4,
        0xc9, 0xb1, 0x8d, 0xc9, 0xe3, 0x0f, 0xe6, 0xdb,
        0x7a, 0xfc, 0xdb, 0x4f, 0x7a, 0xeb, 0xb7, 0xa0,
        0xf4, 0x49, 0x9f, 0x06, 0x3b, 0xd3, 0x9c, 0x9c
    }
};
