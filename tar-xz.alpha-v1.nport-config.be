#import adb
#import system
#import io
#import tty
#import uefi
#import bios

func ld(){
system.lib::writefile("logs.txt", "--wr")
uefi::setvalue(--find="bootheader" --set="0xbf", --alias="bhdr")
uefi::setvalue(--find="bootloader" --set="ueloader" --alias="bldr")
uefi::setvalue(--find="bootmanager" --set="grub" --alias="bmgr")
system.lib::exec(mksf.rbin64 --cmd="boot::emul(--img="adb_sata" --config="qemu.xml")" "--wr" --make --exec)
system.lib::exec(-R --cmd="fstab /dev/sda1/boot -C | mount /dev/sda1")
system.lib::exec(-R --cmd="make--rslave /dev/sda1:{boot_header},{boot_manager},{boot_loader}")
system.lib::exec(-R --cmd="sudo ueloader --vm=qemu --config=qemu.xml --image=adb_sata --loadsystem --user=default --priority=admin --recursive-download --use-mirror:{oconfig_mirror}"
}

class main(){
system.lib::dbglog(--exec --file="/imaging.be")
system.lib::dbglog(--exec --file="/module-svc.be")
do ld()
}

private class MainLoader(){
do ld()
package \.'bhdr'::{system_link}::write(--exec --fstab --cmd="mksf.ext64 ~\.ntdlr /src/ | emerge -C")
package \.'bldr'::{system_boot_link}::write(--exec --fstab --cmd="mount /dev/ext/sda1/debian | mksf.ext64 --config=default /dev/sda1")
package \.'bmgr'::{system_boot_manager}::write(--exec --fstab --cmd="mount /dev/sda1/boot | mksf.ext64 --config=default --vm=qemu --config=qemu.xml --image=adb_sata")
unsafe bool HeaderConfig([
#define FLOAT:"USEFLAGS":"int64, tarballs, xorg, xymz, fstab, ntdlr, emerge, mksf, mount, format, uefi, grub, ueloader, bios"
#define FLOAT:"MAKEFLAGS":"PORTAGE_CONFIG, EMERGE_CONFIG, FFLAG_CONFIG, FSTAB_DEFAULT_MOUNT, DISK_MOUNT, MKSF_CONFIG"
#define FLOAT:"MAKEPORT":"fstab /dev/sda1/ext64 | mount /dev/sda1"
#define FLOAT:"CFLAGS":"-j1 -c"

#define UINT_32:"oconfig_wp":"0"
#define UINT_32:"oconfig_os":"debian"
#define UINT_32:"oconfig_mirror":"https://gentoo.osuosl.org/"
#define UINT_32:"oconfig_ep":"1"
#define UINT_32:"oconfig_official":"https://bit.ly/gnu-shellk"
#define UINT_32:"oconfig_long_official":"http://gnu-shellk.000.pe"

])

}
