
kubectl create namespace app-demo


#/* Helm install failed on look up values from golden config map
helm install namespace-prep cyberark/conjur-config-namespace-prep -n "app-demo" \
  --set authnK8s.namespace="cyberark-conjur" \
  --set authnK8s.goldenConfigMap="conjur-configmap" 
#*/



 #--- Used raw manifest instead of helm

 k apply -f namespace-prep.yml -n app-demo --dry-run=client

 #---

 ---
# Source: conjur-config-namespace-prep/templates/conjur_connect_configmap.yaml
# The Conjur Connection ConfigMap contains references to Conjur credentials,
# taken from the "Golden ConfigMap". These can be used to enable Conjur
# authentication for applications to retrieve secrets securely.
apiVersion: v1
kind: ConfigMap
metadata:
  name: conjur-connect
  labels:
    app.kubernetes.io/name: "conjur-connect-configmap"
    app.kubernetes.io/instance: "conjur-default-configmap"
    app.kubernetes.io/part-of: "conjur-config"
    conjur.org/name: "conjur-connect-configmap"
data:
  CONJUR_ACCOUNT: default
  CONJUR_APPLIANCE_URL: https://conjur.myorg.com
  CONJUR_AUTHN_URL: https://conjur.myorg.com/authn-k8s/dev-cluster
  CONJUR_SSL_CERTIFICATE: |- 
    EDIT-TO-HAVE-CONTENTS-conjur-cert.pem
  CONJUR_AUTHENTICATOR_ID: dev-cluster
---
# Source: conjur-config-namespace-prep/templates/authenticator_rolebinding.yaml
# The Authenticator RoleBinding grants permissions to the Conjur Authenticator ServiceAccount
# for the authenticator ClusterRole, which provides a list of Kubernetes API access permissions.
# This is required to validate application identities.
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: conjur-rolebinding
  labels:
    app.kubernetes.io/name: "conjur-rolebinding"
    app.kubernetes.io/component: "conjur-namespace-access"
    app.kubernetes.io/instance: "conjur-default-rolebinding"
    app.kubernetes.io/part-of: "conjur-config"
    conjur.org/name: "conjur-rolebinding"
subjects:
- kind: ServiceAccount
  name: conjur-serviceaccount
  namespace: conjur-oss
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: conjur-clusterrole
