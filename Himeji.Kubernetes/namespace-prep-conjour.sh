


helm install namespace-prep cyberark/conjur-config-namespace-prep -n "himejijo" \
  --set authnK8s.goldenConfigMap="conjur-configmap" \
  --set authnK8s.namespace="conjur-helm-aks"
