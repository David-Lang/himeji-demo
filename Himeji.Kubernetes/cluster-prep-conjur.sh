# use conjur-config-cluster-prep repo readme and bin script to fetch .pem from running conjur
# from dir with .pem file 

# To use same namespace as installed conjure set k8s to conjur namespace (only valide if running single autheticator)
helm install cluster-prep cyberark/conjur-config-cluster-prep \
  --namespace conjur-helm-aks \
  --set conjur.account="default" \
  --set conjur.applianceUrl="https://conjur.myorg.com/" \
  --set conjur.certificateBase64="$(base64 -w0 conjur-cert.pem)" \
  --set authnK8s.authenticatorID="dev-cluster" \
  --set authnK8s.serviceAccount.name="authn-k8s-sa"



# The value for this variable should be identical to the name given to the policy ID above, excluding the conjur/ prefix.
# For example, to allowlist the conjur/authn-k8s/dev-cluster endpoint, allowlist authn-k8s/dev-cluster.

docker exec <conjur-container-name> export CONJUR_AUTHENTICATORS=authn-k8s/dev-cluster
