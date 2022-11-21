echo ">>> Setting USE flag for poppler"
echo "app-text/poppler -qt5" >> /etc/portage/package.use/package.use
echo "..........................................................."

echo ">>> Installing xfce4"
emerge --ask --oneshot xfce-extra/xfce4-notifyd
emerge --ask xfce-base/xfce4-meta x11-misc/lightdm

#emerge --ask x11-themes/greybird
#emerge --ask x11-themes/clearlooks-phenix x11-themes/gnome-themes-standard x11-themes/light-themes x11-themes/murrine-themes x11-themes/shiki-colors x11-themes/tactile3 x11-themes/zukini
emerge --ask media-sound/pavucontrol

systemctl set-default graphical
systemctl enable lightdm
echo "..........................................................."

echo ">>> Installing desktop packages"
emerge --ask --verbose microsoft-edge youtube-dl simplescreenrecorder app-editors/vscode telegram-desktop-bin nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin
echo "..........................................................."

echo ">>> Installing xrdp"
echo "net-misc/xrdp ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords 
echo "net-misc/xorgxrdp ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
emerge --ask xorg xorgxrdp

echo '#!/bin/bash' > /home/x/.xinitrc
echo 'startxfce4' >> /home/x/.xinitrc
chmod +x /home/x/.xinitrc

systemctl enable xrdp
echo "..........................................................."
