set -e

CLUSTER=${1:-lab${RANDOM}}

if [[ x${VSPHERE_CONTROL_PLANE_ENDPOINT} == "x" ]]
then
   echo "ERROR:  Set VSPHERE_CONTROL_PLANE_ENDPOINT with the IP address of the KubeVIP for the cluster"
   exit 1
fi


echo "Using cluster name ${CLUSTER} with IP address ${VSPHERE_CONTROL_PLANE_ENDPOINT}"
read -p "Do you want to continue? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
#	PUBLIC_SUBNET_ID=subnet-084ef6790faa5b919

	cp -r template-small ${CLUSTER}
	#mv ${CLUSTER}/config-cluster.yaml ${CLUSTER}/config-${CLUSTER}.yaml
	cat ${CLUSTER}/config-cluster.yaml |  sed -e "s/CHANGEME_ENDPOINT/$VSPHERE_CONTROL_PLANE_ENDPOINT/"  > ${CLUSTER}/config-${CLUSTER}.yaml

#	aws ec2 create-tags --resources ${PUBLIC_SUBNET_ID} --tags Key=kubernetes.io/cluster/${CLUSTER},Value=shared

	tanzu cluster create ${CLUSTER} -v 9  --file ${CLUSTER}/config-${CLUSTER}.yaml

	tanzu cluster kubeconfig get ${CLUSTER} --admin --export-file ${CLUSTER}/kubeconfig-${CLUSTER}.yaml

fi
