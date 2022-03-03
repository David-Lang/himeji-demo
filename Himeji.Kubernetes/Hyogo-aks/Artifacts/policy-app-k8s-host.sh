﻿---
# =================================================
# == App Policy
# =================================================
  - !host
    id: himeji-app
    annotations:
      authn-k8s/namespace: app-demo
      authn-k8s/service-account: himeji-app-serviceaccount
      authn-k8s/authentication-container-name: cyberark-secrets-provider-for-k8s

  - !grant
    roles: 
    - !group conjur/authn-k8s/dev-cluster/consumers
    members: 
    - !host himeji-app
