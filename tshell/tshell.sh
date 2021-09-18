#!/bin/bash

TEMPKUBE=temp-kube-config.yaml
YAMLURL="https://raw.githubusercontent.com/scottbri/tanzu-workshop/main/tshell/tshell.yaml"

kubectl config view --raw > $TEMPKUBE

echo "Ensure tshell namespace and pod are created on cluster"
kubectl create -f "$YAMLURL"

echo "When tshell pod is Running.  Hit <ctrl>-c to continue"
kubectl -n tshell get pod/tshell -w

echo "Copy KUBECONFIG to tshell"
kubectl cp $TEMPKUBE tshell/tshell:/home/tanzu/.kube/config

echo "Launch bash in the tshell"
echo "Command reference: kubectl -n tshell exec tshell -it -- bash"
kubectl -n tshell exec tshell -it -- bash

rm $TEMPKUBE
