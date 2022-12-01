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

Update system
RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates \
  && apt-get clean \
  && find / -xdev -name 'apt' -print0 | xargs rm -rf
  
  WORKDIR /home/$APP_USER
COPY hardening.sh .
# RUN chmod +x hardening.sh && ./hardening.sh && groupadd -r $APP_USER && useradd -r -g $APP_USER $APP_USER
RUN chmod +x hardening.sh && ./hardening.sh 
RUN useradd -m $APP_USER && adduser $APP_USER sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN chsh -s /usr/sbin/nologin root


ENTRYPOINT [ "/bin/bash" ]
