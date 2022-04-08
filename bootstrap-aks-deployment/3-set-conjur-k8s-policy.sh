echo "set conjur k8s policy starting" 

FORMATTED_TOKEN="Token token=\"$(cat artifacts/admin-token)\""

curl --insecure --request PUT 'https://conjur.myorg.com/policies/default/policy/root' \
--header 'X-Request-Id: <string>' \
--header 'Content-Type: text/plain' \
--header "Authorization: $FORMATTED_TOKEN" \
--data-binary "@policy/policy-k8s-authn.yml" 

