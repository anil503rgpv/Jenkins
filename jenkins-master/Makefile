IMAGE_NAME = jenkins-master

MAKE_COMMON ?= ../make-common
include $(MAKE_COMMON)/docker.mk
include $(MAKE_COMMON)/common.mk

docker.login.ecr : 
		@echo "*** Login to AWS ecr ***"
		aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 532366692945.dkr.ecr.ap-south-1.amazonaws.com
		
check-ecr-registry: docker.login.ecr
	aws ecr describe-repositories --repository-names $(IMAGE_NAME) > /dev/null 2>&1 || \
	aws ecr create-repository --repository-name $(IMAGE_NAME)
		
prepare : check-ecr-registry