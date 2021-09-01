
export EXTENSION_BUNDLE="tkg-extensions-v1.3.1+vmware.1"
export EXTENSIONS="${EXTENSION_BUNDLE}/extensions"

export DOMAIN="CHANGEME.lab.bekind.io"  # <<----- Change this
export ISSUER_REF="lab-cluster-issuer"

export ZONEID="Z04408743JTEV2MFZLFYP"
export ACCESSKEY="AKIARPBECU6BBXNN5L44"
export SECRETKEY="CHANGEME"            # <<----- Change this

export HARBOR_CN="harbor.${DOMAIN}"
export NOTARY_CN="notary.${HARBOR_CN}"
export HARBOR_PASSWORD="VMware1!"
export HARBOR_GB="50Gi"
export CLAIR_ENABLED=false

