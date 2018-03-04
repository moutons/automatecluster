.SILENT: banner help cleanup

SHELL := /bin/bash
VAGRANT := $(shell command -v vagrant 2> /dev/null)
VBOXMANAGE := $(shell command -v VBoxManage 2> /dev/null)

default: help

banner:
	echo ""
	echo " why are you using this?"
	echo "  it's really not for anyone to use!"
	echo ""

help: banner
	grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

preflight:
ifndef VAGRANT
	$(error "vagrant not found in PATH - is it installed?")
endif
ifndef VBOXMANAGE
	$(error "vboxmanage not found in PATH - is it installed?")
endif

cleanup: preflight ## clean up pemfiles and destroy all machines
	-rm shared/*.pem
	-vagrant destroy -f

clean: cleanup

clusterup: preflight ## build the cluster
	-vagrant up chefserver
	-echo -e "\n\nChef Server Up!\n\n"
	-vagrant up automate
	-echo -e "\n\nAutomate Server Up!\n\n"
	-vagrant up client1
	-vagrant up client2
	-vagrant up runner1

cluster: clusterup

autoup: preflight ## just build chefserver and automate
	-vagrant up chefserver
	-echo -e "\n\nChef Server Up!\n\n"
	-vagrant up automate

auto: autoup