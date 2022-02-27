CONJUR_NAMESPACE="conjur-helm-aks"
HELM_RELEASE="conjur-oss"
LOG_LEVEL="debug"
helm upgrade \
   -n "$CONJUR_NAMESPACE" \
   --reuse-values \
   --set logLevel="$LOG_LEVEL" \
   "$HELM_RELEASE" \
   ./conjur-oss