# Conjur admin: In this step you create a private key (ca.key) and a root certificate (ca.cert). 
# The content of these files is stored in variables: 
# conjur/authn-k8s/<SERVICE_ID>/ca/key 
# conjur/authn-k8s/<SERVICE_ID>/ca/cert

SERVICE_ID=dev-cluster
CONJUR_ACCOUNT=default

CONFIG="
[ req ]
distinguished_name = dn
x509_extensions = v3_ca
[ dn ]
[ v3_ca ]
basicConstraints = critical,CA:TRUE
subjectKeyIdentifier   = hash
authorityKeyIdentifier = keyid:always,issuer:always
"

openssl genrsa -out ca.key 2048

openssl req -x509 -new -nodes -key ca.key -sha1 -days 3650 -set_serial 0x0 -out ca.cert \
  -subj "/CN=conjur.authn-k8s.$SERVICE_ID/OU=Conjur Kubernetes CA/O=$CONJUR_ACCOUNT" \
  -config <(echo "$CONFIG")

openssl x509 -in ca.cert -text -noout


#//----------------------------------------------------------------------------------
#Cmd line did not work used API to set variables, via postman
#echo unformated strings / no new lines

echo "$(cat ca.key)"
echo "$(cat ca.cert)"

#//----------------------------------------------------------------------------------

# Conjur CLI (Docker-based)
# CONJURCLI_ID=9bdd26895ca8 
# docker exec -i $CONJURCLI_ID conjur init -u https://conjur.myorg.com -a "default"
# docker exec -i $CONJURCLI_ID conjur authn login -u admin
# docker exec -it $CONJURCLI_ID /bin/bash

#cd /policy
#conjur variable value conjur/authn-k8s/dev-cluster/ca/key "$(cat ca.key)"
#conjur variable value conjur/authn-k8s/dev-cluster/ca/cert "$(cat ca.cert)"
