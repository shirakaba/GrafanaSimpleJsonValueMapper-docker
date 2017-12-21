#!/usr/bin/env bash
cd -- "$(dirname "$BASH_SOURCE")"

sudo docker stop $(sudo docker ps -a -q --filter="ancestor=jsonmapper" --format="{{.ID}}")
