.. _docs/totalcompute/tc2/release_notes:

Release notes - TC2-2023.08.15
==============================

.. contents::

Release tag
-----------
The manifest tag for this release is ``TC2-2023.08.15``.

Components
----------
The following is a summary of the key software features of the release:
 - BSP build supporting Android, Buildroot and Debian distros;
 - Trusted firmware-A for secure boot;
 - U-Boot bootloader;
 - Hafnium for S-EL2 Secure Partition Manager core;
 - OP-TEE for Trusted Execution Environment (TEE) in Buildroot;
 - Trusted Services (Crypto, Internal Trusted Storage and Firmware Update) in Buildroot;
 - Trusty for Trusted Execution Environment (TEE) with FF-A messaging in Android;
 - System control processor(SCP) firmware for programming the interconnect, power control etc;
 - Runtime Security Subsystem (RSS) firmware for providing HW RoT;
 - TensorFlow Lite Machine Learning.

Hardware Features
-----------------
 - Booker aka CoreLink CI-700 with Memory Tagging Unit(MTU) support driver in SCP firmware;
 - GIC Clayton Initialization in Trusted Firmware-A;
 - Mali-G720 GPU;
 - Mali-D71 DPU and virtual encoder support for display on Linux;
 - MHUv2 Driver for SCP and AP communication;
 - UARTs, Timers, Flash, PIK, Clock drivers;
 - PL180 MMC;
 - DynamIQ Shared Unit (DSU) with 8 cores. 1 Cortex X4 + 3 Cortex A720 + 4 Cortex A520 cores configuration;
 - RSS based on Cortex M55;
 - SCP based on Cortex M3.

Software Features
-----------------
 - Buildroot distribution support;
 - Debian 12 (aka Bookworm);
 - Android 13 support;
 - Android Common Kernel 5.15.41;
 - Android Hardware Rendering with Mali-G720 GPU - DDK r41p0_01eac0 (source code) or prebuilt binaries;
 - Android Software rendering with DRM Hardware Composer offloading composition to Mali D71 DPU;
 - KVM default mode of operation is set to ``protected`` by default, thus effectively enabling pKVM on the system. This is a nVHE based mode with kernel running at EL1;
 - Microdroid based pVM support in Android;
 - GPU and DPU support for S1 translation with SMMU-600;
 - Maximum Power Mitigation Mechanism (MPMM) support;
 - GPU DVFS/Idle power states support;
 - Support for MPAM (more info available at `link <https://developer.arm.com/documentation/107768/0100/Arm-Memory-System-Resource-Partitioning-and-Monitoring--MPAM--Extension>`__);
 - Support for EAS (more info available at `link <https://community.arm.com/oss-platforms/w/docs/530/energy-aware-scheduling-eas>`__);
 - Trusted Firmware-A v2.9;
 - Hafnium v2.9;
 - OP-TEE 3.22.0;
 - Trusty with FF-A messaging - FF-A v1.0;
 - CI700-PMU enabled for profiling;
 - Support for secure boot based on TBBR specification (more info available at `link <https://developer.arm.com/documentation/den0006/latest>`__);
 - System Control Processor (SCP) firmware v2.12;
 - Runtime Security Subsystem (RSS) firmware v1.8.0;
 - U-Boot bootloader v2023.04;
 - Power management features: cpufreq and cpuidle;
 - SCMI (System Control and Management Interface) support;
 - Virtio to mount the android image in the host machine as a storage device in the FVP;
 - Verified u-boot for authenticating fit image (containing kernel + ramdisk) during Buildroot boot;
 - Android Verified Boot (AVB) for authenticating boot and system image during Android boot;
 - Hafnium as Secure Partition Manager (SPM) at S-EL2;
 - OP-TEE as Secure Partition at S-EL1, managed by S-EL2 SPMC (Hafnium);
 - Arm FF-A driver and FF-A Transport support for OP-TEE driver in Android Common Kernel;
 - OP-TEE Support in Buildroot distribution. This includes OP-TEE client and OP-TEE test suite;
 - Trusted Services (Crypto, Internal Trusted Storage and Firmware Update) running at S-EL0;
 - Trusted Services test suite added to Buildroot distribution;
 - Tracing support, based on ETE and TRBE v1.1 in TF-A, kernel and ``simpleperf``. Traces can be captured with ``simpleperf``.
 - Firmware update support.

Platform Support
----------------
 - This software release is tested on TC2 Fast Model platform (FVP) version 11.22.34.

Tools Support
-------------
 - This software release extends docker support to Debian distro (making it supported to all TC build variants).

