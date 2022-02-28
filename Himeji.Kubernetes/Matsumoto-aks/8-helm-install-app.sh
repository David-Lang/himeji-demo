
git clone https://github.com/David-Lang/himeji-demo.git

helm install himeji-app himeji-demo/Himeji-WebApi/Helm-Charts/release-0.0.0/himeji-app/ -n app-demo --debug

helm upgrade himeji-app himeji-demo/Himeji-WebApi/Helm-Charts/release-0.1.0/himeji-app/ -n app-demo --debug
