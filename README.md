# Qdemo

## About

Official NGINX docker image serving `html` directory

Bonus Windsurf/Claude GenAI magic

* "make the index page have a retro geocities style"

## Build/Push

```
docker build -t robjau/qdemo:latest --platform linux/amd64 .
docker push robjau/qdemo:latest
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

#### Access the App
`kubectl port-forward svc/qdemo -n qdemo 8000:80`



## Dockerhub

[https://hub.docker.com/r/robjau/qdemo](https://hub.docker.com/r/robjau/qdemo)