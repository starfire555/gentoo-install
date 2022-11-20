# All scripts must start in /gentoo-install

### Mount ###
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
echo $_root ": root (btrfs with @ and @home subvolumes. Mount to /mnt/gentoo.)"
echo $_boot ": boot (Mount to /mnt/gentoo/boot.)"
echo $_efi ": efi (Mount to /mnt/gentoo/efi.)"
echo ""
read -p "Press enter to proceed."


mount -o noatime,compress=lzo,space_cache=v2,subvol=@ $_root /mnt/gentoo 
mount -o noatime,compress=lzo,space_cache=v2,subvol=@home $_root /mnt/gentoo/home 
mount $_boot /mnt/gentoo/boot
mount $_efi /mnt/gentoo/boot/efi
rm -Rf /mnt/gentoo/boot/efi/EFI/gentoo

echo ""
echo "............................................."
echo ""
echo "Current contents of /mnt/gentoo:"
echo ""
ls -la /mnt/gentoo
echo ""
echo "............................................."

echo ""
echo "####################################"
echo "### Drives mounted successfully. ###"
echo "####################################"
echo ""

mount --types proc /proc /mnt/gentoo/proc && mount --rbind /sys /mnt/gentoo/sys && mount --make-rslave /mnt/gentoo/sys && mount --rbind /dev /mnt/gentoo/dev && mount --make-rslave /mnt/gentoo/dev && mount --bind /run /mnt/gentoo/run && mount --make-slave /mnt/gentoo/run
test -L /dev/shm && rm /dev/shm && mkdir /dev/shm && mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm && chmod 1777 /dev/shm