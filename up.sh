#!/bin/bash
# Copy the key for ssh to the VMs
cp ~/.vagrant.d/insecure_private_key . ;
# Create the VMs
for i in `seq -f '%02g' 1 $1`;
do
  vagrant up c74$i
done
