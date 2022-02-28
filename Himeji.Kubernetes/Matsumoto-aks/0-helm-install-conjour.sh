

# get latest helm client if needed 
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
#---------------------------

git clone https://github.com/cyberark/conjur-oss-helm-chart.git

#---------------------------

CONJUR_NAMESPACE=conjur-oss
DATA_KEY="$(docker run --rm cyberark/conjur data-key generate)"
HELM_RELEASE=conjur-oss
AUTHENTICATORS="authn\,authn-k8s/dev-cluster"
LOG_LEVEL="debug"
POSTGRES_PWD=$DATA_KEY

kubectl create namespace $CONJUR_NAMESPACE

helm install -n "$CONJUR_NAMESPACE" \
--set dataKey="$DATA_KEY" \
--set logLevel="$LOG_LEVEL" \
--set database.password="$POSTGRES_PWD" \
"$HELM_RELEASE" \
./conjur-oss-helm-chart/conjur-oss \
--dry-run

#---------------------------

 export POD_NAME=$(kubectl get pods --namespace conjur-oss \
                 -l "app=conjur-oss,release=conjur-oss" \
                 -o jsonpath="{.items[0].metadata.name}")

 kubectl exec --namespace conjur-oss \
              $POD_NAME \
              --container=conjur-oss \
              -- conjurctl account create "default" | tail -1

#----------------------------



#----------------------------
# Didn't use below here
#----------------------------
docker run --rm -it --entrypoint bash cyberark/conjur-cli:5

# conjur.account: default

conjur init -u https://conjur.myorg.com -a "default"

# Add host entry to bypass dns service
# C:\Windows\System32\drivers\etc\hosts
#  conjur.myorg.com

# note: .pem created
# Wrote certificate to /root/conjur-default.pem


docker run --rm -itd --mount src="/opt/cyberark/policy",target=/policy,type=bind --entrypoint bash cyberark/conjur-cli:5
docker ps
CONJURCLI_ID=76d5b8f1c1f5 

docker exec -i $CONJURCLI_ID conjur init -u https://conjur.myorg.com -a "default"
docker exec -i $CONJURCLI_ID conjur authn login -u admin -p xyz