Known issues or Limitations
---------------------------
#. To avoid the waiting time experienced during U-Boot boot time, the user may interrupt the auto-boot process when presented with the message ``Hit any key to stop autoboot: X`` by pressing the ``ENTER`` key and, on the presented command prompt, type ``boot`` followed by ``ENTER`` key to confirm command to immediately boot the distro kernel image. Although the configured delay is shown as 1-3 seconds, it will take considerably more time to boot (approximately 15 seconds) due to the time difference in the CPU frequency and the FVP operating frequency;
#. Ubuntu 22.04 is not supported in this release;
#. SVE2 (Scalable Vector Extension) feature is not supported with this release;
#. For Android builds which do use the TAP network interface, the default browser available in Android (``webview_shell``) is not able to open HTTPS urls. Interested users can attempt to circumvent this limitation by getting the ARM64 specific APK package for other browsers (e.g. Mozilla Firefox), install it using ADB, and use it to browse HTTPS urls;
#. Android builds with software or hardware rendering support do not properly initialiase the KVM during boot and will show a kernel warning dump during boot, similar to the following excerpt:

    ::

	(...)
	[    0.079881][    T1] kvm [1]: IPA Size Limit: 40 bits
	[    0.080735][    T1] ------------[ cut here ]------------
	[    0.080816][    T1] WARNING: CPU: 9 PID: 1 at arch/arm64/kvm/arm.c:1675 cpu_hyp_init_context+0x154/0x160
	[    0.080965][    T1] Modules linked in:
	[    0.081024][    T1] CPU: 9 PID: 1 Comm: swapper/0 Tainted: G S                5.15.41-g7ed92d32a9ad #1
	[    0.081165][    T1] Hardware name: arm,tc (DT)
	[    0.081233][    T1] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	[    0.081350][    T1] pc : cpu_hyp_init_context+0x154/0x160
	[    0.081433][    T1] lr : cpu_hyp_init_context+0xec/0x160
	[    0.081515][    T1] sp : ffff80000a5cbc90
	[    0.081576][    T1] x29: ffff80000a5cbc90 x28: 0000000000000000 x27: 000000000000000d
	[    0.081695][    T1] x26: ffff800009f6d100 x25: 0000000000000004 x24: ffff80000a49a000
	[    0.081815][    T1] x23: ffff8000098fd000 x22: 0000000000000030 x21: ffff80000a49b000
	[    0.081934][    T1] x20: ffff80000a49b000 x19: ffff00000216d100 x18: 0000000000000000
	[    0.082053][    T1] x17: 6120737265746e75 x16: 0000000000000008 x15: 0000000000000000
	[    0.082172][    T1] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000001
	[    0.082292][    T1] x11: 0000000000000001 x10: 000000000015f258 x9 : ffff80000a2c5920
	[    0.02411][    T1] x8 : ffff80000a5cbbd0 x7 : 0000000000000000 x6 : 00000081eefff000
	[    0.082530][    T1] x5 : ffff80000a5cbbd0 x4 : 00000081eefff000 x3 : 00000000c6000000
	[    0.082650][    T1] x2 : 0001000000000000 x1 : 0000008081b4d080 x0 : ffffffffffffffff
	[    0.082769][    T1] Call trace:
	[    0.082818][    T1]  cpu_hyp_init_context+0x154/0x160
	[    0.082895][    T1]  kvm_arch_init+0xc58/0xea0
	[    0.082965][    T1]  kvm_init+0x3c/0x350
	[    0.083027][    T1]  arm_init+0x20/0x30
	[    0.083086][    T1]  do_one_initcall+0x44/0x290
	[    0.083156][    T1]  kernel_init_freeable+0x250/0x2d4
	[    0.083236][    T1]  kernel_init+0x28/0x130
	[    0.083301][    T1]  ret_from_fork+0x10/0x20
	[    0.083368][    T1] ---[ end trace e2459f77e453d262 ]---
	[    0.083451][    T1] ------------[ cut here ]------------
	[    0.083532][    T1] WARNING: CPU: 9 PID: 1 at arch/arm64/kvm/arm.c:1972 kvm_arch_init+0xd34/0xea0
	[    0.083667][    T1] Modules linked in:
	[    0.083725][    T1] CPU: 9 PID: 1 Comm: swapper/0 Tainted: G S      W         5.15.41-g7ed92d32a9ad #1
	[    0.083866][    T1] Hardware name: arm,tc (DT)
	[    0.083934][    T1] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	[    0.084050][    T1] pc : kvm_arch_init+0xd34/0xea0
	[    0.084124][    T1] lr : kvm_arch_init+0xca4/0xea0
	[    0.084198][    T1] sp : ffff80000a5cbca0
	[    0.084259][    T1] x29: ffff80000a5cbca0 x28: 0000000000000000 x27: 000000000000000d
	[    0.084379][    T1] x26: ffff800009f6d100 x25: 0000000000000004 x24: ffff80000a49a000
	[    0.084498][    T1] x23: ffff8000098fd000 x22: 0000000000000030 x21: 00000081ec200000
	[    0.084617][    T1] x20: 0000000002e00000 x19: 00000081ec200000 x18: 0000000000000000
	[    0.084736][    T1] x17: 6120737265746e75 x16: 0000000000000008 x15: 0000000000000000
	[    0.084855][    T1] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000001
	[    0.084975][    T1] x11: 0000000000000001 x10: 000000000015f258 x9 : ffff80000a2c5920
	[    0.085094][    T1] x8 : ffff80000a5cbbd0 x7 : 0000000000000000 x6 : 0000000000000000
	[    0.085213][    T1] x5 : 0000000000000030 x4 : 0000f1000216d100 x3 : 00000000c6000000
	[    0.085333][    T1] x2 : 0000000002e00000 x1 : 00000081ec200000 x0 : ffffffffffffffff
	[    0.085452][    T1] Call trace:
	[    0.085500][    T1]  kvm_arch_init+0xd34/0xea0
	[    0.085569][    T1]  kvm_init+0x3c/0x350
	[    0.085629][    T1]  arm_init+0x20/0x30
	[    0.085689][    T1]  do_one_initcall+0x44/0x290
	[    0.085758][   T1]  kernel_init_freeable+0x250/0x2d4
	[    0.085836][    T1]  kernel_init+0x28/0x130
	[    0.085900][    T1]  ret_from_fork+0x10/0x20
	[    0.085965][    T1] ---[ end trace e2459f77e453d263 ]---
	[    0.086052][    T1] ------------[ cut here ]------------
	[    0.086133][    T1] WARNING: CPU: 9 PID: 1 at arch/arm64/kvm/arm.c:1726 cpu_set_hyp_vector+0xb0/0xd4
	[    0.086272][    T1] Modules linked in:
	[    0.086330][    T1] CPU: 9 PID: 1 Comm: swapper/0 Tainted: G S      W         5.15.41-g7ed92d32a9ad #1
	[    0.086471][    T1] Hardware name: arm,tc (DT)
	[    0.086538][    T1] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	[    0.086655][    T1] pc : cpu_set_hyp_vector+0xb0/0xd4
	[    0.086733][    T1] lr : cpu_set_hyp_vector+0xa8/0xd4
	[    0.086810][    T1] sp : ffff80000a5cbc90
	[    0.086871][    T1] x29: ffff80000a5cbc90 x28: 0000000000000000 x27: 000000000000000d
	[    0.086991][    T1] x26: ffff800009f6d100 x25: 0000000000000004 x24: ffff80000a49a000
	[    0.087110][    T1] x23: ffff8000098fd000 x22: 0000000000000030 x21: 00000081ec200000
	[    0.087229][    T1] x20: 0000000002e00000 x19: 00000081ec200000 x18: 0000000000000000
	[    0.087348][    T1] x17: 6120737265746e75 x16: 000000000000000a x15: 0000000000000000
	[    0.087468][    T1] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000001
	[    0.087587][    T1] x11: 0000000000000001 x10: 000000000015f258 x9 : ffff80000a2c5920
	[    0.087706][    T1] x8 : ffff80000a5cbbd0 x7 : 0000000000000000 x6 : 0000000000000000
	[    0.087825][    T1] x5 : 0000000000000030 x4 : 0000f1000216d100 x3 : 00000000c6000000
	[    0.087945][    T1] x2 : ffff80000a5cbc90 x1 : 0000000000000000 x0 : ffffffffffffffff
	[    0.088064][    T1] Call trace:
	[    0.088112][    T1]  cpu_set_hyp_vector+0xb0/0xd4
	[    0.088184][    T1]  kvm_arch_init+0xcb4/0xea0
	[    0.088253][    T1]  kvm_init+0x3c/0x350
	[    0.088314][    T1]  arm_init+0x20/0x30
	[    0.088373][    T1]  do_one_initcall+0x44/0x290
	[    0.088443][    T1]  kernel_init_freeable+0x250/0x2d4
	[    0.088520][    T1]  kernel_init+0x28/0x130
	[    0.088585][    T1]  ret_from_fork+0x10/0x20
	[    0.088650][    T1] ---[ end trace e2459f77e453d264 ]---
	[    0.088734][    T1] ------------[ cut here ]------------
	[    0.088815][    T1] WARNING: CPU: 9 PID: 1 at arch/arm64/kvm/debug.c:68 kvm_arm_init_debug+0x5c/0x64
	[    0.088956][    T1] Modules linked in:
	[    0.089013][    T1] CPU: 9 PID: 1 omm: swapper/0 Tainted: G S      W         5.15.41-g7ed92d32a9ad #1
	[    0.089154][    T1] Hardware name: arm,tc (DT)
	[    0.089222][    T1] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	[    0.089338][    T1] pc : kvm_arm_init_debug+0x5c/0x64
	[    0.089416][    T1] lr : kvm_arm_init_debug+0x24/0x64
	[    0.089493][    T1] sp : ffff80000a5cbc90
	[    0.089554][    T1] x29: ffff80000a5cbc90 x28: 00000000ec200000 x27: 000000000000000d
	[    0.089673][    T1] x26: ffff800009f6d100 x25: 0000000000000004 x24: ffff80000a49a000
	[    0.089793][    T1] x23: ffff8000098fd000 x22: 0000000000000030 x21: 00000081ec200000
	[    0.089912][    T1] x20: 0000000002e00000 x19: 00000081ec200000 x18: 0000000000000000
	[    0.090031][    T1] x17: 6120737265746e75 x16: 000000000000000a x15: 0000000000000000
	[    0.090150][    T1] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000001
	[    0.090270][    T1] x11: 0000000000000001 x10: 000000000015f258 x9 : ffff80000a2c5920
	[    0.090389][    T1] x8 : ffff80000a5cbbd0 x7 : 0000000000000000 x6 : 0000000000000000
	[    0.090508][    T1] x5 : 0000000000000030 x4 : 0000f1000216d100 x3 : 00000000c6000000
	[    0.090627][    T1] x2 : ffff80000a5cbc90 x1 : 0000000000000000 x0 : ffffffffffffffff
	[    0.090746][    T1] Call trace:
	[    0.090795][    T1]  kvm_arm_init_debug+0x5c/0x64
	[    0.090867][    T1]  kvm_arch_init+0xcbc/0xea0
	[    0.090936][    T1]  kvm_init+0x3c/0x350
	[    0.090997][    T1]  arm_init+0x20/0x30
	[    0.091056][    T1]  do_one_initcall+0x44/0x290
	[    0.091125][    T1]  kernel_init_freeable+0x250/0x2d4
	[    0.091203][    T1]  kernel_init+0x28/0x130
	[    0.091267][    T1]  ret_from_fork+0x10/0x20
	[    0.091333][    T1] ---[ end trace e2459f77e453d265 ]---
	[    0.091417][    T1] kvm [1]: Failed to init hyp memory protection
	[    0.091657][    T1] kvm [1]: error initializing Hyp mode: -333447168
	(...)

