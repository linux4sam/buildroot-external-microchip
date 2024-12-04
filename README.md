![Microchip](docs/microchip_logo.png)

# Microchip Buildroot External

This [buildroot external][1] includes Microchip packages, patches, setup, and
configuration to work with Microchip provided software that is not included in
mainline buildroot.  This includes creating demo root filesystems. This project
provides an extension to buildroot to support these customizations outside of
the standard buildroot tree.


## Install System Dependencies

The external is tested on Ubuntu 22.04 LTS.  The following system build
dependencies are required.

    sudo apt-get install subversion build-essential bison flex gettext \
    libncurses5-dev texinfo autoconf automake libtool mercurial git-core \
    gperf gawk expat curl cvs libexpat-dev bzr unzip bc python3-dev \
    wget cpio rsync xxd bmap-tools

In some cases, buildroot will notify that additional host dependencies are
required.  It will let you know what those are.


## Buildroot Dependencies

For AT91, this buildroot external works only with the specific buildroot-mchp
version 2024.02-mchp.

For PolarFire SoC, this buildroot external was tested and works with buildroot
version 2024.02.

For PIC64GX, this buildroot external was tested and works with buildroot
version 2024.02.

## Build

Clone, configure, and build.  When building, use the appropriate defconfig in
the `buildroot-external-microchip/configs` directory for your board.

For AT91 configurations, as an example, we use `sama5d4_xplained_graphics_defconfig`.

    git clone https://github.com/linux4microchip/buildroot-external-microchip.git
    git clone https://github.com/linux4microchip/buildroot-mchp.git -b 2024.02-mchp
    cd buildroot-mchp
    export BR2_EXTERNAL=../buildroot-external-microchip/
    make sama5d4_xplained_graphics_defconfig
    make

For PolarFire SoC configurations, as an example, we use `icicle_defconfig`.

    git clone https://github.com/linux4microchip/buildroot-external-microchip.git
    git clone https://git.busybox.net/buildroot -b 2024.02
    cd buildroot
    BR2_EXTERNAL=../buildroot-external-microchip/ make icicle_defconfig
    make

The resulting bootloader, kernel, and root filesystem will be put in the
'output/images' directory.  There is also a complete `sdcard.img`.

#### Optionally Configure Packages and Kernel

Userspace packages and the Linux kernel, for example, can be optionally selected
and configured using buildroot.

To configure userspace packages and build:

    make menuconfig
    make


To configure the kernel and build:

    make linux-menuconfig
    make


Create a list of software licenses used:

    make legal-info

## Supported Families

This buildroot external repository supports several board families from
Microchip Technology, Inc.

### AT91 boards

AT91 boards are based on AT91 SAM architecture, based on ARM processors.
These include boards based on ARMv5 and ARMv7, on cores like the ARM926 and
ARM Cortex-A5 or ARM Cortex-A7.

#### Create an SD Card

A SD card image is generated in the file `sdcard.img`.  The first partition of
this image contains a FAT filesystem with at91bootstrap, u-boot, a u-boot env,
ITB file, which contains kernel and device tree. The second partition contains
the root filesystem. This image can be written directly to an SD card.

You need at least a 1GB SD card. All the data on the SD card will be
lost. Find the device node name for your card.  To copy the image on the SD
card:

    cd output/images
    sudo dd if=sdcard.img of=/dev/sdX bs=1M

Another method, which is cross platform, to write the SD card image is to use
[Etcher][5].

For more information on how these components are generated and what makes up a
bootable SD card, see [SDCardBootNotice][4].

#### Configuring the LCD Display

U-boot will automatically detect your connected display and load the
corresponding DT-overlay for your screen.
For more information, adjustments of this behavior, check the information
on the [at91Wiki][6].

#### Kernel and Device Tree Blob packaging

Linux Kernel and the Device Tree Blob will be included in a single file
named FIT Image (*.itb files). U-boot needs to boot a FIT Image, unlike before,
when it was loading two separate files (zImage and dtb).
For more information, check the information on the [at91Wiki][7].

#### Documentation

For more information on using and updating buildroot-at91, see the [buildroot
documentation][3].

### PolarFire SoC

There are several configurations available for PolarFire SoC Icicle Kit.
To generate an image, choose any of the Icicle Kit defconfigs provided
in the configs directory and follow the corresponding instructions.

For example, to build an image suitable for programming to the SD/eMMC
for the Icicle Kit:

    BR2_EXTERNAL=../buildroot-external-microchip/ make icicle_defconfig
    make

The `icicle_amp_defconfig` can be used to build the Icicle Kit with
Asymmetric Multiprocessing (AMP) support. For more information on AMP,
please see the [AMP guide for PolarFire SoC][9].

Please note that this buildroot external is intended for use with the latest
version of the [Icicle Kit Reference Design][13]. For reference design versions
prior to v2022.10, please use the [linux4microchip+fpga-2022.11 tag][14] of this
repository.

#### Create an Image for eMMC/SD Card

An image is generated in the file `sdcard.img` in the output/images
directory. The first partition of this image contains a U-Boot binary,
embedded in a Hart Software Services (HSS) payload. The second partition
contains a FAT filesystem with a U-Boot env and an ITB file containing
the kernel and the device tree. The third partition contains the file
system. This image can be written directly to the eMMC or an SD card.

