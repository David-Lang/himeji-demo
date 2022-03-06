export GITHUB_TOKEN="$(cat /opt/himeji/secrets/github-token)"

flux bootstrap github \
  --owner=david-lang \
  --repository=flux-aks \
  --branch=master \
  --path=./clusters/my-cluster \
  --personal