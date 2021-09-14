
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