The `icicle_defconfig` generates an image containing a root filesystem, whereas
the `icicle_initramfs_defconfig` generates an image with a RAM-based
filesystem.

There are several ways to copy the image to the eMMC or an SD card:

a) Copy the image to the eMMC or SD card using the standard Unix `dd` tool:

Find the device node name for your card and then copy the image as shown below:

    cd output/images
    sudo dd if=sdcard.img of=/dev/sdX bs=1M

b) Copy the image to the eMMC or SD card using `bmaptool` (recommended)

This is a generic tool for creating a block map (bmap) for a file and copying
files using this block map. Raw system image files can be flashed a lot faster
with bmaptool than with traditional tools, like "dd".

    cd output/images
    sudo bmaptool copy sdcard.img /dev/sdX

If using an SD Card, you need at least 8GB. All the data on the SD card
will be lost.

Another method, which is cross platform, to write the image is to use
[USBImager][10] or [Etcher][5].

For instructions on how to transfer the image to the eMMC/SD, please refer to
the *Programming the Linux image* section of our [guide on updating PolarFire SoC dev kits][12].

#### Create an Image for an external QSPI Flash memory

The `icicle_nor_defconfig` and `icicle_nand_defconfig` defconfigs provide
support for building images suitable for programming to the oficially supported
QSPI flash memories.

An image with the name `nor.img` or `nand.img `is generated in the output/images directory.

For more information on how to enable QSPI support on PolarFire SoC, please
refer to the [Booting from QSPI][11] documentation.

Note: The nand.img image generated triggers a "free space fixup" procedure in
the kernel the very first time the file system is mounted. Therefore, the first
mount might take additional time to complete. This is a one-time harmless procedure
that involves finding all empty pages in the UBIFS file system and re-erasing them. This is useful
when a non-UBIFS-aware programmer is used to flash the image to a NAND memory.

For instructions on how to transfer the image to the external QSPI flash memory
refer to the *External QSPI Flash Memory* section of the [updating PolarFire SoC dev kits][12]
documentation.

#### Documentation

For more information on using buildroot for PolarFire SoC, see
the [PolarFire SoC documentation][8].

### PIC64GX

There are several configurations available for PIC64GX Curiosity Kit.
To generate an image, choose any of the PIC64GX Curiosity Kit defconfigs
provided in the configs directory and follow the corresponding instructions.

For example, to build an image suitable for programming to the SD for the
PIC64GX Curiosity Kit:

    BR2_EXTERNAL=../buildroot-external-microchip/ make pic64gx_curiosity_kit_defconfig
    make

#### Create an Image for SD Card

An image is generated in the file `sdcard.img` in the output/images
directory. The first partition of this image contains a U-Boot binary,
embedded in a Hart Software Services (HSS) payload. The second partition
contains a FAT filesystem with a U-Boot env and an ITB file containing
the kernel and the device tree. The third partition contains the file
system. This image can be written directly to the SD card.

The `pic64gx_curiosity_kit_defconfig` generates an image containing a root filesystem, whereas
the `pic64gx_curiosity_kit_initramfs_defconfig` generates an image with a RAM-based
filesystem.

There are several ways to copy the image to an SD card:

a) Copy the image to the SD card using the standard Unix `dd` tool:

Find the device node name for your card and then copy the image as shown below:

    cd output/images
    sudo dd if=sdcard.img of=/dev/sdX bs=1M

b) Copy the image to the SD card using `bmaptool` (recommended)

This is a generic tool for creating a block map (bmap) for a file and copying
files using this block map. Raw system image files can be flashed a lot faster
with bmaptool than with traditional tools, like "dd".

    cd output/images
    sudo bmaptool copy sdcard.img /dev/sdX

For your SD Card, you need at least 8GB. All the data on the SD card will be lost.

## License

This project is licensed under the [GPLv2][2] or later with exceptions.  See the
`COPYING` file for more information.  Buildroot is licensed under the [GPLv2][2]
or later with exceptions. See the `COPYING` file in that project for more
information.


[1]: https://buildroot.org/downloads/manual/manual.html#outside-br-custom
[2]: https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
[3]: https://buildroot.org/docs.html
[4]: https://www.linux4sam.org/bin/view/Linux4SAM/SDCardBootNotice
[5]: https://etcher.io/
[6]: https://www.linux4sam.org/bin/view/Linux4SAM/PDADetectionAtBoot
[7]: https://www.linux4sam.org/bin/view/Linux4SAM/UsingFITwithOverlays
[8]: https://github.com/polarfire-soc/polarfire-soc-documentation
[9]: https://mi-v-ecosystem.github.io/redirects/asymmetric-multiprocessing_amp
[10]: https://bztsrc.gitlab.io/usbimager/
[11]: https://mi-v-ecosystem.github.io/redirects/booting-from-qspi_booting-from-qspi
[12]: https://mi-v-ecosystem.github.io/redirects/boards-mpfs-generic-updating-mpfs-kit
[13]: https://github.com/polarfire-soc/icicle-kit-reference-design/releases
[14]: https://github.com/linux4microchip/buildroot-external-microchip/releases/tag/linux4microchip%2Bfpga-2022.11
