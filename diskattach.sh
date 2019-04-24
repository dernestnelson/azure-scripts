#!/bin/bash

disk=$1
vmgroup=$2
OS=$3
size=$4
name=$5
vm=$6

##make and attach disk to VM
az disk create -n $disk -g $vmgroup --os-type $OS --size $size
az vm disk attach -g $vmgroup --vm-name $name --name $disk

##login to VM
ssh $vm

##in VM
sudo mkfs -t ext4 /dev/sdc
sudo mkdir /media/$disk
sudo mount /dev/sdc /media/$disk
