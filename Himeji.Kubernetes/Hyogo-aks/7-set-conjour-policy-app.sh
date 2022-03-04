FORMATTED_TOKEN="Token token=\"$(cat artifacts/admin-token)\""

curl --insecure --silent --request POST 'https://conjur.myorg.com/policies/default/policy/root' \
--header 'X-Request-Id: <string>' \
--header 'Content-Type: text/plain' \
--header "Authorization: $FORMATTED_TOKEN" \
--data-binary "@policy/policy-app-k8s-host.yml" \
> artifacts/app-k8-host-cred

