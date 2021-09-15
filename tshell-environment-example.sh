
export WORKSHOP_ID="CHANGEME"
export TMC_API_TOKEN="CHANGEME"

export SECRETKEY="CHANGEME"

export GITEMAIL="CHANGEME"
export GITNAME="CHANGEME"


export EXTENSION_BUNDLE="tkg-extensions-v1.3.1+vmware.1"
export EXTENSIONS="${EXTENSION_BUNDLE}/extensions"
export KUBECONFIG="/home/${WORKSHOP_ID}/.kube/config"

export ISSUER_REF="lab-cluster-issuer"

export BASE_DOMAIN="lab.bekind.io"
export DOMAIN="${WORKSHOP_ID}.${BASE_DOMAIN}"
export ZONEID="Z04408743JTEV2MFZLFYP"
export ACCESSKEY="AKIARPBECU6BBXNN5L44"

export HARBOR_CN="harbor.${DOMAIN}"
export NOTARY_CN="notary.${HARBOR_CN}"
export HARBOR_PASSWORD="VMware1!"
export HARBOR_GB="50Gi"
export CLAIR_ENABLED=false


git config --global user.email "$GITEMAIL"
git config --global user.name "$GITNAME"

###################
## Build your docker config to enable login to registries 
###################
echo "What is your network.pivotal.io username (email)?"
read INPUT_USER
echo ""
echo "What is your network.pivotal.io password (password hidden)?"
read -s INPUT_PASS 

export TANZUNETAUTH=$(echo "${INPUT_USER}:${INPUT_PASS}" | base64)
unset INPUT_USER; unset INPUT_PASS

HARBORUSER="cody"                     # <<----- Change this if needed
HARBORPASSWORD="VMware1!"             # <<----- Change this if needed

export HARBORAUTH=$(echo "${HARBORUSER}:${HARBORPASSWORD}" | base64)
unset HARBORUSER; unset HARBORPASSWORD

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
