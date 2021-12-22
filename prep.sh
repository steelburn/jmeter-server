#!/bin/bash

# Ensure we have all our package requirements
sudo apt install -y wget unzip 

mkdir -p temp
mkdir -p plugins

# Get Plugin Manager
wget -cP temp -O plugins/plugins-manager.jar https://jmeter-plugins.org/get/  

# Get the rest of our selected plugins
grep -v ^# plugins.list | awk '{ print "echo Getting: " $1 " && wget -qcP temp " $1 }' | bash

# Extract all downloaded plugins into 'plugins' directory
ls temp/*.zip | awk '{ print "echo Extracting: " $1 " && unzip -j -o " $1 " -d plugins" }' | bash




