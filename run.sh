#!/usr/bin/env bash
cd -- "$(dirname "$BASH_SOURCE")"
sudo docker run -d --rm -p 3003:3003 jsonmapper
