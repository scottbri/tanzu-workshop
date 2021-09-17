
export WORKSHOP_ID="CHANGEME"
export TMC_API_TOKEN="CHANGEME"

export SECRETKEY="CHANGEME"

export GITEMAIL="CHANGEME"
export GITNAME="CHANGEME"

export HARBOR_USER="cody"                 
export HARBOR_PASS="VMware1!"             # <<----- Change this only if desired

export PATH=$PATH:${HOME}/bin
export EXTENSION_BUNDLE="tkg-extensions-v1.3.1+vmware.1"
export EXTENSIONS="${EXTENSION_BUNDLE}/extensions"
export KUBECONFIG="${HOME}/.kube/config"

export ISSUER_REF="lab-cluster-issuer"

export BASE_DOMAIN="lab.bekind.io"
export DOMAIN="${WORKSHOP_ID}.${BASE_DOMAIN}"
export ZONEID="Z04408743JTEV2MFZLFYP"
export ACCESSKEY="AKIARPBECU6BBXNN5L44"

export HARBOR_CN="harbor.${DOMAIN}"
export NOTARY_CN="notary.${HARBOR_CN}"
export HARBOR_PASSWORD="VMware1!"         # <<----- Change this for admin only if desired
export HARBOR_GB="50Gi"
export CLAIR_ENABLED=false

git config --global user.email "$GITEMAIL"
git config --global user.name "$GITNAME"

###################
## Build your docker config to enable login to registries 
###################

echo "In preparation for the Tanzu Build Service portion of the workshop"
echo " we need to capture your registry.pivotal.io credentials."
read -p "Do you have your registry.pivotal.io credentials? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "What is your network.pivotal.io username (email)?"
	read INPUT
	export TANZUNET_USER="${INPUT}"

	echo ""
	echo "What is your network.pivotal.io password (password hidden)?"
	read -s INPUT
	export TANZUNET_PASS="${INPUT}"
fi
echo ""

