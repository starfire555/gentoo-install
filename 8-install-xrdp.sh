echo net-misc/xrdp ~amd64 >> /etc/portage/package.accept_keywords/package.accept_keywords
echo net-misc/xorgxrdp ~amd64 >> /etc/portage/package.accept_keywords/package.accept_keywords

emerge xrdp xorgxrdp

systemctl enable --now xrdp

echo '#!/bin/bash' > /home/x/.xinitrc
echo 'gnome-session' >> /home/x/.xinitrc
chmod +x /home/x/.xinitrc
chown x: /home/x/.xinitrc
