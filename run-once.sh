#!/bin/bash

apt-get update
apt-get install -y python3-pip

make install
make build
make start
