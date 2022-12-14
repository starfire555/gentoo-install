echo ">>> Setting package USE flags"
echo "media-libs/libsndfile minimal" >> /etc/portage/package.use/package.use
echo ">=dev-libs/libdbusmenu-16.04.0-r2 gtk3" >> /etc/portage/package.use/package.use
echo "net-misc/remmina rdp ssh spice vnc" >> /etc/portage/package.use/package.use
echo ">=media-video/ffmpeg-4.4.2 opus" >> /etc/portage/package.use/package.use #for telegram-desktop:
echo "..........................................................."

echo ">>> Setting package ACCEPT_KEYWORDS"
echo "app-editors/vscodium ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
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
emerge --fetchonly microsoft-edge youtube-dl simplescreenrecorder app-editors/vscodium nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin telegram-desktop vlc
emerge microsoft-edge youtube-dl simplescreenrecorder app-editors/vscodium nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin telegram-desktop vlc
echo "..........................................................."

echo ">>> Installing xrdp"
echo net-misc/xrdp ~amd64 >> /etc/portage/package.accept_keywords/package.accept_keywords
echo net-misc/xorgxrdp ~amd64 >> /etc/portage/package.accept_keywords/package.accept_keywords

sed -i 's/EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --getbinpkgonly"/#EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --getbinpkgonly"/g' /etc/portage/make.conf
emerge xrdp xorgxrdp
sed -i 's/#EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --getbinpkgonly"/EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --getbinpkgonly"/g' /etc/portage/make.conf

systemctl enable --now xrdp

echo '#!/bin/bash' > /home/x/.xinitrc
echo 'gnome-session' >> /home/x/.xinitrc
chmod +x /home/x/.xinitrc
chown x: /home/x/.xinitrc
echo "..........................................................."

echo ">>> Installing flatpak"
emerge flatpak
# RUN AS NORMAL USER: flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo "..........................................................."
