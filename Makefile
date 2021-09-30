SHELL := /bin/bash
DOCKER_IMAGE_NAME := registry.ubicast.net/sys/ansible-public
VENV := /tmp/pyvensetup
ANSIBLE_CONFIG := ansible.cfg
PIP_BIN = $(shell command -v $(VENV)/bin/pip3 || command -v pip3 || echo pip3)
PIP_COMPILE_BIN = $(shell command -v $(VENV)/bin/pip-compile || command -v pip-compile)
ANSIBLE_BIN = $(shell command -v ansible || command -v $(VENV)/bin/ansible)
ANSIBLE_PLAYBOOK_BIN = $(shell command -v ansible-playbook || command -v $(VENV)/bin/ansible-playbook)
ANSIBLE_LINT_BIN = $(shell command -v ansible-lint || command -v $(VENV)/bin/ansible-lint)
ANSIBLE_GALAXY_BIN = $(shell command -v ansible-galaxy || command -v $(VENV)/bin/ansible-galaxy || echo ansible-galaxy)
YAMLLINT_BIN = $(shell command -v yamllint || command -v $(VENV)/bin/yamllint)
FLAKE8_BIN = $(shell command -v flake8 || command -v $(VENV)/bin/flake8)

# molecule tests flags
ifdef debug
	MOLECULE_FLAGS += --debug
endif
ifdef keep
	MOLECULE_TEST_FLAGS += --destroy=never
endif
ifdef pf-std
	MOLECULE_TEST_FLAGS += --scenario-name pf-std
endif
ifdef pf-ha
	MOLECULE_TEST_FLAGS += --scenario-name pf-ha
endif
ifdef pgsql-ha
	MOLECULE_TEST_FLAGS += --scenario-name pgsql-ha
endif

.PHONY: all
## TARGET: DESCRIPTION: ARGS
all: help

.PHONY: venv
## venv: Install python3-venv and create a temporary virtualenv
venv:
	-@command -v apt-get >/dev/null && apt-get update && apt-get install -y python3-venv
	python3 -m venv $(VENV)

## requirements.txt: Update requirements and their dependencies
## requirements.dev.txt: Update development requirements and their dependencies
%.txt: %.in
	$(PIP_COMPILE_BIN) -U $^ -o $@
	chmod 644 $@

.PHONY: install
## install: Install requirements
install: venv
	$(PIP_BIN) install -U pip wheel
	$(PIP_BIN) install -r requirements.txt

.PHONY: install-galaxy
install-galaxy:
	ANSIBLE_CONFIG=$(ANSIBLE_CONFIG) $(ANSIBLE_GALAXY_BIN) install -r requirements.yml

.PHONY: install-dev
## install-dev: Install development requirements
install-dev: install
	$(PIP_BIN) install -r requirements.dev.txt
	[ -d .git/hooks ] || mkdir .git/hooks
	ln -sfv .githooks/pre-commit .git/hooks/ || echo "Failed to create pre-commit link"

.PHONY: lint
## lint: Run linters on the project
lint: 
	$(FLAKE8_BIN) --config .lint/flake8.conf
	$(YAMLLINT_BIN) --config-file .lint/yamllint.conf .
	ANSIBLE_CONFIG=$(ANSIBLE_CONFIG) $(ANSIBLE_LINT_BIN) -c .lint/ansible-lint.conf playbooks/site.yml
	.lint/ansible-apt-block-check.sh

.PHONY: test
## test: Run development tests on the project : SKYREACH_SYSTEM_KEY=<xxx>, debug=1, keep=1, pf-std=1, pgsql-ha=1
test:
	cd ansible; molecule $(MOLECULE_FLAGS) test $(MOLECULE_TEST_FLAGS)

.PHONY: deploy
## deploy: Run deployment playbooks : i=<inventory-path>, l=<host-or-group>, t=<tag>
deploy:
ifndef i
	$(error i is undefined)
endif
ifndef l
	$(eval l=all)
endif
ifndef t
	$(eval t=all)
endif
	ANSIBLE_CONFIG=$(ANSIBLE_CONFIG) $(ANSIBLE_BIN) -i $(i) -l $(l) -m ping all
	ANSIBLE_CONFIG=$(ANSIBLE_CONFIG) $(ANSIBLE_PLAYBOOK_BIN) -i $(i) playbooks/site.yml -e conf_update=true -l $(l) -t $(t)

.PHONY: docker-build
## docker-build: Run docker image build for.docker
docker-build: docker-pull
	docker build -t $(DOCKER_IMAGE_NAME) -f .docker/Dockerfile .

.PHONY: docker-rebuild
## docker-rebuild: Force docker image rebuild
docker-rebuild:
	docker build --pull --no-cache -t $(DOCKER_IMAGE_NAME) -f .docker/Dockerfile .

.PHONY: docker-pull
## docker-pull: Pull Docker image from registry
docker-pull:
	-docker pull $(DOCKER_IMAGE_NAME)

.PHONY: docker-push
## docker-push: Push Docker image to registry
docker-push:
	docker push $(DOCKER_IMAGE_NAME)

.PHONY: help
## help: Print this help message
help:
	@echo -e "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'
