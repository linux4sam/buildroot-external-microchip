![Microchip](docs/microchip_logo.png)

# Microchip Buildroot External

This [buildroot external][1] includes Microchip packages, patches, setup, and
configuration to work with Microchip provided software that is not included in
mainline buildroot.  This includes creating demo root filesystems. This project
provides an extension to buildroot to support these customizations outside of
the standard buildroot tree.


## Install System Dependencies

The external is tested on Ubuntu 20.04 LTS.  The following system build
dependencies are required.

    sudo apt-get install subversion build-essential bison flex gettext \
    libncurses5-dev texinfo autoconf automake libtool mercurial git-core \
    gperf gawk expat curl cvs libexpat-dev bzr unzip bc python-dev \
    wget cpio rsync xxd

In some cases, buildroot will notify that additional host dependencies are
required.  It will let you know what those are.


## Buildroot Dependencies

For AT91, this buildroot external works only with the specific buildroot-at91
version 2022.02-at91.

For PolarFire SoC, this buildroot external was tested and works with buildroot
version 2022.02.


## Build

Clone, configure, and build.  When building, use the appropriate defconfig in
the `buildroot-external-microchip/configs` directory for your board.
Here, as an example, we use `sama5d4_xplained_graphics_defconfig`.

    git clone https://github.com/linux4microchip/buildroot-external-microchip.git -b 2022.02-mchp
    git clone https://git.busybox.net/buildroot -b 2022.02
    cd buildroot
    BR2_EXTERNAL=../buildroot-external-microchip/ make sama5d4_xplained_graphics_defconfig
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

There are multiple configurations provided for PolarFire SoC. The
'icicle_defconfig' is intended for use with the Icicle kit in
Symmetric Multiprocessing (SMP) mode, and the 'icicle_amp_defconfig' is
intended for use with the Icicle kit in Asymmemtric Multiprocessing
(AMP) mode. You can specify the configuration you would like to use with
the following command:

    BR2_EXTERNAL=../buildroot-external-microchip/ make icicle_defconfig
    make

For more information on AMP please see the [AMP guide for PolarFire SoC][9].

The images generated from both of these configurations can be loaded
using the following method.

#### Create an Image for eMMC/SD Card

An image is generated in the file `sdcard.img` in the output/images
directory. The first partition of this image contains a U-Boot binary,
embedded in a Hart Software Services (HSS) payload. The second partition
contains a FAT filesystem with a U-Boot env and an ITB file containing
the kernel and the device tree. The third partition contains the file
system. This image can be written directly to the eMMC or an SD card.

If using an SD Card, you need at least 1GB. All the data on
the SD card will be lost. Find the device node name for your card.
To copy the image:

    cd output/images
    sudo dd if=sdcard.img of=/dev/sdX bs=1M

Another method, which is cross platform, to write the SD card image is to use
[USBImager][10] or [Etcher][5].

#### Documentation

For more information on using buildroot for PolarFire SoC, see
the [PolarFire SoC documentation][8].

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
