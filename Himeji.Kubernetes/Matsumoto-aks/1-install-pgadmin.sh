﻿k apply -f pg-admin.yml


apiVersion: v1
kind: Pod
metadata:
  name: pgadmin-pod
  labels:
    app: pgadmin
    zone: prod
    version: v1
spec:
  containers:
  - name: pgadmin-ctr
    image: dpage/pgadmin4:latest
    ports:
    - containerPort: 80
    env:
      - name: PGADMIN_DEFAULT_EMAIL
        value: user@domain.com
      - name: PGADMIN_DEFAULT_PASSWORD
        value: SuperSecret
---
apiVersion: v1
kind: Service
metadata:
  name: pga-svc-lb
  labels:
    app: web
spec:
  type: LoadBalancer
  ports:
    - port: 8088
      targetPort: 80
  selector:
    app: pgadmin