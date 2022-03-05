
kubectl create namespace app-demo

helm install namespace-prep cyberark/conjur-config-namespace-prep \
  --namespace "app-demo" \
  --set authnK8s.namespace="cyberark-conjur" \
  --set authnK8s.goldenConfigMap="conjur-configmap"

