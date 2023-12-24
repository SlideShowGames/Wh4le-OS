!#/bin/sh
echo "checking for an internet connection..."
ping net.net -4 -U -A -D -c 6
clear
while !  ping net.net -4 -U -A -D -c 6 $1 &>/dev/null
    do echo "You need an internet connection to build Wh4leOS. - `date`"
done
echo "You are connected to the internet everything is available! - `date`"
echo "You should run this in a Docker or change your code for better results."
echo "Please add any changes you want to the kernel."
echo "1"
echo "2"
echo "3"
git clone --depth 1 https://github.com/torvalds/linux.git
cd linux/
make menuconfig
echo kernel is building
make -j 4
mkdir /whale-boot
cp arch/x86/boot/bzImage /whale-boot
cd ~
git clone --depth 1  https://git.busybox.net/busybox
cd busybox/
echo "You get to customize it!"
make menuconfig
make -j 4
mkdir /whale-boot/initramfs
make CONFIG_PREFIX=/whale-boot/initramfs install
cd /whale-boot/initramfs/
echo "Type #!/bin/sh and /bin/sh"
vim init
ls
rm linuxrc
chmod +x init
find .
find . | cpio -o -H newc > ../init.cpio
cd ~
ls
sudo pacman -S install syslinux
dd if=/dev/zero of=boot bs=1M count=50
ls
sudo pacman -S dosfstools
mkfs -t fat boot
syslinux boot
ls
mkdir m
mount boot m
cp bzImage init.cpio m
umount m
echo "You have finish creating Wh4leOS-basic go use qemu or something idk how to load this"
echo "Enjoy! Feel free to add your thoughts and ideas to https://github.com/SlideShowGames/Wh4le-OS"
