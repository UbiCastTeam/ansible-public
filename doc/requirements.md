# Prepare deployment environment

This installation has only been tested on Debian. All the commands below are run with **root rights**.

## Setup tools

### Install tools

```sh
apt update
apt upgrade -y
apt install -y vim git make gcc python3-dev
```

### Repository

Clone this repository:

```sh
cd /root
git clone https://git.ubicast.net/sys/ansible-public.git
cd ansible-public
```

### Python and ansible

Create a virtual environment with [Python's venv](https://docs.python.org/3/library/venv.html) and install Ansible in it:

```sh
# create the venv
apt install -y python3-venv
python3 -m venv ansible-venv

# activate the venv
source ansible-venv/bin/activate

# install ansible requirements
python3 -m pip install -U pip wheel
python3 -m pip install -r requirements.txt
```

## Testing

To make sure Ansible is properly installed, run this command:

```sh
# verify ansible version
ansible --version

ansible X.X.X
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /root/ansible-public/ansible-venv/lib/python3.X/site-packages/ansible
  executable location = /root/ansible-public/ansible-venv/bin/ansible
  python version = 3.X.X (default, ...)
```
