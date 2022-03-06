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

openssl genrsa -out artifacts/ca.key 2048

openssl req -x509 -new -nodes -key artifacts/ca.key -sha1 -days 3650 -set_serial 0x0 -out artifacts/ca.cert \
  -subj "/CN=conjur.authn-k8s.$SERVICE_ID/OU=Conjur Kubernetes CA/O=$CONJUR_ACCOUNT" \
  -config <(echo "$CONFIG")

openssl x509 -in artifacts/ca.cert -text -noout

FORMATTED_TOKEN="Token token=\"$(cat artifacts/admin-token)\""

curl --insecure --request POST 'https://conjur.myorg.com/secrets/default/variable/conjur/authn-k8s/dev-cluster/ca/key' \
     --header 'X-Request-Id: <string>' \
     --header 'Content-Type: application/octet-stream' \
     --header "Authorization: $FORMATTED_TOKEN" \
     --data-binary "@artifacts/ca.key" 


curl --insecure --request POST 'https://conjur.myorg.com/secrets/default/variable/conjur/authn-k8s/dev-cluster/ca/cert' \
     --header 'X-Request-Id: <string>' \
     --header 'Content-Type: application/octet-stream' \
     --header "Authorization: $FORMATTED_TOKEN" \
     --data-binary "@artifacts/ca.cert"

