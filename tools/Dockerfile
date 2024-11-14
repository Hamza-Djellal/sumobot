FROM ubuntu:24.04

#install necessary packages
RUN DEBIAN_FRONTEND =noninteractive 
RUN apt-get update && apt-get install -y wget bzip2 make unzip cppcheck

#Create a non - root user "ubuntu" and put it in the sudo group
RUN useradd -rm - d /home/hamza -s /bin/bash - g root - G sudo -u 1001 hamza 
USER hamza 
WORKDIR /home/hamza
