echo ">>> Installing KDE"
eselect profile set 10  #systemd desktop plasma
emerge kde-plasma/plasma-meta
emerge --update --deep --newuse @world
emerge kde-apps/kdecore-meta #lessen the MAKEOPTS value
systemctl set-default graphical
systemctl enable sddm
echo "..........................................................."

echo ">>> Installing desktop packages"
emerge microsoft-edge youtube-dl simplescreenrecorder app-editors/vscode telegram-desktop-bin nomacs terminator remmina pavucontrol timeshift firefox-bin plocate qbittorrent libreoffice-bin flameshot brave-bin
echo "..........................................................."

echo "net-misc/xrdp ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords 
echo "net-misc/xorgxrdp ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
sed -i 's/EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --getbinpkgonly"/EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --getbinpkg --usepkg-exclude 'xrdp xorgxrdp'"/g' /etc/portage/make.conf
emerge --ask --verbose xorg xorgxrdp


