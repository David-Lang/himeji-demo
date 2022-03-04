# use conjur-config-cluster-prep repo readme and bin script to fetch .pem from running conjur
# from dir with .pem file 

 ./get-conjur-cert.sh -v -f conjur-cert.pem -u https://conjur.myorg.com 
 
# The same namespace as installed conjure can be used only if running a single autheticator
helm install cluster-prep cyberark/conjur-config-cluster-prep \
  --namespace cyberark-conjur \
  --create-namespace \
  --set conjur.account="default" \
  --set conjur.applianceUrl="https://conjur.myorg.com/" \
  --set conjur.certificateBase64="$(base64 -w0 conjur-cert.pem)" \
  --set authnK8s.authenticatorID="dev-cluster" \
  --set authnK8s.serviceAccount.name="authn-k8s-sa"

helm list --all --all-namespaces

# The value for this variable should be identical to the name given to the policy ID above, excluding the conjur/ prefix.
# use helm to allowlist the conjur/authn-k8s/dev-cluster endpoint, allowlist: authn-k8s/dev-cluster.

helm upgrade \
   -n "conjur-oss" \
   --reuse-values \
   --set authenticators="authn\,authn-k8s/dev-cluster" \
   "conjur-oss" \
   cyberark/conjur-oss
