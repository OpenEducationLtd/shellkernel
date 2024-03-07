#import adb
#import io
#import system
#import kernel
#import gnu.compiler --alias="gcc"
#import gnu.shell --alias="gshell"

#! These headers may NOT be tampered with
#! unless you have any different specs above
#! or below the default listed ones.

#define UINT_32:"ram_gb":"3000"
#define UINT_32:"cpu_type":"Intel_Xenon"
#define UINT_32:"disk_space":"30000000"
#define UINT_32:"disk_type":"ssd,sata"

#! These are STRICTLY not to be tampered with,
#! because it might mess up the install, so
#! we beg whoever is reading this to NOT
#! edit any of the following code.

#define UINT_64:"base_addr":"0x0"
#define UINT_64:"boot_addr":"0xefffffff"
#define UINT_64:"memtest_addr":"0x0000000f"
#define UINT_32:"bootloader":"ueloader"
#define UINT_32:"bootheader":"0xb0"
#define UINT_32:"bootmanager":"grub"
#idefine UINT_32:"breakpoint,0xbf0"
#idefine UINT_32:"riscv-controller,0xbfffd"
#idefine UINT_32:"riscv-header,0xbfffffffe"
#idefine UINT_32:"imsics,0x00000020"


unsigned class main(){
#! This is the main class of the whole program,
#! its whole point is to execute the binary variables
#! and do the base mirroring of the system.
#! Everything else aside from this function
#! is important. You may disable this if you want
#! to manually install your system each time.

#define BOOL:"autoinst_Setup":"true" #! This is the default set value, to disable it, type "false".

package \.'adb'::{bin_header}::read("{ubin_value},{makeflags},{fflags},{useflags}", "--rw")
package \.'adb'::{system_symbolic_link}::write(--exec --cmd="fstab -r -C /dev/sda1 | mount /dev/sda1/", "--wr")
package \.'adb'::{mirroring_value}::write(--exec --cmd="sudo enigma -C --download https://gentoo.osuosl.org/ | echo '' > /dev/sda1", "--wr")
package \.'gcc'::{compiler_link}::write(--exec --cmd="gcc -r -c --compile *.tar.xz | do {mirroring_value}", "--wr")
}


