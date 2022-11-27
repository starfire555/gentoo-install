echo ">>> Setting hostname"
hostnamectl hostname gentoo-mm
echo "..........................................................."

echo ">>> Installing initial packages"
emerge app-misc/screen neofetch btop sudo app-portage/gentoolkit esearch media-sound/alsa-utils app-eselect/eselect-repository dev-vcs/git bash-completion
echo "..........................................................."

echo ">>> Enabling and syncing overlays"
eselect repository enable guru ace brave-overlay nest pf4public && emerge --sync guru ace brave-overlay nest pf4public
echo "..........................................................."

echo ">>> Updating esearch database"
eupdatedb
echo "..........................................................."

echo ">>> Configure sudo"
EDITOR=nano visudo
echo "..........................................................."
