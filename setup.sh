#!/bin/bash
timedatectl set-ntp true

# var
DISKNAME="/dev/sda"
DISK1=$DISKNAME+1
DISK2=$DISKNAME+2

# partition
parted -s $DISKNAME mklabel gpt;
parted -s $DISKNAME mkpart esp fat32 1MiB 1GiB;
parted -s $DISKNAME set 1 esp on;
parted -s $DISKNAME mkpart primary fat32 1GiB 100%;

# format
mkfs.vfat -F32 $DISK1
mkfs.ext4 $DISK2

# mount
mount $DISK2 /mnt
mkdir -p /mnt/boot
mount $DISK1 /mnt/boot

# install base
pacstarap /mnt base linux linux-firmware networkmanager neovim zsh

# make fatab
genfstab -U /mnt >> /mnt/etc/fstab