#!/bin/bash

export IMG_NAME="jammy"

multipass launch ${IMG_NAME} -n k3s-server --cloud-init common.yaml
multipass launch ${IMG_NAME} -n k3s-node1 --cloud-init common.yaml
multipass launch ${IMG_NAME} -n k3s-node2 --cloud-init common.yaml
multipass launch ${IMG_NAME} -n k3s-node3 --cloud-init common.yaml

multipass info k3s-server

