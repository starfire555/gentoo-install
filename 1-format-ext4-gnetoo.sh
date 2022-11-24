# All scripts must start in /gentoo-install

### Format and Mount ###
_boot=/dev/vda2
_root=/dev/vda3
_efi=/dev/vda1

clear
umount -Rq /mnt/gentoo/boot/efi
umount -Rq /mnt/gentoo/boot
umount -Rq /mnt/gentoo
umount -q $_efi
umount -q $_boot
umount -q $_root
rm -Rf /mnt/gentoo
mkdir -p /mnt/gentoo

echo ""
echo "............................................."
echo ""
echo "Current contents of /mnt/gentoo:"
echo ""
ls -lat /mnt/gentoo
echo ""
echo "............................................."

echo "Devices to be modified:"
echo ""
echo $_root ": root (Format to ext4. Mount to /mnt/gentoo.)"
echo $_boot ": boot (Format to ext4. Mount to /mnt/gentoo/boot.)"
echo $_efi ": efi (Format to /mnt/gentoo/efi.)"
echo ""
read -p "Press enter to proceed."


mkfs.ext4 -F $_boot
mkfs.ext4 -F $_root
mkfs.vfat $_efi
mount $_root /mnt/gentoo 
mkdir /mnt/gentoo/boot
mount $_boot /mnt/gentoo/boot
mkdir /mnt/gentoo/boot/efi
mount $_efi /mnt/gentoo/boot/efi

cp -R ../gentoo-install /mnt/gentoo/

echo ""
echo "............................................."
echo ""
echo "Current contents of /mnt/gentoo:"
echo ""
ls -la /mnt/gentoo
echo ""
echo "............................................."

echo ""
echo "##################################################"
echo "### Drives formatted and mounted successfully. ###"
echo "##################################################"
echo ""
