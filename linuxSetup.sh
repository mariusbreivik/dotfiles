#!/bin/bash

# ppa repo
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# ppa keys
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 

sudo apt update

sudo apt -y install git vim curl sublime-text-installer google-chrome-stable

# docker
sudo apt update
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt update
sudo apt -y install docker-ce

# Citrix
sudo apt -y install gdebi-core
gdebi icaclient_13.8.0.10299729_amd64.deb
gdebi icaclientWeb_13.8.0.10299729_amd64.deb
gdebi ctxusb_2.7.10276927_amd64.deb

# silent install of java 8
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

sudo apt -y install oracle-java8-installer oracle-java8-set-default maven
sudo update-java-alternatives -s java-8-oracle
