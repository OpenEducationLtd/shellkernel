#ifndef CPU_HEADER_H
#define CPU_HEADER_H

// Macro definitions
#define CONSTANT1 0x1234
#define CONSTANT2 0x5678

// Declarations for memory-mapped I/O registers
#define MMIO_REG1 0x1000
#define MMIO_REG2 0x1004

// Interrupt handling functions and data structures
void interrupt_handler(void);

// Memory management functions and data structures
void* mem_alloc(size_t size);
void mem_free(void* addr);

// Data structures for representing system state
typedef struct {
    uint32_t task_id;
    uint32_t task_state;
    uint32_t task_priority;
    uint32_t task_stack_pointer;
} tcb_t;

typedef struct {
    uint32_t sender_id;
    uint32_t recipient_id;
} msg_t;

// Function prototypes
void mem_alloc(uint32_t size);
void mem_free(uint32_t addr);

// Global variables
extern uint32_t var1;
extern uint32_t var2;

#endif // CPU_HEADER_H
