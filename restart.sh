#!/usr/bin/env bash
cd -- "$(dirname "$BASH_SOURCE")"

./stop.sh
./build.sh
./run.sh
x

