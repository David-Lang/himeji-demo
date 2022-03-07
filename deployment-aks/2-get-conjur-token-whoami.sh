echo "Get conjur token starting" 


kubectl get svc --namespace conjur-oss > artifacts/svc-conjur-oss

# --- configure dns and host files
CONJUR_IP=$(cat artifacts/svc-conjur-oss | grep ingress | tr -s ' ' | cut -d ' ' -f 4)

# remove old conjur entry
grep -v "conjur.myorg.com" /etc/hosts > artifacts/hosts && cat artifacts/hosts > /etc/hosts

# add new conjur entry 
echo "$CONJUR_IP conjur.myorg.com" >> /etc/hosts

# update k8s core dns (only work with scratch installs !will remove any added config)
cp manifests/coredns-conjur-host.yml artifacts/coredns-conjur-host.yml
sed -i "s/1.2.3.4 conjur.myorg.com/$CONJUR_IP conjur.myorg.com/g" artifacts/coredns-conjur-host.yml 
kubectl apply -f artifacts/coredns-conjur-host.yml 
kubectl rollout restart -n kube-system deployment/coredns 
#kubectl delete pod --namespace kube-system --selector k8s-app=kube-dns 

ADMINKEY="$(cut -d ' ' -f 5 artifacts/admin-cred)"

curl --location --silent --insecure --request POST 'https://conjur.myorg.com/authn/default/admin/authenticate' \
     --header 'Accept-Encoding: base64' \
     --data-raw "$ADMINKEY" > artifacts/admin-token

FORMATTED_TOKEN="Token token=\"$(cat artifacts/admin-token)\""
#echo $FORMATTED_TOKEN

curl --location --silent --insecure --request GET 'https://conjur.myorg.com/whoami' \
     --header "Authorization: $FORMATTED_TOKEN" 

