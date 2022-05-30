# Kubernetes Dashboard

Kubernetes does not provide a nice UI installed by default.

### Installation

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.1/aio/deploy/recommended.yaml
kubectl apply -f admin-user.yaml
```

### Get Token

```bash
kubectl -n kubernetes-dashboard describe secret admin-user-token | grep '^token'
```

### Start Proxy

```bash
kubectl proxy
```