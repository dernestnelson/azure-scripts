#!/bin/bash

rg=$1
vm_name=$2
disk=$3


az disk create -g $rg --name $disk --os-type Linux --size 30
az vm create -g $rg -n $vm_name --custom-data '~/vm-init.txt' --image UbuntuLTS --size Standard_B1s 

attach(){
    az vm disk attach -g $rg --vm-name $vm_name --name $disk
}

detach(){
     az vm disk detach -g $rg --vm-name $vm_name --name $disk
}

command=$4

if [ $command != attach ] && [ $command != detach ]; then
    echo "not a proper command"
    exit 1
fi

$command

