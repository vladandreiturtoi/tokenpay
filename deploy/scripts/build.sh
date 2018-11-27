#!/usr/bin/env bash

docker build --pull . -f ./deploy/docker/Dockerfile -t $1
