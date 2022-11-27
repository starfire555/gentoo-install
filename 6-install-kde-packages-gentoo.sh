echo ">>> Setting package USE flags"
echo "media-libs/libsndfile minimal" >> /etc/portage/package.use/package.use
echo ">=dev-libs/libdbusmenu-16.04.0-r2 gtk3" >> /etc/portage/package.use/package.use
echo "net-misc/remmina rdp ssh spice vnc" >> /etc/portage/package.use/package.use
echo "sys-libs/zlib minizip" >> /etc/portage/package.use/package.use #for vlc
echo "..........................................................."

echo ">>> Setting package ACCEPT_KEYWORDS"
echo "app-editors/vscodium ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "app-backup/timeshift ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "net-im/telegram-desktop-bin ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "..........................................................."

echo ">>> Installing KDE"
eselect profile set 10  #systemd desktop plasma
emerge kde-plasma/plasma-meta
emerge --update --deep --newuse @world
emerge kde-apps/kdecore-meta #lessen the MAKEOPTS value
systemctl set-default graphical
systemctl enable sddm
echo "..........................................................."

echo ">>> Installing desktop packages"
emerge --fetchonly microsoft-edge youtube-dl simplescreenrecorder app-editors/vscodium telegram-desktop-bin nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin vlc
emerge microsoft-edge youtube-dl simplescreenrecorder app-editors/vscodium telegram-desktop-bin nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin vlc
echo "..........................................................."

echo ">>> Installing xrdp"
echo net-misc/xrdp ~amd64 >> /etc/portage/package.accept_keywords/package.accept_keywords
echo net-misc/xorgxrdp ~amd64 >> /etc/portage/package.accept_keywords/package.accept_keywords

emerge xrdp xorgxrdp

systemctl enable --now xrdp

echo '#!/bin/bash' > /home/x/.xinitrc
echo 'gnome-session' >> /home/x/.xinitrc
chmod +x /home/x/.xinitrc
chown x: /home/x/.xinitrc
echo "..........................................................."
