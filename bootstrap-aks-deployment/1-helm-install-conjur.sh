echo "Helm install conjur-oss starting" 

helm repo add cyberark https://cyberark.github.io/helm-charts

CONJUR_NAMESPACE=conjur-oss
DATA_KEY="$(sudo docker run --rm cyberark/conjur data-key generate)"
HELM_RELEASE=conjur-oss
AUTHENTICATORS="authn\,authn-k8s/dev-cluster"
LOG_LEVEL="debug"

echo "$DATA_KEY" > artifacts/datakey-used 

kubectl create namespace $CONJUR_NAMESPACE

helm install -n "$CONJUR_NAMESPACE" \
--set dataKey="$DATA_KEY" \
--set logLevel="$LOG_LEVEL" \
--set authenticators="$AUTHENTICATORS" \
"$HELM_RELEASE" \
cyberark/conjur-oss

# Install pg-admin as pod
kubectl apply -n conjur-oss -f manifests/pg-admin.yml

POD_NAME=$(kubectl get pods --namespace conjur-oss \
         -l "app=conjur-oss,release=conjur-oss" \
         -o jsonpath="{.items[0].metadata.name}")

printf "\nwaiting 70 seconds for $POD_NAME ready\n"
sleep 70

kubectl exec --namespace conjur-oss conjur-oss-postgres-0 -- env | grep POSTGRES_PASSWORD > artifacts/postgres-cred
kubectl get svc --namespace conjur-oss >> artifacts/postgres-cred

kubectl exec --namespace conjur-oss $POD_NAME --container=conjur-oss -- conjurctl account create "default" | tail -1 > artifacts/admin-cred
