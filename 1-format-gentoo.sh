# All scripts must start in /gentoo-install

### Format and Mount ###
_boot=/dev/sda2
_root=/dev/sda3
_efi=/dev/sda1

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
echo $_root ": root (Format to btrfs with @ and @home subvolumes. Mount to /mnt/gentoo.)"
echo $_boot ": boot (Format to ext4. Mount to /mnt/gentoo/boot.)"
echo $_efi ": efi (Mount to /mnt/gentoo/efi.)"
echo ""
read -p "Press enter to proceed."


mkfs.ext4 -F $_boot
mkfs.btrfs -f $_root
mount $_root /mnt/gentoo
btrfs su cr /mnt/gentoo/@
btrfs su cr /mnt/gentoo/@home
#btrfs su cr /mnt/gentoo/@snapshots
#btrfs su cr /mnt/gentoo/@var_log 
umount /mnt/gentoo

mount -o noatime,compress=lzo,space_cache=v2,subvol=@ $_root /mnt/gentoo 
mkdir -p /mnt/gentoo/{boot,home}
#mkdir -p /mnt/gentoo/{.snapshots,var_log}
mount -o noatime,compress=lzo,space_cache=v2,subvol=@home $_root /mnt/gentoo/home 
#mount -o noatime,compress=lzo,space_cache=v2,subvol=@snapshots $_root /mnt/gentoo/.snapshots
#mount -o noatime,compress=lzo,space_cache=v2,subvol=@var_log $_root /mnt/gentoo/var_log
mount $_boot /mnt/gentoo/boot
mkdir /mnt/gentoo/boot/efi
mount $_efi /mnt/gentoo/boot/efi
rm -Rf /mnt/gentoo/boot/efi/EFI/gentoo

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