#. Android builds with software or hardware rendering support will present an SMC blocked call message on ``FVP terminal_uart1_ap`` window, similar to the following excerpt:

    ::

	(...)
	NOTICE:  Booting Trusted Firmware
	NOTICE:  BL1: v2.9(debug):v2.9.0-291-g68e93909f
	NOTICE:  BL1: Built : 13:08:36, Aug 23 2023
	NOTICE:  BL1: Booting BL2
	NOTICE:  BL2: v2.9(debug):v2.9.0-291-g68e93909f
	NOTICE:  BL2: Built : 13:08:40, Aug 23 2023
	NOTICE:  BL1: Booting BL31
	NOTICE:  BL31: v2.9(debug):v2.9.0-291-g68e93909f
	NOTICE:  BL31: Built : 13:08:48, Aug 23 2023
	INFO: Initializing Hafnium (SPMC)
	INFO: text: 0xfd000000 - 0xfd027000
	INFO: rodata: 0xfd027000 - 0xfd02e000
	INFO: data: 0xfd02e000 - 0xfd117000
	INFO: stacks: 0xfd120000 - 0xfd130000
	INFO: Supported bits in physical address: 40
	INFO: Stage 2 has 3 page table levels with 2 pages at the root.
	INFO: Stage 1 has 4 page table levels with 1 pages at the root.
	INFO: Memory range:  0xf9000000 - 0xfeffffff
	INFO: Loading VM id 0x8001: trusty.
	INFO: Loaded with 8 vCPUs, entry at 0xf901c000.
	INFO: Hafnium initialisation completed
	NOTICE: SMC 0xbd000000 attempted from VM 0x8001, blocked=1
	NOTICE: SMC 0xbd000000 attempted from VM 0x8001, blocked=1
	NOTICE: SMC 0xbd000000 attempted from VM 0x8001, blocked=1
	(...OUTPUT TRUNCATED TO SAVE SPACE AND REPETITION...)
	NOTICE: SMC 0xbd000000 attempted from VM 0x8001, blocked=1
	NOTICE: SMC 0xbd000000 attempted from VM 0x8001, blocked=1
	NOTICE: SMC 0xbd000000 attempted from VM 0x8001, blocked=1
	(...)

#. The Android PAUTH sanity test may sometimes report inconsistent failing test results (this behaviour is currently under investigation). If experiencing this situation, please repeat the test a few times to validate the feature.

Support
-------
For support email:  support@arm.com.


--------------

*Copyright (c) 2022-2023, Arm Limited. All rights reserved.*
