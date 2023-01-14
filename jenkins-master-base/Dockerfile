FROM jenkins/jenkins:lts-jdk11

LABEL maintainer="anilkupatel001@gmail.com"
ENV JENKINS_HOME /var/jenkins_home
COPY --chown=jenkins:jenkins plugins_extra.txt /usr/share/jenkins/ref/plugins_extra.txt
RUN \cp /usr/share/jenkins/ref/plugins_extra.txt ${JENKINS_HOME}/plugins_extra.txt
RUN jenkins-plugin-cli --verbose --plugin-file /usr/share/jenkins/ref/plugins_extra.txt
USER root

RUN apt-get install -y git \
    curl \
    unzip \
    passwd 
RUN apt update && apt install  openssh-server sudo -y \
    dstat \
    lsof  \
    fontconfig \
    mtr \
    rsync \
    strace \
    traceroute \
    wget 

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y gcc python-dev libkrb5-dev && \
  apt-get install python3-pip -y && \
  pip3 install --upgrade pip && \
  pip3 install --upgrade virtualenv && \
  pip3 install pywinrm[kerberos] && \
  apt install krb5-user -y && \
  pip3 install pywinrm

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN pip3 install ansible
RUN apt-get install lsb-release -y
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-get install software-properties-common -y
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get install packer terraform -y
