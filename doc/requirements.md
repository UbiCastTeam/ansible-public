# Prepare deployment environment

This installation has only been tested on Linux. But it should (with some adjustements) work for MacOS or Windows WSL.  
There are 2 installations possibilities : 
- setup tools
- docker image

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
python3 -m venv .venv

# activate the venv
source .venv/bin/activate

# install ansible requirements
python3 -m pip install -U pip wheel
python3 -m pip install -r requirements.txt

# install galaxy requirements
ansible-galaxy install -r requirements.yml

```

## Docker

If you do not want to bother with tools installation, you can use [Docker](https://docs.docker.com/install/).

```sh
docker run \
  `# run an interactive pseudo-TTY` \
  -it \
  `# remove the container once you leave it` \
  --rm \
  `# share the current directory` \
  -v $(pwd):/workspace \
  `# share your SSH configuration` \
  -v $HOME/.ssh:/home/code/.ssh:ro \
  `# share your SSH agent` \
  -v $SSH_AUTH_SOCK:/ssh-agent:ro \
  `# let container know where is mapped the SSH agent` \
  -e SSH_AUTH_SOCK=/ssh-agent \
  `# container image to use` \
  registry.ubicast.net/sys/ansible-public \
  `# executable to run` \
  bash
```

Make sur to share your SSH configuration with the Docker container, this may require to adapt the example command.

## Testing

To make sure Ansible is properly installed, run this command:

```sh
# verfiy ansible version
ansible --version

ansible 2.9.18
  config file = None
  configured module search path = ['/home/ubicast/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/ubicast/.local/lib/python3.7/site-packages/ansible
  executable location = /home/ubicast/.local/bin/ansible
  python version = 3.7.3 (default, Jan 22 2021, 20:04:44) [GCC 8.3.0]
```
