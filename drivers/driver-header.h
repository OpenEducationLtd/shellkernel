#ifndef DRIVER_H
#define DRIVER_H

#include <stdint.h>

// Define the driver interface
typedef struct {
    int (*init)(void);
    int (*deinit)(void);
    int (*read)(uint8_t *buffer, uint32_t length);
    int (*write)(const uint8_t *buffer, uint32_t length);
} driver_t;

// Initialize the driver
int driver_init(void);

// Deinitialize the driver
int driver_deinit(void);

// Read data from the driver
int driver_read(uint8_t *buffer, uint32_t length);

// Write data to the driver
int driver_write(const uint8_t *buffer, uint32_t length);

#endif // DRIVER_H
