##############
### SERVER ###
##############

emerge net-fs/nfs-utils
mkdir /export
mkdir /export/hdd1
mkdir /export/hdd2
#mount --bind /mnt/sdc /export/hdd1
#mount --bind /mnt/sdd /export/hdd2
echo '/mnt/sdc    /export/hdd1    none    bind    0    0'  >> /etc/fstab
echo '/mnt/sdd    /export/hdd2    none    bind    0    0'  >> /etc/fstab

systemctl daemon-reload
mount /export/hdd1
mount /export/hdd2

echo '/export         192.168.1.0/24(insecure,rw,sync,no_subtree_check,crossmnt,fsid=0)' >> /etc/exports
echo '/export/hdd1    192.168.1.0/24(insecure,rw,sync,no_subtree_check)' >> /etc/exports
echo '/export/hdd2    192.168.1.0/24(insecure,rw,sync,no_subtree_check)' >> /etc/exports

echo 'RPCNFSDARGS="8 -V 3 -V 4"' >> /etc/conf.d/nfs

systemctl enable --now rpcbind nfs-server

##############
### CLIENT ###
##############

emerge net-fs/nfs-utils

#mount gentoo-bb:/hdd1 /mnt/nfs-gentoo-bb/hdd1
#mount gentoo-bb:/hdd2 /mnt/nfs-gentoo-bb/hdd2
#mount gentoo-pro:/hdd1 /mnt/nfs-gentoo-pro/hdd1

mkdir -p /mnt/nfs/gentoo-bb/{hdd1,hdd2}
mkdir -p /mnt/nfs/gentoo-pro/hdd1
chown -R x: /mnt/nfs

echo 'gentoo-bb:/hdd1    /mnt/nfs/gentoo-bb/hdd1    nfs    rw,_netdev,noauto,user    0    0' >> /etc/fstab
echo 'gentoo-bb:/hdd2    /mnt/nfs/gentoo-bb/hdd2    nfs    rw,_netdev,noauto,user    0    0' >> /etc/fstab
echo 'gentoo-pro:/hdd1   /mnt/nfs/gentoo-pro/hdd1   nfs    rw,_netdev,noauto,user    0    0' >> /etc/fstab

systemctl daemon-reload
mount /mnt/nfs/gentoo-bb/hdd1
mount /mnt/nfs/gentoo-bb/hdd2
mount /mnt/nfs/gentoo-pro/hdd1
