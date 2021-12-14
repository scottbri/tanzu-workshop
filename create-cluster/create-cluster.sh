set -e

CLUSTER=${1:-lab${RANDOM}}


echo "Using cluster name ${CLUSTER} with IP address ${VSPHERE_CONTROL_PLANE_ENDPOINT}"
read -p "Do you want to continue? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
#	PUBLIC_SUBNET_ID=subnet-084ef6790faa5b919

	cp -r template-small ${CLUSTER}
	mv ${CLUSTER}/config-cluster.yaml ${CLUSTER}/config-${CLUSTER}.yaml

#	aws ec2 create-tags --resources ${PUBLIC_SUBNET_ID} --tags Key=kubernetes.io/cluster/${CLUSTER},Value=shared

	tanzu cluster create ${CLUSTER} -v 9  --file ${CLUSTER}/config-${CLUSTER}.yaml

	tanzu cluster kubeconfig get ${CLUSTER} --admin --export-file ${CLUSTER}/kubeconfig-${CLUSTER}.yaml

fi
