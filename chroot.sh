sed -e "s/#ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/" -e "s/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen > /etc/locale.gen

echo LANG=en_US.UTF-8 > /etc/locale.conf

ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

hwclock --systohc --utc

HOSTNAME=archlinux
echo $HOSTNAME > /etc/hostname
echo "127.0.0.1 localhost.localdomain localhost $HOSTNAME" > /etc/hosts
echo "::1   localhost.localdomain localhost $HOSTNAME" >> /etc/hosts

pacman -S --noconfirm grub efibootmgr networkmanager alacritty git vim sudo networkmanager

systemctl start NetworkManager
systemctl enable NetworkManager

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub --recheck
mkdir -p /boot/EFI/boot
cp /boot/EFI/grub/grubx64.efi  /boot/EFI/boot/bootx64.efi
grub-mkconfig -o /boot/grub/grub.cfg

passwd root