# base image
FROM ubuntu:22.04

#input GitHub runner version argument
ARG RUNNER_VERSION="2.301.1"
ENV DEBIAN_FRONTEND=noninteractive

LABEL BaseImage="ubuntu:22.04"
LABEL RunnerVersion=${RUNNER_VERSION}

# install the packages and dependencies along with jq so we can parse JSON (add additional packages as necessary)
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y \
    curl wget jq git \
    && rm -rf /var/lib/apt/lists/*

# Add a non root user
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# Install Azure-cli (remove the sed command if you are on amd64 architecture)
# RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sed --expression='s/amd64/arm64/' | bash

# cd into the user directory, download and unzip the github actions runner
RUN cd /home/docker && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz \
    && rm ./actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz

# install some additional dependencies
RUN chown -R docker ~docker && /home/docker/actions-runner/bin/installdependencies.sh

# add over the start.sh script
ADD start.sh start.sh

# make the script executable
RUN chmod +x start.sh

# set the user to "docker" so all subsequent commands are run as the docker user
USER docker

# set the entrypoint to the start.sh script
ENTRYPOINT ["./start.sh"]
