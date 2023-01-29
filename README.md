# Introduction
You can build the docker image using `docker build -t github-runner .`

To extend this runner (e.g. add more applications/dependencies), 
you can create your own docker container by using the one built above. 
You can use the following in a new docker file:
`FROM github-runner`

Run the github runner using: `docker-compose up -d` 
after placing the respective environment variables in the docker-compose.yml file
