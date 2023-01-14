FROM 532366692945.dkr.ecr.ap-south-1.amazonaws.com/jenkins-master-base:latest

COPY jenkins.yaml /var/jenkins_home/casc_configs/jenkins.yaml

RUN chown jenkins:jenkins -R /var/jenkins_home/casc_configs

USER jenkins


ARG JAVA_OPTS
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"



ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs/jenkins.yaml
