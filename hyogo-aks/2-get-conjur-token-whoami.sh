
ADMINKEY="$(cut -d ' ' -f 5 artifacts/admin-cred)"

curl --location --silent --insecure --request POST 'https://conjur.myorg.com/authn/default/admin/authenticate' \
     --header 'Accept-Encoding: base64' \
     --data-raw "$ADMINKEY" > artifacts/admin-token

FORMATTED_TOKEN="Token token=\"$(cat artifacts/admin-token)\""
#echo $FORMATTED_TOKEN

curl --location --silent --insecure --request GET 'https://conjur.myorg.com/whoami' \
     --header "Authorization: $FORMATTED_TOKEN" 

