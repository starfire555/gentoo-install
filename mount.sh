### Mount ###
_boot=/dev/sda3
_root=/dev/nvme0n1p3
_efi=/dev/sda1
_target=/mnt/nvme0n1p3

clear
umount -Rq $_target/boot/efi
umount -Rq $_target/boot
umount -Rq $_target
umount -q $_efi
umount -q $_boot
umount -q $_root
rm -Rf $_target
mkdir -p $_target

echo ""
echo "............................................."
echo ""
echo "Current contents of"
echo $_target
echo ""
ls -lat $_target
echo ""
echo "............................................."

echo "Devices to be mounted:"
echo ""
echo $_root ": root"
echo $_boot ": boot"
echo $_efi ": efi"
echo ""
read -p "Press enter to proceed."


mount -o noatime,compress=lzo,space_cache=v2,subvol=@ $_root $_target
mount -o noatime,compress=lzo,space_cache=v2,subvol=@home $_root $_target/home 
mount $_boot $_target/boot
mount $_efi $_target/boot/efi

echo ""
echo "............................................."
echo ""
echo "Current contents of"
echo $_target
echo ""
ls -la $_target
echo ""
echo "............................................."

mount --types proc /proc $_target/proc && mount --rbind /sys $_target/sys && mount --make-rslave $_target/sys && mount --rbind /dev $_target/dev && mount --make-rslave $_target/dev && mount --bind /run $_target/run && mount --make-slave $_target/run
test -L /dev/shm && rm /dev/shm && mkdir /dev/shm && mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm && chmod 1777 /dev/shm

echo ""
echo "####################################"
echo "### Drives mounted successfully. ###"
echo "####################################"
echo ""
