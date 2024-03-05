#ifndef RAM_HEADER_H
#define RAM_HEADER_H

#include <stdint.h>

// RAM header structure
typedef struct {
    uint32_t magic_number;
    uint32_t version;
    uint32_t entry_point;
    uint32_t init_code_size;
    uint32_t statement_code_size;
    uint32_t device_code_size;
    uint32_t ram_size;
    uint32_t reserved[8];
} ram_header_t;

// RAM header functions
void ram_header_init(ram_header_t *header);
void ram_header_set_magic_number(ram_header_t *header, uint32_t magic_number);
void ram_header_set_version(ram_header_t *header, uint32_t version);
void ram_header_set_entry_point(ram_header_t *header, uint32_t entry_point);
void ram_header_set_init_code_size(ram_header_t *header, uint32_t init_code_size);
void ram_header_set_statement_code_size(ram_header_t *header, uint32_t statement_code_size);
void ram_header_set_device_code_size(ram_header_t *header, uint32_t device_code_size);
void ram_header_set_ram_size(ram_header_t *header, uint32_t ram_size);

// RAM header constants
#define RAM_MAGIC_NUMBER 0xeffff0ccffff
#define RAM_VERSION 1

#endif // RAM_HEADER_H
