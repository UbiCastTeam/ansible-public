# Contributing guide

## External software

Please read the tools documentations and the associated best practices.

- [Ansible documentation](https://docs.ansible.com/ansible/latest/)
- [Molecule documentation](https://molecule.readthedocs.io/en/latest/)
- [TestInfra documentation](https://testinfra.readthedocs.io/en/latest/)

## Developpement environment

Install all [required tools](requirements.md) and then execute:

```sh
cd /root/ansible-public
make requirements-dev
```

Then install [docker](https://docs.docker.com/engine/install/debian/) (it is used to deploy components in container).

## Test

To check that your "code" is compliant:

```sh
make lint
```

To run Ansible tests, you will need the same configuration as in the CI, then run:

```sh
# run default test
make test

# show debug logs
DEBUG=1 make test

# do not destroy tests containers
KEEP=1 make test
```

If you add/modify a role, please write relevants tests in `molecule/default/tests`.


## Test changes in a docker container

A command is available in the make file to deploy the full product in a docker container.

First, you need to set a correct value for `skyreach_system_key` in this file:
`inventories/test-container/host_vars/ansibletest.yml`

To instantiate the docker container and to run the deployment, start this command:

```sh
make deploy-test-container
```

The docker container is named "ansibletest".

To access the container:

```sh
make enter-test-container
```
