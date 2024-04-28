lvcreate -L 10G -n winInstall rhel
mkdir /winInstall
mkfs.ntfs -f -q /dev/mapper/rhel-winInstall
mount /dev/mapper/rhel-winInstall /winInstall
cp -r /isomount/* /winInstall
# make grub entries 
grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
