@echo off

set TEMPKUBE=temp-kube-config.yaml
set YAMLURL="https://raw.githubusercontent.com/scottbri/tanzu-workshop/main/tshell/tshell.yaml"

kubectl config view --raw > %TEMPKUBE%

echo -
echo Ensure tshell namespace and pod are created on cluster
kubectl create -f "%YAMLURL%" 

echo -
echo When tshell pod is Running.  Hit ctrl-c to continue.
echo Type N at the prompt.  Do not cancel the bash script.
kubectl -n tshell get pod/tshell -w

echo Copy KUBECONFIG to tshell
kubectl cp %TEMPKUBE% tshell/tshell:/home/tanzu/.kube/config

echo -
echo Launch bash in the tshell
echo Command reference: kubectl -n tshell exec tshell -it -- bash"
kubectl -n tshell exec tshell -it -- bash

del %TEMPKUBE%
