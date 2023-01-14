IMAGE_NAME = jenkins-master-base

MAKE_COMMON ?= ../make-common
include $(MAKE_COMMON)/docker.mk
include $(MAKE_COMMON)/common.mk

docker.login.ecr : 
		@echo "*** Login to AWS ecr ***"
		aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 532366692945.dkr.ecr.ap-south-1.amazonaws.com
		
		
prepare : docker.login.ecr