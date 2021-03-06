echo "Flux bootstrap install starting" 

export GITHUB_TOKEN="$(cat ~/.secrets/github-token)"

flux bootstrap github \
  --owner=david-lang \
  --repository=flux-demo \
  --branch=master \
  --path=./clusters/my-cluster \
  --personal