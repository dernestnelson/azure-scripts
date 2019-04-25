#!/bin.bash

vm=$1 ##username@IP
dir=$2
username=$3
email=$4

ssh $vm

##sets up vm environment
curl 'https://raw.githubusercontent.com/dernestnelson/revature-p0/master/linux-setup.sh' | sh

##makes a git repository and makes a package.json
curl 'https://raw.githubusercontent.com/dernestnelson/revature-p0/master/git-node-project.sh' | bash -s $dir $username $email

cd $dir
touch script.js

exit

az vm open-port -g $vmgroup -n $vmname --port $port --priority $priority

ssh $vm

node script.js
