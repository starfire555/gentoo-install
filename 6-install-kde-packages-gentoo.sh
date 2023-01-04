echo ">>> Setting package USE flags"
echo "media-libs/libsndfile minimal" >> /etc/portage/package.use/package.use
echo ">=dev-libs/libdbusmenu-16.04.0-r2 gtk3" >> /etc/portage/package.use/package.use
echo "net-misc/remmina rdp ssh spice vnc" >> /etc/portage/package.use/package.use
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
sed -i 's/MAKEOPTS="-j9"/MAKEOPTS="-j5"/g' /etc/portage/make.conf
emerge kde-apps/kdecore-meta #lessen the MAKEOPTS value
sed -i 's/MAKEOPTS="-j5"/MAKEOPTS="-j9"/g' /etc/portage/make.conf
emerge kde-misc/bismuth
systemctl set-default graphical
systemctl enable sddm

sed -i 's/autospawn = no/autospawn = yes/g' /etc/pulse/client.conf

echo "..........................................................."

echo ">>> Installing desktop packages"
emerge --fetchonly microsoft-edge youtube-dl simplescreenrecorder app-editors/vscodium telegram-desktop-bin nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin vlc
emerge microsoft-edge youtube-dl simplescreenrecorder app-editors/vscodium telegram-desktop-bin nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin vlc
echo "..........................................................."

echo ">>> Installing xrdp"
echo net-misc/xrdp ~amd64 >> /etc/portage/package.accept_keywords/package.accept_keywords
echo net-misc/xorgxrdp ~amd64 >> /etc/portage/package.accept_keywords/package.accept_keywords

sed -i 's/EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --getbinpkgonly"/#EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --getbinpkgonly"/g' /etc/portage/make.conf
emerge xrdp xorgxrdp
sed -i 's/#EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --getbinpkgonly"/EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --getbinpkgonly"/g' /etc/portage/make.conf

systemctl enable --now xrdp

echo '#!/bin/bash' > /home/x/.xinitrc
echo 'startplasma-x11' >> /home/x/.xinitrc
chmod +x /home/x/.xinitrc
chown x: /home/x/.xinitrc
echo "..........................................................."

echo ">>> Installing flatpak"
emerge flatpak
# RUN AS NORMAL USER: flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo "..........................................................."
