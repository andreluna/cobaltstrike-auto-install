#!/bin/bash

# Tested on Ubuntu 20.04 LTS - Cloud Microsoft Azure
# Update and install java

sudo apt-get update
sudo apt-get install build-essential -y
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update -y 
sudo apt-get install openjdk-11-jdk -y
sudo update-java-alternatives -s java-1.11.0-openjdk-amd64

# Download and install cobalt strike
cd /opt

KEY="<LICENCE KEY HERE>"

TOKEN=$(curl -s https://download.cobaltstrike.com/download -d "dlkey=$KEY" | grep 'href="/downloads/' | cut -d '/' -f3)
VERSION=$(curl -s https://download.cobaltstrike.com/download -d "dlkey=$KEY" | grep 'href="/downloads/' | cut -d '/' -f4)

wget https://download.cobaltstrike.com/downloads/$TOKEN/$VERSION/cobaltstrike-dist.tgz
tar xf cobaltstrike-dist.tgz
rm -rf cobaltstrike-dist.tgz

# Disable dns resolver for cobalt strike dns beacon
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
sudo rm /etc/resolv.conf
sudo echo "nameserver 8.8.8.8" >  /etc/resolv.conf
sudo echo "nameserver 8.8.4.4" >>  /etc/resolv.conf
sudo systemctl stop systemd-resolved

