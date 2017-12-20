# GrafanaSimpleJsonValueMapper-docker
Docker container for setting up [GrafanaSimpleJsonValueMapper](https://github.com/CymaticLabs/GrafanaSimpleJsonValueMapper).

# Setup

## Providing your own aliases

Edit the `data.json` file in this repository. This will be copied into the docker container, in place of the `server/data.json` that `GrafanaSimpleValueMapper` reads from.

## Building the container

*By default, the build command will fetch the `master` commit from the `GrafanaSimpleJsonValueMapper` repo.*

Run this script for the default build behaviour:

```sh
docker build . --tag=jsonmapper
```

To download a particular commit of `GrafanaSimpleJsonValueMapper` from a particular fork (eg. the `ce0999b342f4e8e861509e7ce3def5d9a7debf10` commit forked from my own GitHub account, `shirakaba`):

```sh
docker build . --build-arg ORG=shirakaba --build-arg COMMIT=ce0999b342f4e8e861509e7ce3def5d9a7debf10 --tag=jsonmapper
```

## Running the container

*Note that these commands assume you have built the Docker container using the tag `jsonmapper`. The default command run by the Docker container upon startup is `npm run start`.*

To run as a detached (background) process that maps the Docker container's port `3003` to the same port on the host machine:

```sh
docker run -d --rm -p 3003:3003 jsonmapper
```

You can change the above command to map the Docker container's port `3003` to a port of your choosing on the host machine (eg. `3004`) by replacing the port mapping value `3003:3003` with `3004:3003`.

To override the default command with your own (eg. to run the shell), just add further arguments of the command to run:

```sh
docker run -it --rm -p 3003:3003 jsonmapper sh
```

## Killing the container

You can view all running Docker containers with `docker ps`. If the tag for your container is indeed `jsonmapper`, you can kill it with:

```sh
docker kill jsonmapper
```
