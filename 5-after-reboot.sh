echo ">>> Setting hostname"
hostnamectl hostname gentoo-x86
echo "..........................................................."

echo ">>> Setting package USE flags"
echo "media-libs/libsndfile minimal" >> /etc/portage/package.use/package.use
echo ">=media-video/ffmpeg-4.4.2 opus" >> /etc/portage/package.use/package.use
echo ">=dev-libs/libdbusmenu-16.04.0-r2 gtk3" >> /etc/portage/package.use/package.use
echo "net-misc/remmina rdp ssh" >> /etc/portage/package.use/package.use
echo "..........................................................."

echo ">>> Setting package ACCEPT_KEYWORDS"
echo "app-editors/vscode ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "app-backup/timeshift ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "net-im/telegram-desktop-bin ~amd64" >> /etc/portage/package.accept_keywords/package.accept_keywords
echo "..........................................................."

echo ">>> Installing initial packages"
emerge app-misc/screen neofetch btop sudo app-portage/gentoolkit esearch media-sound/alsa-utils app-eselect/eselect-repository dev-vcs/git
echo "..........................................................."

echo ">>> Enabling and syncing overlays"
eselect repository enable guru ace brave-overlay && emerge --sync guru ace brave-overlay
echo "..........................................................."

echo ">>> Updating esearch database"
eupdatedb
echo "..........................................................."

echo ">>> Configure sudo"
EDITOR=nano visudo
echo "..........................................................."