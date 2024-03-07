#import adb
#import io
#import system
#import tty
#import uefi
#import bios
#import package 

class main(){
#define BOOL:"main":"adb.lib::log(io::wfile("recent.log", "--wr"))"
do main()
}

func aida(main()){
bios.config::registrywrite("0x0", "BASEADDR")
bios.config::registrywrite("0x380000000", "LIMIT")
bios.config::registrywrite("0x303030", "SUSPEND")
bios.config::registrywrite("0x1", "FAIL")
bios.config::registrywrite("0x00", "SUCCESS")
}


private class ImagingFile(){
#! This section must not be heavily edited, editing it
#! can and will modify your system settings, please
#! proceed with caution, as this is dangerous for your
#! environment!

#define UINT_32:"imgfile":"ramimg.img"
#define UINT_64:"imglimit":"300000"
#define UINT_64:"imgram":"500000"
#define UINT_32:"imgheader":"0x0"

do aida()

from imgfile system.lib::iowrite("ramimg.img", "--wr")
from imglimit system.lib::iowrite("ramimg.img", "--wr")
from imgram system.lib::iowrite("ramimg.img", "--wr")
from imgheader system.lib::iowrite("ramimg.img", "--wr")

#define FLOAT:"No_Patch"=true
#define FLOAT:"No_Debugging"=false
#define FLOAT:"No_Allocators"=false
#define FLOAT:"Tasking"=true
#define FLOAT:"Processing"=true
#define FLOAT:"Discard_On_Shutdown"=true
#define FLOAT:"Managing"=true

package \.'ada'::{system_compiler_config}::write(dbglog(aida(), "--wr"))
package \.'ada'::{universal_linking}::read("ramimg.img", "--rw")

#define UINT_32:"bootheader":"0xEFFFFF"
#define UINT_32:"bootloader":"ueloader"
#define UINT_32:"bootmanager":"grub"

package \.'adb'::{boot_mgr}::write(--command, cmd="grub --uefi-setup=true --type=x86-64 --vm=qemu --name=adb_sata --file qemu.xml")
package \.'adb'::{boot_ldr}::write(--command, cmd="ueloader --load qemu.xml --secureboot --image=adb_sata")
package \.'cargo'::{compile_linking_file}::write(--command, cmd="cargo --fstab ramimg.img,qemu.xml,adb_sata --no-linking=false")

}
