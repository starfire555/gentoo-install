_target=/mnt/nvme0n1p3
umount -l $_target/dev{/shm,/pts,}
umount -R $_target
