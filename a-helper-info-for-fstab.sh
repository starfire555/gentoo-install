echo ">>> Helper information that needs to be edited has been added to /etc/fstab"
cat /proc/mounts | grep btrfs  >> /etc/fstab

cat <<EOF >> /etc/fstab
UUID=       /boot           ext4            rw,relatime     0 0
UUID=       /boot/efi       vfat            rw,relatime     0 0
EOF

lsblk -o name,fstype,UUID >> /etc/fstab
echo "..........................................................."
