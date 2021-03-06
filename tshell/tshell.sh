#!/bin/bash
IMAGE=${1:-tkg} # or tce
TANZUPOD=tshell
NAMESPACE=tshell
TANZUPODYAML="${TANZUPOD}.yaml"

echo "Using latest $IMAGE image.  Specify tkg or tce as a parameter to choose."

cat > $TANZUPODYAML <<EOF
---
apiVersion: v1
kind: Pod
metadata:
  name: $TANZUPOD
  namespace: $NAMESPACE
spec:
  containers:
  - name: $TANZUPOD
    image: harbor.tanzu.bekind.io/demoapps/${IMAGE}-shell:latest
    args:
    - "sleep"
    - "1d"
EOF

kubectl create ns $NAMESPACE

# deploy tanzu shell
echo $TANZUPODYAML    | kubectl -n $NAMESPACE apply -f $TANZUPODYAML

while [[ $(kubectl -n $NAMESPACE get pod ${TANZUPOD} -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for pod" && sleep 3; done
echo "$TANZUPOD shell running"

echo "copying active KUBECONFIG file to shell"
kubectl -n $NAMESPACE cp $KUBECONFIG ${TANZUPOD}:/home/tanzu/.kube/config
#kubectl -n $NAMESPACE cp ~/.kube-tkg ${TANZUPOD}:/home/tanzu/

#echo "copying cluster configurations to shell"
#kubectl -n $NAMESPACE cp clusters ${TANZUPOD}:/home/tanzu/

echo "logging into ${TANZUPOD}"
echo "Command: kubectl -n $NAMESPACE exec -it ${TANZUPOD} -- bash "
echo "" ; echo ""
kubectl -n $NAMESPACE exec -it ${TANZUPOD} -- bash 

rm ${TANZUPOD}.yaml

