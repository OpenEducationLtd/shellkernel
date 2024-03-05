#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <libxml/parser.h>

#define QEMU_BINARY "/qemu18/boot/"
#define VM_CONFIG_FILE "/qemu18/qconfig.xml"

int main(int argc, char **argv) {
    int ret;
    xmlDocPtr doc;
    xmlNodePtr root, node;
    char cmd[1024];

    // Parse the VM configuration file
    doc = xmlParseFile(VM_CONFIG_FILE);
    if (doc == NULL) {
        fprintf(stderr, "Error parsing VM configuration file: %s\n", xmlGetLastError());
        exit(1);
    }

    root = xmlDocGetRootElement(doc);
    if (root == NULL) {
        fprintf(stderr, "Error getting root element of VM configuration file\n");
        xmlFreeDoc(doc);
        exit(1);
    }

    // Create the VM
    sprintf(cmd, "%s -name qemu18 -m 1024 -smp 4 -boot d -enable-kvm -device e1000,netdev=net0 -netdev user,id=net0 -drive if=none,id=hd,file=/path/to/disk.img,format=raw -device virtio-blk-device,drive=hd -vnc :0", QEMU_BINARY);
    ret = system(cmd);
    if (ret != 0) {
        fprintf(stderr, "Error creating VM: %s\n", strerror(errno));
        xmlFreeDoc(doc);
        exit(1);
    }

    // Wait for the VM to exit
    wait(NULL);

    // Clean up
    xmlFreeDoc(doc);

    return 0;
}
