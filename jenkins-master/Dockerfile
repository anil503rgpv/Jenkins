FROM 532366692945.dkr.ecr.ap-south-1.amazonaws.com/jenkins-master-base:latest
ARG MAIL_SECRET_KEY
ARG MAIL_ACCESS_KEY
ARG PRIVATE_KEY_PATH=/home/jenkins/.ssh/id_rsa
COPY jenkins.yaml /var/jenkins_home/casc_configs/jenkins.yaml
RUN chown jenkins:jenkins -R /var/jenkins_home/casc_configs

USER jenkins
ENV MAIL_SECRET_KEY=${MAIL_SECRET_KEY}
ENV MAIL_ACCESS_KEY=${MAIL_ACCESS_KEY}
ENV SSH_PRIVATE_FILE_PATH=${PRIVATE_KEY_PATH}
ARG JAVA_OPTS
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"

RUN apt-get update && apt-get install -y docker-ce



ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs/jenkins.yaml
