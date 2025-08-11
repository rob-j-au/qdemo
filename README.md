# Qdemo

## About

Official NGINX docker image serving `html` directory

Bonus Windsurf/Claude GenAI magic

* "make the index page have a retro geocities style"

## Build/Push and Ready for GitOps Deploy

Based on Git Repository update, ArgoCD will Sync to the latest version and Deploy to the cluster

- Builds latest Docker Image
- Pushes to Docker Repository with SHA tag
- Update's Helm Values image tag to reflect new SHA

```
./deploy_latest.sh
```

## Local ArgoCD Deployment

Assumes an ArgoCD Server runing at

`https://kubernetes.default.svc`

#### Deploy qdemo

`kubectl create namespace qdemo`

`argocd login localhost:$ARGO_PORT`

```
argocd app create qdemo \
  --repo https://github.com/rob-j-au/qdemo \
  --path .cicd/helm/qdemo \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace qdemo
```

#### Sync the App

`argocd app sync qdemo`

#### Check the App Status
`argocd app get qdemo`

#### Access the App (Direct Service)
`kubectl port-forward svc/qdemo -n qdemo 8000:80`

#### Access the App (via NGINX Ingress with /etc/hosts entry)

[https://qdemo.minikube.local](https://qdemo.minikube.local)




## Dockerhub

[https://hub.docker.com/r/robjau/qdemo](https://hub.docker.com/r/robjau/qdemo)