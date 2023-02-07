FROM 532366692945.dkr.ecr.ap-south-1.amazonaws.com/jenkins-master-base:latest
ARG MAIL_SECRET_KEY
ARG MAIL_ACCESS_KEY
ARG PRIVATE_KEY_PATH=/home/jenkins/ssh_key/id_rsa
COPY id_rsa ${PRIVATE_KEY_PATH}
RUN chmod 400 ${PRIVATE_KEY_PATH} && chown jenkins:jenkins ${PRIVATE_KEY_PATH}
RUN apt-get install \
    ca-certificates \
    gnupg 
RUN mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  bionic stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN chmod a+r /etc/apt/keyrings/docker.gpg
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

COPY jenkins.yaml /home/jenkins/casc_configs/jenkins.yaml
RUN chown jenkins:jenkins -R /home/jenkins/casc_configs

USER jenkins
ENV MAIL_SECRET_KEY=${MAIL_SECRET_KEY}
ENV MAIL_ACCESS_KEY=${MAIL_ACCESS_KEY}
ENV SSH_PRIVATE_FILE_PATH=${PRIVATE_KEY_PATH}
ARG JAVA_OPTS
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"

ENV CASC_JENKINS_CONFIG=/home/jenkins/casc_configs/jenkins.yaml
