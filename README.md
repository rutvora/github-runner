# Introduction
This repository helps you run your own (self-hosted) github runner in a docker container.  
The container is as minimal as possible, and will NOT contain most of the softwares you will need (gcc, g++, python etc).  
Ideally, you should extend this container (use the Dockerfile) to also install the applications you need

# Building the container
You can build the docker image using `docker build -t github-runner .`  
Preferable do this after you modified the Dockerfile to add instructions on installing the dependencies you need.

# Running the runner
Place the environmental variables in the `docker-compose.yml` file. You can generate the tokens from github by:
1. Click on your icon in github (top right corner)
2. Click on "Settings"
3. Click on "Developer Settings"
4. Click on "Personal Access Tokens"
5. Create a new token, paste it in the docker-compose file

Run the github runner using: `docker-compose up -d` 
