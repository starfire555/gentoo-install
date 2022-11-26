echo ">>> Setting package USE flags"
echo "media-libs/libsndfile minimal" >> /etc/portage/package.use/package.use
echo ">=dev-libs/libdbusmenu-16.04.0-r2 gtk3" >> /etc/portage/package.use/package.use
echo "net-misc/remmina rdp ssh spice vnc" >> /etc/portage/package.use/package.use
echo ">=sys-libs/zlib-1.2.12-r3 minizip" >> /etc/portage/package.use/package.use #for telegram-desktop and vlc:
echo ">=media-video/ffmpeg-4.4.2 opus" >> /etc/portage/package.use/package.use #for telegram-desktop:
echo "..........................................................."

echo ">>> Setting package ACCEPT_KEYWORDS"
echo "app-editors/vscode ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "app-backup/timeshift ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "..........................................................."

echo ">>> Installing Gnome"
eselect profile set 7  #systemd desktop gnome
emerge gnome-base/gnome gnome-extra/gnome-tweaks gnome-extra/gnome-shell-extensions
#NOTDONE emerge --ask --verbose gnome-extra/chrome-gnome-shell
emerge --update --deep --newuse @world
systemctl set-default graphical
systemctl enable gdm

cat << EOF >> /etc/xdg/autostart/pulseaudio-daemon.desktop
[Desktop Entry]
Type=Application
Name=pulseaudio
Exec=pulseaudio -D
OnlyShowIn=GNOME;
EOF

gpasswd -a x plugdev

sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm/custom.conf
echo "..........................................................."

echo ">>> Installing desktop packages"
emerge --fetchonly microsoft-edge youtube-dl simplescreenrecorder app-editors/vscode nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin telegram-desktop vlc
emerge microsoft-edge youtube-dl simplescreenrecorder app-editors/vscode nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin telegram-desktop vlc
echo "..........................................................."
