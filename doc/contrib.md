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

To run Ansible tests:

```sh
# run default test
make test

# show debug logs
DEBUG=1 make test

# do not destroy tests containers
KEEP=1 make test
```

If you add/modify a role, please write relevants tests in `molecule/default/tests`.

