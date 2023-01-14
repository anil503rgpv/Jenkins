
# Jenkins Master Setup

## Agenda 

Run Jenkins master node into docker container.

#### Prerequisites

1. EC2 machine with 4gb and 50gb SSD
2. install docker engin in EC2
3. create a new user(jenkins)
    useradd jenkins --> create new user
    passwd jenkins --> update default passwords 
    usermod -aG docker jenkins --> docker executable permission of jenkins user

#### Steps to run Jenkins master 

1. Create A DockerFile using jenkins Official image
2. updating username and passsword of smpt aws ses server for security reason 
    `sed -i 's/REPLACE_ME_SMTP_USERNAME/<username>/g' jenkins.yaml`
    `sed -i 's/REPLACE_ME_SMTP_PASSWORD/<password>/g' jenkins.yaml`
3. build a docker image 
```docker build -t jenkins-master:04 --build-arg REPLACE_ME_SMTP_PASSWORD=$(echo $(cat password | grep REPLACE_ME_SMTP_PASSWORD=) | sed 's/REPLACE_ME_SMTP_PASSWORD=//g') --build-arg REPLACE_ME_SMTP_USERNAME=$(echo $(cat password | grep REPLACE_ME_SMTP_USERNAME=) | sed 's/REPLACE_ME_SMTP_USERNAME=//g') .```
3. send docker image into any container repository --> it's optional when we are trying build and run on same machine
4. Run/start docker image
5. Enable Ingress port for Jenkins node.



#### documentation
Official JCasC base github Repo
https://github.com/jenkinsci/configuration-as-code-plugin

Official demo documentation JCasC 
https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos

#### ansible -packer commands
`docker build -t ansible-packer:01 .`

`docker build -t packer-test:02 .`

`docker run -v `pwd`:/workspace -w /workspace packer-test:02 build .`


# Check if the ECR registry exists
REGISTRY_EXISTS=$(aws ecr describe-repositories --repository-names jenkins-master 2>&1)

if [[ $REGISTRY_EXISTS == *"RepositoryNotFoundException"* ]]; then
  # Create the ECR registry
  aws ecr create-repository --repository-name jenkins-master
else
  echo "ECR registry jenkins-master already exists"
fi



===================
ECR_REGISTRY := jenkins-master

check-registry:
	aws ecr describe-repositories --repository-names $(ECR_REGISTRY) > /dev/null 2>&1 || $(MAKE) create-registry

create-registry:
	aws ecr create-repository --repository-name $(ECR_REGISTRY)

