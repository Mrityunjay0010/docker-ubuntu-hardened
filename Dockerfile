FROM ubuntu:latest

LABEL org.opencontainers.image.authors="Mrityunjay0010@gmail.COM"

# Environment Variables
ENV DEBIAN_FRONTEND=noninteractive
ENV APP_USER=app
ENV APP_USER=$APP_USER
ENV APP_DIR="/$APP_USER"
ENV DATA_DIR "$APP_DIR/data"
ENV CONF_DIR "$APP_DIR/conf"

USER root

# Update Packages
RUN apt-get update && apt-get -y install apt-utils && apt-get -fuy full-upgrade -y 

# Install Ansible
RUN add-apt-repository --yes --update ppa:ansible/ansible
RUN apt-get install -y ansible

#Download and run konstruktoid.hardening Playbook
RUN git clone https://github.com/Mrityunjay0010/docker-ubuntu-hardened.git
RUN cd /docker-ubuntu-hardened/ && chmod +x ./dockersetup.sh
RUN cd /docker-ubuntu-hardened && bash ./dockersetup.sh

ENTRYPOINT [ "/bin/bash" ]
