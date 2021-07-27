FROM registry.ubicast.net/docker/debian-dev:latest

# avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND noninteractive
# local pyvenv to avoid conflicts with system
ENV PYVENV ${HOME}/pyvenv
# add pyvenv to path
ENV PATH ${PYVENV}/bin:${PATH}

# copy requirement file
COPY requirements.dev.txt .

RUN \
    # install required tools
    sudo apt-get update && \
    sudo apt-get install -y libffi-dev libncurses5 libncursesw5 libssl-dev python3-netaddr && \
    # create pyvenv + install ansible tools
    python3 -m venv --system-site-packages ${PYVENV} && \
    pip install -U pip wheel && \
    pip install -r requirements.dev.txt && \
    # clean up
    sudo apt-get autoremove -y && \
    sudo apt-get clean -y && \
    sudo rm -rf /var/lib/apt/lists/* &&  \
    sudo rm requirements.dev.txt 

# switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND dialog
ENV HOME /root
USER root
