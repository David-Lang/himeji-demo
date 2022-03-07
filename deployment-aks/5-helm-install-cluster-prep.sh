echo "Helm install cluster prep starting" 

# use conjur-config-cluster-prep repo readme and bin script to fetch .pem from running conjur
# from dir with .pem file 

./scripts/get-conjur-cert.sh -v -s -f artifacts/conjur-cert.pem -u https://conjur.myorg.com 
 
# The same namespace as installed conjure can be used only if running a single autheticator
helm install cluster-prep cyberark/conjur-config-cluster-prep \
  --namespace cyberark-conjur \
  --create-namespace \
  --set conjur.account="default" \
  --set conjur.applianceUrl="https://conjur.myorg.com/" \
  --set conjur.certificateBase64="$(base64 -w0 artifacts/conjur-cert.pem)" \
  --set authnK8s.authenticatorID="dev-cluster" \
  --set authnK8s.serviceAccount.name="authn-k8s-sa"
