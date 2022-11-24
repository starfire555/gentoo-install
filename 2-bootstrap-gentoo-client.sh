echo ">>> Getting and extracting gentoo stage 3"
cd /mnt/gentoo
wget --recursive --level=1 --no-parent --no-directories  --accept-regex 'stage3-amd64-desktop-systemd-.{17}tar.xz' --directory-prefix=. https://www.mirrorservice.org/sites/distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-systemd/
rm index.html && rm *.tar.xz.*
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner
echo "..........................................................."

echo ">>> Copying gentoo install scripts into chroot"
cp -R /gentoo-install /mnt/gentoo/
echo "..........................................................."

echo ">>> Updating make.conf: MAKEOPTS, GENTOO_MIRRORS"
#sed -i 's/COMMON_FLAGS="-O2 -pipe"/COMMON_FLAGS="-O2 -pipe -march=x86_64"/g' etc/portage/make.conf
echo 'MAKEOPTS="-j5"' >> etc/portage/make.conf
echo 'GENTOO_MIRRORS="https://mirror.bytemark.co.uk/gentoo/ rsync://mirror.bytemark.co.uk/gentoo/ https://www.mirrorservice.org/sites/distfiles.gentoo.org/ rsync://rsync.mirrorservice.org/distfiles.gentoo.org/"' >> etc/portage/make.conf
echo "..........................................................."

echo ">>> Copying repos.conf to etc"
mkdir --parents etc/portage/repos.conf && cp usr/share/portage/config/repos.conf etc/portage/repos.conf/gentoo.conf
echo "..........................................................."

echo ">>> Copying resolv.conf from host /etc to target etc"
cp --dereference /etc/resolv.conf etc/
echo "..........................................................."

### HOST ###
#echo 'BINPKG_FORMAT="gpkg"' >> etc/portage/make.conf
#echo 'FEATURES="buildpkg"' >> etc/portage/make.conf
############

### CLIENT ###
echo ">>> Updating make.conf: MERGE_DEFAULT_OPTS --> getbinpkgonly"
echo 'EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --getbinpkgonly"' >> etc/portage/make.conf
echo "..........................................................."

echo ">>> Updating etc/portage/binrepos.conf with binhost details"
cat << EOF > etc/portage/binrepos.conf
[binhost]
sync-uri = http://192.168.1.186:80/packages
priority = 10
EOF
echo "..........................................................."
############

### HOST gentoo ###
#emerge www-servers/lighttpd
#cat << EOF >> /etc/lighttpd/lighttpd.conf
#$SERVER["socket"] == "192.168.1.186:443" {
  #server.name = "192.168.1.186"
  #server.document-root = "/var/www/localhost/"
  #server.errorlog = "/var/log/lighttpd/http_error.log"
  #accesslog.filename = "/var/log/lighttpd/http_access.log"
#}
## add this to the end of the standard configuration
#server.dir-listing = "enable"
#server.modules += ( "mod_alias" )
#alias.url = ( "/packages" => "/var/cache/binpkgs/" )
#EOF
############

### HOST arch ###
#pacman -S lighttpd
#cat << EOF >> /etc/lighttpd/lighttpd.conf
#
## add this to the end of the standard configuration
#server.dir-listing = "enable"
#server.modules += ( "mod_alias" )
#alias.url = ( "/packages" => "/mnt/gentoo/var/cache/binpkgs/" )
#EOF
############

echo ">>> Mounting proc, sys, dev, run, tmpfs, shm"
mount --types proc /proc /mnt/gentoo/proc && mount --rbind /sys /mnt/gentoo/sys && mount --make-rslave /mnt/gentoo/sys && mount --rbind /dev /mnt/gentoo/dev && mount --make-rslave /mnt/gentoo/dev && mount --bind /run /mnt/gentoo/run && mount --make-slave /mnt/gentoo/run
test -L /dev/shm && rm /dev/shm && mkdir /dev/shm && mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm && chmod 1777 /dev/shm
echo "..........................................................."

echo ""
echo "########################################################"
echo "### bootstrap complete                               ###"
echo "###                                                  ###"
echo "### Type:   chroot /mnt/gentoo /bin/bash             ###"
echo "###                                                  ###"
echo "### Then run the next script from inside the chroot  ###"
echo "###                                                  ###"
echo "########################################################"
echo ""

