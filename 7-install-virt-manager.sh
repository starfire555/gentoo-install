echo app-emulation/qemu vde spice ssh >> /etc/portage/package.use/package.use
echo net-misc/spice-gtk usbredir >> /etc/portage/package.use/package.use
echo net-dns/dnsmasq script >> /etc/portage/package.use/package.use

emerge --fetchonly app-emulation/virt-manager net-misc/bridge-utils
emerge app-emulation/virt-manager net-misc/bridge-utils

systemctl enable libvirtd.service

#from https://wiki.archlinux.org/title/Network_bridge#With_bridge-utils
nmcli connection add type bridge ifname br0 stp no
nmcli connection add type bridge-slave ifname enp9s0 master br0
nmcli connection show --active

echo ">>> copy the UUID and : nmcli connection down insert-UUID-here"
echo ">>> then nmcli connection up bridge-br0"
echo ">>> then nmcli connection up bridge-slave-enp9s0"
