#!/usr/bin/env bash

sed -i "s/IMAGE_TAG/$1/g" $(pwd)/deploy/k8s/deployment.yaml

kubectl apply -f ./deploy/k8s --kubeconfig $KUBECONFIG
