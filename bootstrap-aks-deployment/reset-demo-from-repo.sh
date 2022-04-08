rm -rf tmp-repo
git clone https://github.com/David-Lang/himeji-demo.git tmp-repo

chmod 700 tmp-repo/deployment-aks/scripts/*.sh
chmod 700 tmp-repo/deployment-aks/*.sh

rm -rf deployment-aks/*
cp -r tmp-repo/deployment-aks/. deployment-aks
