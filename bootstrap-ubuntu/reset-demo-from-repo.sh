rm -rf tmp-repo
git clone https://github.com/David-Lang/himeji-demo.git tmp-repo

chmod 700 tmp-repo/bootstrap-aks-deployment/scripts/*.sh
chmod 700 tmp-repo/bootstrap-aks-deployment/*.sh

rm -rf bootstrap-aks-deployment/*
cp -r tmp-repo/bootstrap-aks-deployment/. bootstrap-aks-deployment