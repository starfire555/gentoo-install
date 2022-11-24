echo ">>> source /etc/profile and visually set prompt to chroot"
source /etc/profile && export PS1="(chroot) ${PS1}"
echo "..........................................................."

echo ">>> emerge-webrsync && emerge --sync"
emerge-webrsync && emerge --sync
echo "..........................................................."

echo ">>> Updating make.conf with USE flags, ACCEPT_LICENSE and VIDEO_CARDS"
cd /
echo 'USE="alsa pulseaudio branding samba"' >> etc/portage/make.conf
echo 'ACCEPT_LICENSE="-* @FREE @BINARY-REDISTRIBUTABLE microsoft-edge Microsoft-vscode all-rights-reserved ValveSteamLicense ZOOM MPEG-4"' >> etc/portage/make.conf
echo 'VIDEO_CARDS="intel"' >> etc/portage/make.conf
echo "..........................................................."

echo ">>> Updating @world"
emerge --update --deep --newuse @world
echo "..........................................................."

echo ">>> Setting timezone"
echo "Europe/London" > /etc/timezone
emerge --config sys-libs/timezone-data
echo "..........................................................."

echo ">>> Setting locale"
echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen && echo "en_GB ISO-8859-1" >> /etc/locale.gen
locale-gen
#eselect locale list
eselect locale set 6 # pick the lang.utf8
env-update && source /etc/profile && export PS1="(chroot) ${PS1}"
echo "..........................................................."

echo ">>> Getting kernel and tools"
echo 'sys-kernel/zen-sources ~amd64' >> /etc/portage/package.accept_keywords/package.accept_keywords
emerge sys-kernel/linux-firmware sys-firmware/intel-microcode sys-kernel/zen-sources sys-apps/pciutils sys-kernel/genkernel btrfs-progs
eselect kernel set 1
echo "..........................................................."

echo ""
echo "######################################################################"
echo "###                                                                ###"
echo "### Manually setup fstab and run genkernel to compile kernel       ###"
echo "### Remove subvolid from fstab to allow timeshift restore to work. ###"
echo "###                                                                ###"
echo "### genkernel all --menuconfig                                     ###"
echo "###                                                                ###"
echo "### set:     passwd                                                ###"
echo "###                                                                ###"
echo "######################################################################"
echo ""

echo ">>> Helper information that needs to be edited has been added to /etc/fstab"
cat /proc/mounts | grep btrfs  >> /etc/fstab

cat <<EOF >> /etc/fstab
UUID=       /boot           ext4            rw,relatime     0 0
UUID=       /boot/efi       vfat            rw,relatime     0 0
EOF

lsblk -o name,fstype,UUID >> /etc/fstab
echo "..........................................................."
