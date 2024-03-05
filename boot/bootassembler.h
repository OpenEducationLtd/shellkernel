#include <stdint.h>

#include <stddef.h>


#define EFI_SYSTEM_TABLE_SIGNATURE 0x5453595320494249ULL

#define EFI_BOOT_SERVICES_SIGNATURE 0x56524553544f4f42ULL

#define EFI_RUNTIME_SERVICES_SIGNATURE 0x56524553544e4f4dULL

#define EFI_LOADED_IMAGE_PROTOCOL_GUID \

    { 0x5b1b31a1, 0x9562, 0x11d2, \

      { 0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b } \

    }

#define EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL_GUID \

    { 0x387477c1, 0x69c7, 0x11d2, \

      { 0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b } \

    }

#define EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID \

    { 0x9042a9de, 0x23dc, 0x4a38, \

      { 0x96, 0xfb, 0x7a, 0xde, 0xd0, 0x80, 0x51, 0x6a } \

    }


typedef struct _EFI_TABLE_HEADER {

    uint64_t Signature;

    uint32_t Revision;

    uint32_t HeaderSize;

    uint32_t CRC32;

    uint32_t Reserved;

} EFI_TABLE_HEADER;


typedef struct _EFI_SYSTEM_TABLE {

    EFI_TABLE_HEADER Hdr;

    char16_t *FirmwareVendor;

    uint32_t FirmwareRevision;

    void *ConsoleInHandle;

    void *ConIn;

    void *ConsoleOutHandle;

    void *ConOut;

    void *StandardErrorHandle;

    void *StdErr;

    void *RuntimeServices;

    void *BootServices;

    uint64_t NumberOfTableEntries;

    void *ConfigurationTable;

} EFI_SYSTEM_TABLE;


typedef struct _EFI_BOOT_SERVICES {

    uint32_t EFI_HEAP_RUNTIME_HEADER;
    uint32_t EFI_BOOTHEADER_MAGIC;
    uint32_t EFI_CONFIG_MAGIC;

} EFI_BOOT_SERVICES;


typedef struct _EFI_RUNTIME_SERVICES {

    uint32_t EFI_QEMU_VMEMULATE;
    uint32_t EFI_UNIT_PRELOADCPU;

} EFI_RUNTIME_SERVICES;


typedef struct _EFI_LOADED_IMAGE_PROTOCOL {

    uint32_t Revision;

    void *ParentHandle;

    void *SystemTable;

    void *DeviceHandle;

    void *FilePath;

    void *Reserved;

    uint32_t LoadOptionsSize;

    void *LoadOptions;

    void *ImageBase;

    uint64_t ImageSize;

    uint32_t ImageCodeType;

    uint32_t ImageDataType;

    uint64_t Unload;

} EFI_LOADED_IMAGE_PROTOCOL;


typedef struct _EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL {

    uint32_t EFI_ENCODING_UNICODE18;

} EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL;


typedef struct _EFI_GRAPHICS_OUTPUT_PROTOCOL {

    uint32_t EFI_ENCODER_BASE64_MAGIC;

} EFI_GRAPHICS_OUTPUT_PROTOCOL;
