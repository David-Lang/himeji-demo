# extract value from k8s


TOKEN_SECRET_NAME = "$(kubectl get secrets -n conjur-helm-aks | grep 'authn-k8s-sa.*service-account-token' | head -n1 | awk '{print $1}')"

kubectl get secret $TOKEN_SECRET_NAME -n conjur-helm-aks --output='go-template={{ .data.token }}' | base64 --decode

# 