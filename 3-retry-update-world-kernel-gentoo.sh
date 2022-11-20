#echo ">>> emerge --sync"
#emerge --sync
#echo "..........................................................."

echo ">>> Updating @world"
emerge --verbose --ask --update --deep --newuse @world
echo "..........................................................."

echo ">>> Getting kernel and tools"
echo 'sys-kernel/zen-sources ~amd64' >> /etc/portage/package.accept_keywords/package.accept_keywords
emerge sys-kernel/linux-firmware sys-firmware/intel-microcode sys-kernel/zen-sources sys-apps/pciutils sys-kernel/genkernel btrfs-progs
eselect kernel set 1
echo "..........................................................."

echo ""
echo "################################################################"
echo "###                                                          ###"
echo "### manually setup fstab and run genkernel to compile kernel ###"
echo "###                                                          ###"
echo "### genkernel all --menuconfig                               ###"
echo "###                                                          ###"
echo "### set:     passwd                                          ###"
echo "###                                                          ###"
echo "################################################################"
echo ""

echo ">>> Helper information that needs to be edited has been added to /etc/fstab"
cat /proc/mounts | grep btrfs  >> /etc/fstab

cat << EOF >> /etc/fstab
UUID=       /boot           ext4            rw,relatime     0 0
UUID=       /boot/efi       vfat            rw,relatime     0 0
EOF

lsblk -o name,fstype,UUID >> /etc/fstab
echo "..........................................................."