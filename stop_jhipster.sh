#!/bin/sh
read -p "Press any key to stop jhipster..." -n1 -s
echo "\r" 
umount /Volumes/jhipster
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker ps
