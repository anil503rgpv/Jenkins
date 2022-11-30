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

COPY jenkins.yaml /var/jenkins_home/casc_configs/jenkins.yaml
RUN chown jenkins:jenkins -R /var/jenkins_home/casc_configs

USER jenkins


ARG JAVA_OPTS
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"
# password file you need to create by yourself and keep this to your project repo without commiting in Github
COPY password /var/password  
ARG REPLACE_ME_SMTP_USERNAME=$(echo $(cat /var/password | grep REPLACE_ME_SMTP_USERNAME=) | sed 's/REPLACE_ME_SMTP_USERNAME=//g')
ARG REPLACE_ME_SMTP_PASSWORD=$(echo $(cat /var/password | grep REPLACE_ME_SMTP_PASSWORD=) | sed 's/REPLACE_ME_SMTP_PASSWORD=//g')
RUN sed -i 's/REPLACE_ME_SMTP_USERNAME/$REPLACE_ME_SMTP_USERNAME/g' /var/jenkins_home/casc_configs/jenkins.yaml
RUN sed -i 's/REPLACE_ME_SMTP_PASSWORD/$REPLACE_ME_SMTP_PASSWORD/g' /var/jenkins_home/casc_configs/jenkins.yaml

ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs/jenkins.yaml
