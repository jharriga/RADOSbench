#!/bin/bash
# Delete Pool

myPath="${BASH_SOURCE%/*}"
if [[ ! -d "$myPath" ]]; then
    myPath="$PWD" 
fi

# Variables
source "$myPath/vars.shinc"

# delete the pool
ceph osd pool delete $pool $pool --yes-i-really-really-mean-it

# DONE
