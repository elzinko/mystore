#!/bin/sh

#docker pull jdubois/jhipster-docker
#mkdir -p jhipster

docker run -d -p 8080:8080 -p 9000:9000 -p 35729:35729 -p 4022:22 -t jdubois/jhipster-docker
docker_vm_name=$(docker ps | awk '{print $NF}' | awk 'FNR==2')
docker run --rm -v /usr/local/bin/docker:/docker -v /var/run/docker.sock:/docker.sock svendowideit/samba $docker_vm_name

mkdir -p /Volumes/jhipster
mount -t smbfs //guest:@192.168.59.103/jhipster /Volumes/jhipster
df -k -T smbfs

ln -s /Volumes/jhipster /Users/elzinko/Devs/projects/mystore

cat ~/.ssh/id_boot2docker.pub | ssh -p 4022 jhipster@localhost 'mkdir ~/.ssh && cat >> ~/.ssh/authorized_keys'

docker ps
