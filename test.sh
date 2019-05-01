#!/bin/bash

rg=$1
vm_name=$2
disk=$3

## creating disk and VM
az disk create -g $rg --name $disk --os-type Linux --size 30
az vm create -g $rg -n $vm_name --custom-data '~/test.txt' --image UbuntuLTS --size Standard_B1s 
az vm disk attach -g $rg --vm-name $vm_name --name $disk

## getting admin username and IP
IP=$(az vm show -g $rg -n $vm_name -d --query publicIps)
username=$(az vm show -g $rg -n $vm_name --query osProfile.adminUsername)

##signing in to VM
ssh $username@$IP

## mounting disk
sudo mkfs -t ext4 /dev/sdc
sudo mkdir /media/$disk
sudo mount /dev/sdc /media/$disk

sudo mv index.js /media/$disk/
exit

az vm open-port -n $vm_name -g $rg --port 8080