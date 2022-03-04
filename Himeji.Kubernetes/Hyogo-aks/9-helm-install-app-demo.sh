
./scripts/fetch_himeji-repo.sh

helm install app-demo artifacts/himeji-demo/Himeji-WebApi/Helm-Charts/release-0.3.0/himeji/ -n app-demo --debug

