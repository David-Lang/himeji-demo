
helm uninstall app-demo -n app-demo                 
helm uninstall app-demo-namespace-prep -n app-demo       
helm uninstall cluster-prep -n cyberark-conjur                  
helm uninstall conjur-oss -n conjur-oss                    
helm uninstall flux-app-demo-namespace-prep -n flux-app-demo  
helm uninstall himeji -n flux-app-demo

helm list --all --all-namespaces

kubectl delete namespace app-demo
kubectl delete namespace cyberark-conjur
kubectl delete namespace conjur-oss
kubectl delete namespace flux-app-demo
kubectl delete namespace flux
