sudo chmod 666 /etc/hosts
mkdir ~/.secrets 
touch ~/.secrets/dockerhub-cred
touch ~/.secrets/github-token
touch ~/.secrets/slack-botduty-webhook 
chmod 600 ~/.secrets/* 

curl -s https://fluxcd.io/install.sh | sudo bash