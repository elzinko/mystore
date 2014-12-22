# Dockerizing mystore: Dockerfile for building mystore images
# Based on ubuntu:14.04

FROM      ubuntu:14.04
MAINTAINER Thomas Couderc <thomas.couderc@gmail.com>

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get -y update

# install python-software-properties (so you can do add-apt-repository)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-software-properties software-properties-common

# install SSH server so we can connect multiple times to the container
RUN apt-get -y install openssh-server && mkdir /var/run/sshd

# install oracle java from PPA
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java8-installer && apt-get clean

# set oracle java as the default java
RUN update-java-alternatives -s java-8-oracle
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc

# install utilities
RUN apt-get -y install vim sudo zip bzip2 fontconfig curl

# install maven
RUN apt-get -y install maven

# install node.js from PPA
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get -y install nodejs

RUN npm -v

# install yeoman, bower and jhipster
RUN npm install -g yo
#RUN npm install -g bower
RUN npm install -g generator-jhipster@1.10.2

# configure the "jhipster" and "root" users
RUN echo 'root:jhipster' |chpasswd
RUN groupadd jhipster && useradd jhipster -s /bin/bash -m -g jhipster -G jhipster && adduser jhipster sudo
RUN echo 'jhipster:jhipster' |chpasswd

# clone mystore project into the container
RUN mkdir -p /home/mystore && cd /home/mystore

# Install git
RUN apt-get install -y git

RUN mkdir -p /root/.ssh
ADD mystore-key /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN ls -al /root/.ssh
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
RUN git clone git@github.com:elzinko/mystore.git /home/mystore

#ADD mystore-key /
#RUN \
#  chmod 600 /mystore-key && \
#  echo "IdentityFile /mystore-key" >> /etc/ssh/ssh_config && \
#  echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
#RUN git clone https://github.com/elzinko/mystore.git

RUN cd /home/mystore && npm install
RUN cd /home && chown -R jhipster:jhipster /home/mystore
RUN cd /home/mystore && sudo -u jhipster mvn dependency:go-offline

# expose the working directory, the Tomcat port, the Grunt server port, the SSHD port, and run SSHD
VOLUME ["/mystore"]
EXPOSE 8080
EXPOSE 9000
EXPOSE 22
CMD    /usr/sbin/sshd -D

# install nginx
#RUN apt-get install -y nginx
#RUN apt-get install -y supervisor

# update working directories
#ADD ./config /config

# setup config
#RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
#RUN rm /etc/nginx/sites-enabled/default

#RUN ln -s /config/nginx.conf /etc/nginx/sites-enabled/
#RUN ln -s /config/supervisor.conf /etc/supervisor/conf.d/

#EXPOSE 80
#CMD ["supervisord", "-n"]

RUN mkdir -p ~docker
