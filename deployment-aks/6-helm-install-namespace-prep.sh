echo "Helm install namespace prep starting" 

helm install app-demo-namespace-prep cyberark/conjur-config-namespace-prep \
  --namespace "app-demo" \
  --create-namespace \
  --set authnK8s.namespace="cyberark-conjur" \
  --set authnK8s.goldenConfigMap="conjur-configmap" 

  helm install flux-app-demo-namespace-prep cyberark/conjur-config-namespace-prep \
  --namespace "flux-app-demo" \
  --create-namespace \
  --set authnK8s.namespace="cyberark-conjur" \
  --set authnK8s.goldenConfigMap="conjur-configmap"
