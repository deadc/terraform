# Makefile for modules
# Thiago Freitas (deadcow@archlinux.com.br) - 21/11/2017

ACTION = plan

all: vpc

init:
	terraform init

plan: init
	terraform plan

apply: init
	terraform apply

destroy: init
	terraform destroy

vpc:
	cd network/vpc && ${MAKE} -f ../../Makefile ${ACTION}

ec2:
	cd services/app && ${MAKE} -f ../../Makefile ${ACTION}


