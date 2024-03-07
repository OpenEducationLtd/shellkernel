program ModuleService

#import adb
#import io
#import async
#import system
#import uefi
#import bios

class main(){
adb.config::define_Headers([
#define UINT_32:"nodes":"0x0"
#define UINT_32:"network":"0x0"
#define UINT_32:"tty":"0x0"
])
io::wfile(adb.config, "headers.inf")
io::rfile("headers.inf", "--rw")
}

private class MainSvc(){
system.lib::dbglog(adb.config)
do main()
io::rfile("info.txt", "--wr")
from adb.config.nodes::createNode(0x0, 127.0.0.1)
from adb.config.network::enable(wlan0, 127.0.0.1)
from adb.config.tty::runservice("MainSvc", "module-svc.be", "msvc", "0x0")
}

private class GetModules(){
system.lib::dbglog(adb.config)
do MainSvc()
io::rfile("headers.inf", "--rw")
#define BOOL:"mainfunc":"system.lib::dbglog(system.lib::procget())"
from mainfunc system.lib::hook(mainfunc, --root, proc="module-svc.be")
do mainfunc()
}
