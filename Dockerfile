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
#ARG REPLACE_ME_SMTP_USERNAME
# ARG REPLACE_ME_SMTP_PASSWORD
# RUN echo $REPLACE_ME_SMTP_USERNAME + '---' + $REPLACE_ME_SMTP_PASSWORD
# RUN sed -i 's/REPLACE_ME_SMTP_USERNAME/$REPLACE_ME_SMTP_USERNAME/g' /var/jenkins_home/casc_configs/jenkins.yaml
# RUN sed -i 's/REPLACE_ME_SMTP_PASSWORD/$REPLACE_ME_SMTP_PASSWORD/g' /var/jenkins_home/casc_configs/jenkins.yaml
RUN chown jenkins:jenkins -R /var/jenkins_home/casc_configs

USER jenkins


ARG JAVA_OPTS
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"



ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs/jenkins.yaml
