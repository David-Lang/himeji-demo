CONJUR_NAMESPACE="conjur-helm-aks"
HELM_RELEASE="conjur-oss"
AUTHENTICATORS="authn\,authn-k8s/dev-cluster"

helm upgrade \
   -n "$CONJUR_NAMESPACE" \
   --reuse-values \
   --set authenticators="$AUTHENTICATORS" \
   "$HELM_RELEASE" \
   ./conjur-oss
