# Replication Package for the JSONSchemaDiscovery and the experiments in the paper
# "An Approach for Schema Extraction of JSON and Extended JSON Document Collections"

# Copyright 2024, Konrad Drees <drees03@ads.uni-passau.de>
# SPDX-License-Identifier: GPL-2.0-only


FROM ubuntu:20.04

MAINTAINER Konrad Drees <drees03@ads.uni-passau.de>
LABEL authors="konraddrees" 

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"


RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    gnupg \
    git \
    file \
    nano \
    python3 \
    python3-pip \
    python3-dev \
    python3-setuptools \
    python3-venv \
    sudo \
	tcl-dev \
	time \
	texlive-base \
	texlive-bibtex-extra \
	texlive-fonts-recommended \
	texlive-plain-generic \
	texlive-latex-extra \
	texlive-publishers


# Install Node, TypeScript and Angular CLI
RUN curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
RUN apt-get install -y nodejs
RUN npm install -g @angular/cli
RUN npm install -g typescript



# Clone and build JSONSchemaDiscovery
RUN useradd -m -G sudo -s /bin/bash repro && echo "repro:repro" | chpasswd
USER repro
WORKDIR /home/repro
RUN mkdir -p $HOME/git-repos $HOME/build $HOME/bin
WORKDIR /home/repro/git-repos
RUN git clone https://github.com/feekosta/JSONSchemaDiscovery.git
WORKDIR /home/repro/git-repos/JSONSchemaDiscovery
RUN npm install
RUN npm run predev


# Apply the patches from the patches directory
COPY patches/json-discovery.patch /home/repro/git-repos/JSONSchemaDiscovery/
RUN git apply /home/repro/git-repos/JSONSchemaDiscovery/json-discovery.patch

# Install Python requirements
COPY patches/requirements.txt /home/repro/git-repos/JSONSchemaDiscovery/
RUN python3 -m pip install --user -r /home/repro/git-repos/JSONSchemaDiscovery/requirements.txt





CMD ["npm", "run", "dev"]









