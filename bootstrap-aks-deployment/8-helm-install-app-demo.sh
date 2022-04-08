echo "Helm install app demo starting" 

./scripts/fetch_himeji-repo.sh

CONJUR_IP=$(cat artifacts/svc-conjur-oss | grep ingress | tr -s ' ' | cut -d ' ' -f 4) 
helm install app-demo artifacts/himeji-demo/charts/himeji/ -n app-demo --set conjur_ingress.ip="$CONJUR_IP"  --debug
