$env:TANZUPOD="tshell"
$env:NAMESPACE=$env:TANZUPOD

$env:TANZUPODYAML=@"
apiVersion: v1
kind: Pod
metadata:
  name: $env:TANZUPOD
  namespace: $env:NAMESPACE
spec:
  containers:
  - name: $env:TANZUPOD
    image: harbor.tanzu.bekind.io/demoapps/tanzu-shell:latest
    args:
    - "sleep"
    - "1d"
"@

echo "Ensure namespace $env:NAMESPACE exists"
kubectl create ns $env:NAMESPACE

echo "Deploy tanzu shell"
echo ${env:TANZUPODYAML} | kubectl -n $env:NAMESPACE apply -f-

echo "Hit <ctrl>-c when pod is running"
kubectl get pod ${env:TANZUPOD} -w

echo "copying active KUBECONFIG file to shell"
kubectl cp ${env:KUBECONFIG} ${env:TANZUPOD}:/home/tanzu/.kube/config

#echo "copying cluster configurations to shell"
#kubectl cp clusters ${TANZUPOD}:/home/tanzu/

echo "logging into ${TANZUPOD}"
echo "Command reference: kubectl -n $NAMESPACE exec -it ${TANZUPOD} -- bash "
echo "" ; echo ""
kubectl exec -it ${env:TANZUPOD} -- bash 
