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
