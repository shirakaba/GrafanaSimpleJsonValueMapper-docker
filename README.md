# GrafanaSimpleJsonValueMapper-docker
Docker container for setting up [GrafanaSimpleJsonValueMapper](https://github.com/CymaticLabs/GrafanaSimpleJsonValueMapper).

# Setup

First, download this repository (either as a `.zip` – in which case you'll need to subsequently unzip it of course – or by using `git clone`). Open and/or `cd` into the repository.

## Providing your own aliases

Edit the `data.json` file in this repository. This will be copied into the Docker container, in place of the `server/data.json` that `GrafanaSimpleValueMapper` reads from.

Any time you edit the `data.json` file, you'll need to rebuild the Docker container; there is nothing like hot-module replacement involved.

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

## Killing/removing the container

You can view all running Docker containers with `docker ps` and kill them by their container name manually, or use this [automatic command](https://stackoverflow.com/a/32074098/5951226):

```sh
docker stop $(docker ps -a -q --filter="ancestor=jsonmapper" --format="{{.ID}}")
```

You can furthermore remove it in the same step by wrapping the command with a `docker rm`:

```sh
docker rm $(docker stop $(docker ps -a -q --filter="ancestor=jsonmapper" --format="{{.ID}}"))
```

## Restarting the container

Simply run `restart.sh`. You may need to give it executable permissions with `chmod +x restart.sh` beforehand.

This command will stop any running instances, rebuild them, then run them again (in detached mode).

# Usage

Once the Docker container is running, run `curl "http://localhost:3003"` (where `3003` is the port you mapped it to on your **host**) to assess whether you can connect to it. It should respond with a simple landing web-page (in HTML format).

Following the installation steps from the [GrafanaSimpleJsonValueMapper readme](https://github.com/CymaticLabs/GrafanaSimpleJsonValueMapper), complete the **[Configure a SimpleJson datasource](https://github.com/CymaticLabs/GrafanaSimpleJsonValueMapper#configure-a-simplejson-datasource)** step.

You can test whether your server is running & responding with the following curl:

```bash
curl 'http://localhost:3003/search' \
 -H 'Content-Type: application/json' \
 -H 'Accept: application/json, text/plain, */*' \
 -H 'DNT: 1' --data-binary '{"target":"{\"data\":\"list\", \"id\":\"value1\"}"}' --compressed \
 && echo;
```

... This forms the request:

```bash
{ data: 'list', id: 'value1' }
```

... Which should generate a response resembling this (note: I can't recall whether a single-value payload for `text` will return an array or just a single string; would have to go back and check):

```bash
[ { text: [ 'value1' ], value: 'value1' } ]
```

You can then test the `GrafanaSimpleJsonValueMapper` server by following the **[Creating Template Variables](https://github.com/CymaticLabs/GrafanaSimpleJsonValueMapper#creating-template-variables)** step.

