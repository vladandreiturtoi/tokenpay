#!/usr/bin/env bash

docker build --pull . -f ./deploy/Dockerfile -t $1
