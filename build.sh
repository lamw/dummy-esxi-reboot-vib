#!/bin/bash

COLOR='\033[0;32m'
NOCOLOR='\033[0m'

if [ "$EUID" -ne 0 ]
  then echo "Please run with sudo"
  exit
fi

echo -e "${COLOR}Creating Dummy ESXi Reboot VIB build container${NOCOLOR} ..."
docker rmi -f dummyesxirebootvib
rm -rf artifacts
docker build -t dummyesxirebootvib .
mkdir -p artifacts
chown vmware:vmware artifacts
docker run -i -v ${PWD}/artifacts:/artifacts dummyesxirebootvib sh << COMMANDS
cp dummy-esxi-reboot* /artifacts
COMMANDS
