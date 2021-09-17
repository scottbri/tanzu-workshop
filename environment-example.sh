
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
echo " we need to set your docker credentials inside the tshell environment."
echo " Only proceed if you have your network.pivotal.io credentials and you"
echo " are sure you won't blow away important credentials on your local machine."
echo ""
echo "Are you logged into the tshell?"
read -p "Is it safe to overwrite your .docker/config.json credentials? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "What is your network.pivotal.io username (email)?"
	read INPUT_USER
	echo ""
	echo "What is your network.pivotal.io password (password hidden)?"
	read -s INPUT_PASS 
	echo "Captured your `echo -n $INPUT_PASS | wc -m` character password"

	export TANZUNETAUTH=$(echo -n "${INPUT_USER}:${INPUT_PASS}" | base64)
	export HARBORAUTH=$(echo -n "${HARBOR_USER}:${HARBOR_PASS}" | base64)

	echo ""
	echo "Writing your docker credentials to ~/.docker/config.json"
	mkdir -p ~/.docker 2>&1
	touch ~/.docker/config.json || echo "ERROR:  Can't create ~/.docker/config.json"
	cat > ~/.docker/config.json  <<EOF
{
    "auths": {
	"${HARBOR_CN}": {
	    "auth": "${HARBORAUTH}"
	},
	"registry.pivotal.io": {
	    "auth": "${TANZUNETAUTH}"
	}
    }
}
EOF
fi
echo ""

