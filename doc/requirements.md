# Prepare deployment environment

This installation has only been tested on Debian Linux.

## Setup tools

This installation is detailled for a Debian server. All the commands below are executed with **root rights**.

### Install tools

```
apt update 
apt upgrade -y
apt install -y vim git make gcc python3-dev
```

### Repository

Clone this repository on your computer:

```sh
cd /root
git clone https://git.ubicast.net/sys/ansible-public.git
cd ansible-public
```

### Python and ansible


To automatically create a temporary virtualenv: 
```
make venv
make install
make install-galaxy
```

If you want a permanent venv, create manually a virtual environment with [Python's venv](https://docs.python.org/3/library/venv.html) or with the package [virtualenv](https://virtualenv.pypa.io/en/stable/). 

```sh
# create the venv
apt-get install -y python3-venv
python3 -m venv ansible-venv

# activate the venv
source ansible-venv/bin/activate

# install ansible requirements
python3 -m pip install -U pip wheel
python3 -m pip install -r requirements.txt
```

If you plan to use the benchmark component, the following requirements are also needed:
```sh
# install galaxy requirements
ansible-galaxy install -r requirements.yml
```

## Testing

To make sure Ansible is properly installed, run this command:

```sh
# verfiy ansible version
ansible --version

ansible X.X.X
  config file = None
  configured module search path = ['/home/ubicast/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/ubicast/.local/lib/python3.X/site-packages/ansible
  executable location = /home/ubicast/.local/bin/ansible
  python version = 3.X.X (default, ...)
```
