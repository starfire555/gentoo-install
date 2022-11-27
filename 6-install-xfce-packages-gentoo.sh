echo ">>> Setting USE flag for poppler"
echo "app-text/poppler -qt5" >> /etc/portage/package.use/package.use
echo "..........................................................."

echo ">>> Setting package USE flags"
echo "media-libs/libsndfile minimal" >> /etc/portage/package.use/package.use
echo ">=dev-libs/libdbusmenu-16.04.0-r2 gtk3" >> /etc/portage/package.use/package.use
echo "net-misc/remmina rdp ssh spice vnc" >> /etc/portage/package.use/package.use
echo "sys-libs/zlib minizip" >> /etc/portage/package.use/package.use #for vlc
echo "..........................................................."

echo ">>> Installing xfce4"
emerge --oneshot xfce-extra/xfce4-notifyd
emerge xfce-base/xfce4-meta x11-misc/lightdm xrandr

#emerge --ask x11-themes/greybird
#emerge --ask x11-themes/clearlooks-phenix x11-themes/gnome-themes-standard x11-themes/light-themes x11-themes/murrine-themes x11-themes/shiki-colors x11-themes/tactile3 x11-themes/zukini

systemctl set-default graphical
systemctl enable lightdm
echo "..........................................................."

echo ">>> Setting package ACCEPT_KEYWORDS"
echo "app-editors/vscode ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "app-backup/timeshift ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "net-im/telegram-desktop-bin ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "..........................................................."

echo ">>> Installing desktop packages"
emerge --fetchonly microsoft-edge youtube-dl simplescreenrecorder app-editors/vscode telegram-desktop-bin nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin x11-themes/papirus-icon-theme rofi vlc caffeine-ng
emerge microsoft-edge youtube-dl simplescreenrecorder app-editors/vscode telegram-desktop-bin nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin x11-themes/papirus-icon-theme rofi vlc caffeine-ng
echo "..........................................................."

echo ">>> Installing xrdp"
echo "net-misc/xrdp ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords 
echo "net-misc/xorgxrdp ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
emerge xrdp xorgxrdp

echo '#!/bin/bash' > /home/x/.xinitrc
echo 'startxfce4' >> /home/x/.xinitrc
chmod +x /home/x/.xinitrc

systemctl enable xrdp
echo "..........................................................."

echo ">>> Installing icecast, darkice, darksnow"
emerge icecast darksnow

systemctl enable icecast
echo "..........................................................."

#echo ">>> Installing zoom-bin"
#echo "net-im/zoom-bin ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
#emerge --ask --verbose zoom-bin
#echo "..........................................................."

echo ">>> Installing flatpak"
emerge flatpak
# RUN AS NORMAL USER: flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo "..........................................................."

#echo ">>> Installing zoom-flatpak"
#sudo flatpak install us.zoom.Zoom
#echo "..........................................................."
