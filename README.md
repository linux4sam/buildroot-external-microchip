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
    gperf gawk expat curl cvs libexpat-dev bzr swig


## Buildroot Dependencies

Many of the demo applications included in this external depend on Qt 5.9 or
later.  This buildroot external requires a new version of buildroot later that
2018.02-rc1.


## Build

Clone, configure, and build.  When building, use the appropriate defconfig in
the `buildroot-external-microchip/configs` directory for your board.

    git clone https://github.com/linux4sam/buildroot-external-microchip.git
    git clone https://git.buildroot.net/buildroot
    cd buildroot
    BR2_EXTERNAL=../buildroot-external-microchip/ make sama5d4_xplained_demo_defconfig
    make

The resulting bootloader, kernel, and root filesystem will be put in the
'output/images' directory.  There is also a complete sdcard.img.


## Create an SD Card

    cd output/images
    sudo dd if=sdcard.img of=/dev/sdX bs=1M


## Optionally Configure Packages and Kernel

Userspace packages and the Linux kernel, for example, can be optionally selected
and configured using Buildroot.

To configure userspace packages and build:

    make menuconfig
    make


To configure the kernel and build:

    make linux-menuconfig
    make


Create a list of software licenses used:

    make legal-info


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
