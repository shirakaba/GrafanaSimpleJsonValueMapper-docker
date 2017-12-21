#!/usr/bin/env bash
cd -- "$(dirname "$BASH_SOURCE")"

sudo docker build . --tag=jsonmapper
