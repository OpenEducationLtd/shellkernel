#! Sample Patch File
# This will demonstrate a sample of a patch file, used for updating, installing and maintaining the OS.

#!/bin/riscv_patch/

#idefine UINT_32:"riscv_console,{riscv_header}"
#idefine UINT_32:"riscv_patch,{patch,mirror}"

#!/bin/riscv_patch/portage/

#idefine UNSAFE:"memaddr_start,0xb"
#idefine UNSAFE:"memaddr_end,0xbf"
#idefine UNSAFE:"meaddr_hdr,0x200000b"
#idefine UNSAFE:"core_hdr,0xbe00"
#idefine UNSAFE:"core_addr,0x200000f"
#idefine UNSAFE:"core_ldr,ueloader"
#idefine UNSAFE:"core_mgr,grub"



