echo "Helm install conjur-oss starting" 

CONJUR_NAMESPACE=conjur-oss
DATA_KEY="$(docker run --rm cyberark/conjur data-key generate)"
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

kubectl get svc --namespace conjur-oss > artifacts/svc-conjur-oss

# --- configure dns and host files
CONJUR_IP=$(cat artifacts/svc-conjur-oss | grep ingress | tr -s ' ' | cut -d ' ' -f 4) 

# update k8s core dns (only work with scratch installs !will remove any added config)
cp manifests/coredns-conjur-host.yml artifacts/coredns-conjur-host.yml
sed -i "s/1.2.3.4 conjur.myorg.com/$CONJUR_IP conjur.myorg.com/g" artifacts/coredns-conjur-host.yml 
kubectl apply -f artifacts/coredns-conjur-host.yml 
kubectl delete pod --namespace kube-system --selector k8s-app=kube-dns

# remove old conjur entry
grep -v "conjur.myorg.com" /etc/hosts > artifacts/hosts && cat artifacts/hosts > /etc/hosts

# add new conjur entry 
echo "$CONJUR_IP conjur.myorg.com" >> /etc/hosts

