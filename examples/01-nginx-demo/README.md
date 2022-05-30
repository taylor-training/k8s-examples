# Nginx Deployment

## Code Review

Review `nginx-deploy.yaml` file.

## Installation

```bash
kubectl apply -f nginx-deploy.yaml
```

## Deployment Status

Check the status within Kubernetes:

```bash
kubectl get pods # all pods (default namespace)
kubectl get services # all services
kubectl get deployments # all deployments
```

## Updates

Make adjustments to yaml file, re-apply same file.

## Clean Up

```bash
kubectl delete -f nginx-deploy.yaml
```