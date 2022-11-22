echo ">>> Installing KDE"
eselect profile set 10  #systemd desktop plasma
emerge kde-plasma/plasma-meta
emerge --update --deep --newuse @world
emerge kde-apps/kdecore-meta #lessen the MAKEOPTS value
systemctl set-default graphical
systemctl enable sddm
echo "..........................................................."

echo ">>> Setting package ACCEPT_KEYWORDS"
echo "app-editors/vscode ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "app-backup/timeshift ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "net-im/telegram-desktop-bin ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "..........................................................."

echo ">>> Installing desktop packages"
emerge --fetchonly microsoft-edge youtube-dl simplescreenrecorder app-editors/vscode telegram-desktop-bin nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin
emerge microsoft-edge youtube-dl simplescreenrecorder app-editors/vscode telegram-desktop-bin nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin
echo "..........................................................."
