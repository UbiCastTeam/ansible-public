FROM registry.ubicast.net/docker/dind-compose:latest

# Set locale
ENV LANG="C.UTF-8" LC_ALL="C.UTF-8" LANGUAGE="C.UTF-8"

# Copy requirement files
COPY requirements.txt .
COPY requirements.dev.txt .
COPY requirements.dev.apk.txt .

# Install required apk packages
RUN apk add $(grep -v '^#' requirements.dev.apk.txt | cut -d ' ' -f1 | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/ /g')

# Install ansible tools
RUN \
    pip install -U pip wheel && \
    pip install -r requirements.txt && \
    pip install -r requirements.dev.txt
