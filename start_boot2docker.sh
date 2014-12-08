#!/bin/sh

#boot2docker init

#VBoxManage modifyvm "boot2docker-vm" --natpf1 "containerssh,tcp,,4022,,4022"
#VBoxManage modifyvm "boot2docker-vm" --natpf1 "containertomcat,tcp,,8080,,8080"
#VBoxManage modifyvm "boot2docker-vm" --natpf1 "containergruntserver,tcp,,9000,,9000"
#VBoxManage modifyvm "boot2docker-vm" --natpf1 "containergruntreload,tcp,,35729,,35729"
#VBoxManage modifyvm "boot2docker-vm" --natpf1 "guestmongodb,tcp,127.0.0.1,27017,,27017"

boot2docker up

export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/elzinko/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
