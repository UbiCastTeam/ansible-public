# Import .env variables if the file exist
-include .env

VENV ?= .venv
ANSIBLE_CONFIG ?= ansible.cfg
PYTHON := $(VENV)/bin/python
ANSIBLE := ANSIBLE_CONFIG=$(ANSIBLE_CONFIG) $(VENV)/bin/ansible
ANSIBLE_GALAXY := ANSIBLE_CONFIG=$(ANSIBLE_CONFIG) $(VENV)/bin/ansible-galaxy
ANSIBLE_LINT := ANSIBLE_CONFIG=$(ANSIBLE_CONFIG) $(VENV)/bin/ansible-lint
ANSIBLE_PLAYBOOK := ANSIBLE_CONFIG=$(ANSIBLE_CONFIG) $(VENV)/bin/ansible-playbook

# https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
.PHONY: all clean update_venv venv install install-galaxy install-dev lint deploy help

## TARGET: DESCRIPTION: ARGS
all: help

## venv: Prepare the python virtual environment
venv: $(VENV)/bin/activate

${VENV}/bin/activate: requirements.txt requirements.dev.txt
	test -d $(VENV) || python3 -m venv $(VENV)
	$(PYTHON) -m pip install -U pip
	$(PYTHON) -m pip install -U wheel
	$(PYTHON) -m pip install -r requirements.txt -r requirements.dev.txt
	touch $(VENV)/bin/activate

## update_venv: Updates the virtual environment
update_venv: clean venv

## install-galaxy: Install ansible galaxy requirements
install-galaxy: venv
	$(ANSIBLE_GALAXY) install -r requirements.yml

## lint: Run linters on the project
lint: venv
	$(ANSIBLE_LINT) -c .lint/ansible-lint.conf
	.lint/ansible-apt-block-check.sh

## deploy: Run deployment playbooks : i=<inventory-path>, l=<host-or-group>, t=<tag>
deploy: venv
ifndef i
	$(error i is undefined)
endif
ifndef l
	$(eval l=all,localhost)
endif
ifndef t
	$(eval t=all)
endif
	$(ANSIBLE) -i $(i) -l $(l) -m ping all
	$(ANSIBLE_PLAYBOOK) -i $(i) playbooks/site.yml -e conf_update=true -l $(l) -t $(t)

## clean: Cleans the virtual environment
clean:
	rm -r $(VENV)

## help: Print this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' | sed -e 's/^/ /'