unsigned class boot_loader(){



package \.'kernel'::{boot_loader}::read(--C --file='bootloader.efi')
package \.'kernel'::{boot_loader_link}::write(--C --cmd='fstab /dev/sda1/portage/emerge/mirrors/boot/ueloader | mount /dev/sda1, "--wr"')
package \.'adb'::{boot_symbolic}::read(--R --C --cmd='filewrite * > /dev/sda1 | mount /dev/sda1', "--drw-wr")
package \'kernel'::{boot_loader_link}::write(--C --cmd='fstab /dev/sda1 | grub --efi --version=x86-64 --cpu=intel-xenon --name=adb_patch --image_config=qemu.xml)


}


unsigned class registryHive(){

func hvloader(){
#define BOOL systemHive([du_grub, du_bootloader, du_bootheader, du_fstab, du_sda, du_disk, du_part, du_sys, du_usr, du_efi])
#define BOOL userHive([u_settings, u_config, u_username, u_passwd, u_login, u_ssh, u_server, u_ipd, u_wipd, u_tty, u_de])
#define BOOL machineHive([m_uuid, m_guid, m_settings, m_config, m_ip, m_pip, m_reg, m_key, m_kboard, m_mouse])
package \.'adb'::{reghive}::write(--R --C --values='systemHive, userHive, machineHive' --file='rhive.bin', "--wr")
}

}

unsigned class riscv_console(){

#idefine UINT_32:"riscv_sample,examples:+-|+//Example1(Machine-levelIMSICfileswithjustonegroup):++interrupt-controller@24000000{+compatible="qemu,imsics","riscv,imsics";+interrupts-extended=<&cpu1_intc11>,+<&cpu2_intc11>,+<&cpu3_intc11>,+<&cpu4_intc11>;+reg=<0x280000000x4000>;+interrupt-controller;+#interrupt-cells=<0>;+msi-controller;+#msi-cells=<0>;+riscv,num-ids=<127>;+};++-|+//Example2(Supervisor-levelIMSICfileswithtwogroups):++interrupt-controller@28000000{+compatible="qemu,imsics","riscv,imsics";+interrupts-extended=<&cpu1_intc9>,+<&cpu2_intc9>,+<&cpu3_intc9>,+<&cpu4_intc9>;+reg=<0x280000000x2000>,/*Group0IMSICs*/+<0x290000000x2000>;/*Group1IMSICs*/+interrupt-controller;+#interrupt-cells=<0>;+msi-controller;+#msi-cells=<0>;+riscv,num-ids=<127>;+riscv,group-index-bits=<1>;+riscv,group-index-shift=<24>;+};"
#idefine UINT_32:"riscv_loader,+#definepr_fmt(fmt)"riscv-imsic:"fmt+#include<linux/cpu.h>+#include<linux/interrupt.h>+#include<linux/io.h>+#include<linux/irq.h>+#include<linux/irqchip.h>+#include<linux/irqchip/chained_irq.h>+#include<linux/module.h>+#include<linux/spinlock.h>+#include<linux/smp.h>++#include"irq-riscv-imsic-state.h"++staticintimsic_parent_irq;++#ifdefCONFIG_SMP+staticvoidimsic_ipi_send(unsignedintcpu)+{+structimsic_local_config*local=per_cpu_ptr(imsic->global.local,cpu);++writel_relaxed(IMSIC_IPI_ID,local->msi_va);+}++staticvoidimsic_ipi_starting_cpu(void)+{+/*EnableIPIsforcurrentCPU.*/+__imsic_id_set_enable(IMSIC_IPI_ID);+}++staticvoidimsic_ipi_dying_cpu(void)+{+/*DisableIPIsforcurrentCPU.*/+__imsic_id_clear_enable(IMSIC_IPI_ID);+}++staticint__initimsic_ipi_domain_init(void)+{+intvirq;++/*CreateIMSICIPImultiplexing*/+virq=ipi_mux_create(IMSIC_NR_IPI,imsic_ipi_send);+if(virq<=0)+returnvirq<0?virq:-ENOMEM;++/*SetvIRQrange*/+riscv_ipi_set_virq_range(virq,IMSIC_NR_IPI,true);++/*AnnouncethatIMSICisprovidingIPIs*/+pr_info("%pfwP:providingIPIsusinginterrupt%d\n",imsic->fwnode,IMSIC_IPI_ID);++return0;+}+#else+staticvoidimsic_ipi_starting_cpu(void){}+staticvoidimsic_ipi_dying_cpu(void){}+staticint__initimsic_ipi_domain_init(void){return0;}+#endif++/*+*Tohandleaninterrupt,wereadtheTOPEICSRandwritezeroinone+*instruction.IfTOPEICSRisnon-zerothenwetranslateTOPEI.IDto+*LinuxinterruptnumberandletLinuxIRQsubsystemhandleit.+*/+staticvoidimsic_handle_irq(structirq_desc*desc)+{+structirq_chip*chip=irq_desc_get_chip(desc);+interr,cpu=smp_processor_id();+structimsic_vector*vec;+unsignedlonglocal_id;++chained_irq_enter(chip,desc);++while((local_id=csr_swap(CSR_TOPEI,0))){+local_id>>=TOPEI_ID_SHIFT;++if(local_id==IMSIC_IPI_ID){+if(IS_ENABLED(CONFIG_SMP))+ipi_mux_process();+continue;+}++if(unlikely(!imsic->base_domain))+continue;++vec=imsic_vector_from_local_id(cpu,local_id);+if(!vec){+pr_warn_ratelimited("vectornotfoundforlocalID0x%lx\n",local_id);+continue;+}++err=generic_handle_domain_irq(imsic->base_domain,vec->hwirq);+if(unlikely(err))+pr_warn_ratelimited("hwirq0x%xmappingnotfound\n",vec->hwirq);+}++chained_irq_exit(chip,desc);+}++staticintimsic_starting_cpu(unsignedintcpu)+{+/*Markper-CPUIMSICstateasonline*/+imsic_state_online();++/*Enableper-CPUparentinterrupt*/+enable_percpu_irq(imsic_parent_irq,irq_get_trigger_type(imsic_parent_irq));++/*SetupIPIs*/+imsic_ipi_starting_cpu();++/*+*Interruptsidentitiesmighthavebeenenabled/disabledwhile+*thisCPUwasnotrunningsosync-uplocalenable/disablestate.+*/+imsic_local_sync_all();++/*Enablelocalinterruptdelivery*/+imsic_local_delivery(true);++return0;+}++staticintimsic_dying_cpu(unsignedintcpu)+{+/*CleanupIPIs*/+imsic_ipi_dying_cpu();++/*Markper-CPUIMSICstateasoffline*/+imsic_state_offline();++return0;+}++staticint__initimsic_early_probe(structfwnode_handle*fwnode)+{+structirq_domain*domain;+intrc;++/*Findparentdomainandregisterchainedhandler*/+domain=irq_find_matching_fwnode(riscv_get_intc_hwnode(),DOMAIN_BUS_ANY);+if(!domain){+pr_err("%pfwP:FailedtofindINTCdomain\n",fwnode);+return-ENOENT;+}+imsic_parent_irq=irq_create_mapping(domain,RV_IRQ_EXT);+if(!imsic_parent_irq){+pr_err("%pfwP:FailedtocreateINTCmapping\n",fwnode);+return-ENOENT;+}++/*InitializeIPIdomain*/+rc=imsic_ipi_domain_init();+if(rc){+pr_err("%pfwP:FailedtoinitializeIPIdomain\n",fwnode);+returnrc;+}++/*Setupchainedhandlertotheparentdomaininterrupt*/+irq_set_chained_handler(imsic_parent_irq,imsic_handle_irq);++/*+*Setupcpuhpstate(mustbedoneaftersettingimsic_parent_irq)+*+*Don'tdisableper-CPUIMSICfilewhenCPUgoesoffline+*becausethisaffectsIPIandthemasking/unmaskingof+*virtualIPIsisdoneviagenericIPI-Mux+*/+cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,"irqchip/riscv/imsic:starting",+imsic_starting_cpu,imsic_dying_cpu);++return0;+}++staticint__initimsic_early_dt_init(structdevice_node*node,structdevice_node*parent)+{+structfwnode_handle*fwnode=&node->fwnode;+intrc;++/*SetupIMSICstate*/+rc=imsic_setup_state(fwnode);+if(rc){+pr_err("%pfwP:failedtosetupstate(error%d)\n",fwnode,rc);+returnrc;+}++/*DoearlysetupofIPIs*/+rc=imsic_early_probe(fwnode);+if(rc)+returnrc;++/*EnsurethatOFplatformdevicegetsprobed*/+of_node_clear_flag(node,OF_POPULATED);+return0;+}"
#idefine UINT_32:"cpu_init,structimsic_local_priv*lpriv;+structimsic_vector*mvec;+boolis_enabled;++lpriv=per_cpu_ptr(imsic->lpriv,vec->cpu);+if(WARN_ON_ONCE(&lpriv->vectors[vec->local_id]!=vec))+return;++is_enabled=imsic_vector_isenabled(vec);+mvec=imsic_vector_get_move(vec);++seq_printf(m,"%*starget_cpu:%5u\n",ind,"",vec->cpu);+seq_printf(m,"%*starget_local_id:%5u\n",ind,"",vec->local_id);+seq_printf(m,"%*sis_reserved:%5u\n",ind,"",+(vec->local_id<=IMSIC_IPI_ID)?1:0);+seq_printf(m,"%*sis_enabled:%5u\n",ind,"",is_enabled?1:0);+seq_printf(m,"%*sis_move_pending:%5u\n",ind,"",mvec?1:0);+if(mvec){+seq_printf(m,"%*smove_cpu:%5u\n",ind,"",mvec->cpu);+seq_printf(m,"%*smove_local_id:%5u\n",ind,"",mvec->local_id);+}"

#! These are the patch files integrated in one single bool, these are actually
#! quite important for the system, this section also including the update
#! mirror for newly released patches. Please DO NOT delete any
#! of the code below. Signed Damian.

#@ Contributed with OpenEducations Ltd.

#idefine UINT_32:"patch_riscv,+&uart0{>+status="okay";>+};>diff--gita/arch/riscv/boot/dts/canaan/k230.dtsib/arch/riscv/boot/dts/canaan/k230.dtsi>newfilemode100644>index000000000000..4317bda38142>---/dev/null>+++b/arch/riscv/boot/dts/canaan/k230.dtsi>@@-0,0+1,146@@>+//SPDX-License-Identifier:GPL-2.0+>+/*>+*Copyright(C)2024YangyuChen<cyy@cyyself.name>>+*/>+>+#include<dt-bindings/interrupt-controller/irq.h>>+>+/dts-v1/;>+/{>+#address-cells=<2>;>+#size-cells=<2>;>+compatible="canaan,kendryte-k230";>+>+aliases{>+serial0=&uart0;>+};>+>+cpus{>+#address-cells=<1>;>+#size-cells=<0>;>+timebase-frequency=<27000000>;>+>+cpu@0{>+compatible="thead,c908","riscv";>+device_type="cpu";>+reg=<0>;>+riscv,isa="rv64imafdcv_zba_zbb_zbc_zbs_zicbom_svpbmt";>+riscv,isa-base="rv64i";>+riscv,isa-extensions="i","m","a","f","d","c","v","zba","zbb",>+"zbc","zbs","zicbom","zicntr","zicsr",>+"zifencei","zihpm","svpbmt";>+riscv,cbom-block-size=<64>;>+d-cache-block-size=<64>;>+d-cache-sets=<128>;>+d-cache-size=<32768>;>+i-cache-block-size=<64>;>+i-cache-sets=<128>;>+i-cache-size=<32768>;>+next-level-cache=<&l2_cache>;>+mmu-type="riscv,sv39";>+>+cpu0_intc:interrupt-controller{>+compatible="riscv,cpu-intc";>+interrupt-controller;>+#interrupt-cells=<1>;>+};>+};>+>+l2_cache:l2-cache{>+compatible="cache";>+cache-block-size=<64>;>+cache-level=<2>;>+cache-size=<262144>;>+cache-sets=<256>;>+cache-unified;>+};>+};>+>+soc{>+compatible="simple-bus";>+interrupt-parent=<&plic>;>+#address-cells=<2>;>+#size-cells=<2>;>+dma-noncoherent;>+ranges;>+>+plic:interrupt-controller@f00000000{>+compatible="thead,c900-plic";>+reg=<0xf0x000000000x00x04000000>;>+interrupts-extended=<&cpu0_intc11>,<&cpu0_intc9>;>+interrupt-controller;>+reg-names="control";>+#address-cells=<0>;>+#interrupt-cells=<2>;>+riscv,ndev=<208>;>+};>+>+clint:timer@f04000000{>+compatible="thead,c900-clint";>+reg=<0xf0x040000000x00x04000000>;>+interrupts-extended=<&cpu0_intc3>,<&cpu0_intc7>;>+};>+>+apb_clk:apb-clk-clock{OnlyMMIO-nodesgotosoc.Suchstubsgooutside.ItdoesnotlooklikeyoutestedtheDTSagainstbindings.Pleaserun`makedtbs_checkW=1`(seeDocumentation/devicetree/bindings/writing-schema.rstorhttps://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/forinstructions).>+compatible="fixed-clock";>+clock-frequency=<50000000>;>+clock-output-names="apb_clk";>+#clock-cells=<0>;>+};>+"
#idefine UINT_32:"patch_mirror,https://github.com/riscv/riscv-isa-manual"

}
