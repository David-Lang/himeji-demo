FORMATTED_TOKEN="Token token=\"$(cat artifacts/admin-token)\""

curl --insecure --silent --request POST 'https://conjur.myorg.com/policies/default/policy/root' \
     --header 'X-Request-Id: <string>' \
     --header 'Content-Type: text/plain' \
     --header "Authorization: $FORMATTED_TOKEN" \
     --data-binary "@policy/policy-app-k8s-host.yml" \
     > artifacts/app-k8-host-cred

curl --insecure --silent --request POST 'https://conjur.myorg.com/policies/default/policy/root' \
     --header 'X-Request-Id: <string>' \
     --header 'Content-Type: text/plain' \
     --header "Authorization: $FORMATTED_TOKEN" \
     --data-binary "@policy/policy-app-secrets.yml" \
     > artifacts/app-k8-devops-admin-cred

curl --insecure --request POST 'https://conjur.myorg.com/secrets/default/variable/demo-app/github_cred' \
     --header 'X-Request-Id: <string>' \
     --header 'Content-Type: application/octet-stream' \
     --header "Authorization: $FORMATTED_TOKEN" \
     --data-raw "github_cred-secret--data-raw 'github_cred-secret'" 

curl --insecure --request POST 'https://conjur.myorg.com/secrets/default/variable/demo-app/dockerhub_cred' \
     --header 'X-Request-Id: <string>' \
     --header 'Content-Type: application/octet-stream' \
     --header "Authorization: $FORMATTED_TOKEN" \
     --data-binary "@/opt/himeji/secrets/dockerhub-cred" 

curl --insecure --request POST 'https://conjur.myorg.com/secrets/default/variable/demo-app/slack_botduty_webhook' \
     --header 'X-Request-Id: <string>' \
     --header 'Content-Type: application/octet-stream' \
     --header "Authorization: $FORMATTED_TOKEN" \
     --data-binary "@/opt/himeji/secrets/slack-botduty-webhook" 
