.SILENT: banner help cleanup

SHELL := /bin/bash
VAGRANT := $(shell command -v vagrant 2> /dev/null)
VBOXMANAGE := $(shell command -v VBoxManage 2> /dev/null)
HOSTSFILE := $(shell if [ -d cookbooks/hostsfile ] ; then echo yes ; fi)


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
ifndef HOSTSFILE
	$(error "run 'cd cookbooks ; knife cookbook site download hostsfile ; tar xf hostsfile-* ; rm hostsfile-*.gz ; cd ..'")
endif

cleanup: preflight ## clean up pemfiles and destroy all machines
	-rm shared/*.pem
	-vagrant destroy -f

clean: cleanup

clusterup: preflight ## build the cluster
	-rm shared/*.pem
	-vagrant destroy -f
	-vagrant up chefserver
	-echo -e "\n\nChef Server Up!\n\n"
	-vagrant up automate
	-echo -e "\n\nAutomate Server Up!\n\n"
	-vagrant up client1
	-vagrant up client2
	-vagrant up client3
	-vagrant up runner1

cluster: clusterup

autoup: preflight ## just build chefserver and automate
	-vagrant up chefserver
	-echo -e "\n\nChef Server Up!\n\n"
	-vagrant up automate
	-echo -e "\n\nAutomate Up!\n\n"

auto: autoup

chefup: preflight ## just build chefserver and automate
	-vagrant up chefserver
	-echo -e "\n\nChef Server Up!\n\n"

chef: chefup
