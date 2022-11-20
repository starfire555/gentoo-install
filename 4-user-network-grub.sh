echo ">>> adding user x"
useradd -m -G users,wheel,video -s /bin/bash x
echo "..........................................................."

echo ">>> Type password for user x"
passwd x
echo "..........................................................."

echo ">>> removing /stage3-*.tar.*"
rm /stage3-*.tar.*
echo "..........................................................."

echo ">>> installing grub efibootmgr networkmanager"
emerge grub efibootmgr networkmanager
echo "..........................................................."

echo ">>> grub-install, grub-mkconfig"
grub-install --target=x86_64-efi --efi-directory=/boot/efi  --bootloader-id=gentoo
grub-mkconfig -o /boot/grub/grub.cfg
echo "..........................................................."

echo ""
echo "################################################################"
echo "###                                                          ###"
echo "### run efibootmgr commands if necessary                     ###"
echo "###                                                          ###"
echo "################################################################"
echo ""


