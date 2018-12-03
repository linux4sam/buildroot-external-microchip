![Microchip](docs/microchip_logo.png)

# Microchip SAMA5 Buildroot External

This [buildroot external][1] includes Microchip packages, patches, setup, and
configuration to create the SAMA5 demo. This project provides an extension to
buildroot to support these customizations outside of the standard buildroot
tree.


## Install System Dependencies

The external is tested on Ubuntu 16.04 LTS.  The following system build
dependencies are required.

    sudo apt-get install subversion build-essential bison flex gettext \
    libncurses5-dev texinfo autoconf automake libtool mercurial git-core \
    gperf gawk expat curl cvs libexpat-dev bzr unzip bc python-dev mtools

In some cases, buildroot will notify that additional host dependencies are
required.  It will let you know what those are.


## Buildroot Dependencies

Many of the demo applications included in this external depend on Qt 5.9 or
later.  This buildroot external requires a new version of buildroot equal to or
greater than 2018.02-at91.


## Build

Clone, configure, and build.  When building, use the appropriate defconfig in
the `buildroot-external-microchip/configs` directory for your board.

    git clone https://github.com/linux4sam/buildroot-external-microchip.git
    git clone https://github.com/linux4sam/buildroot-at91.git -b 2018.02-at91
    cd buildroot-at91
    BR2_EXTERNAL=../buildroot-external-microchip/ make sama5d4_xplained_demo_defconfig
    make

The resulting bootloader, kernel, and root filesystem will be put in the
'output/images' directory.  There is also a complete `sdcard.img`.

### Optionally Configure Packages and Kernel

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


## Create an SD Card

A SD card image is generated in the file `sdcard.img`.  The first partition of
this image contains a FAT filesystem with at91bootstrap, u-boot, a u-boot env,
DTB files, and kernel. The second partition contains the root filesystem. This
image can be written directly to an SD card.

You need at least a 1GB SD card. All the data on the SD card will be
lost. Find the device node name for your card.  To copy the image on the SD
card:

    cd output/images
    sudo dd if=sdcard.img of=/dev/sdX bs=1M

Another method, which is cross platform, to write the SD card image is to use
[Etcher][5].

For more information on how these components are generated and what makes up a
bootable SD card, see [SDCardBootNotice][4].

## Configuring the LCD Display

You may have to manually set the DTB file to be inline with the actual display
you are using.  To do this, as the board is booting hold down the enter key in
the debug serial console until you get to the u-boot command prompt.  Use the
following commands to set and save the `dtb_name` variable.

    => setenv dtb_name at91-sama5d2_xplained_pda7.dtb
    => saveenv
    => boot


## Documentation

For more information on using and updating buildroot, see the [buildroot
documentation][3].


## License

This project is licensed under the [GPLv2][2] or later with exceptions.  See the
`COPYING` file for more information.  Buildroot is licensed under the [GPLv2][2]
or later with exceptions. See the `COPYING` file in that project for more
information.


[1]: https://buildroot.org/downloads/manual/manual.html#outside-br-custom
[2]: https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
[3]: https://buildroot.org/docs.html
[4]: http://www.at91.com/linux4sam/bin/view/Linux4SAM/SDCardBootNotice
[5]: https://etcher.io/
