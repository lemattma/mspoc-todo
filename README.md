# Rails API + Kubernetes setup

## Dockerize the app

```bash
docker login
rake docker:push_image
```

## Cluster Setup
```bash
minikube start

# any better way to do this?
kubectl -n mspoc-todo create secret generic db-user --from-literal=username=postgres
kubectl -n mspoc-todo create secret generic secret-key-base --from-literal=secret-key-base=85d6555b10f75f61e8191b81d12c38ce37cefbaa24d62d9482ec1b1572f2901983328caca581d4fc731b9591b17d72e37e0e3662b24c0c2d07eadaa19182122e

# initialise the namespace
# when's good to use a namespace
kubectl create -f infrastructure/namespace/mspoc-todo/namespace.yml

# volume and postgres TODO: Terraform
kubectl create -f infrastructure/namespace/mspoc-todo/mspoc-todo-postgres-volume.yml
kubectl create -f infrastructure/namespace/mspoc-todo/mspoc-todo-postgres.yml

# db migration
kubectl create -f infrastructure/namespace/mspoc-todo/mspoc-todo-setup.yml

# main service and deployment
kubectl create -f infrastructure/namespace/mspoc-todo/mspoc-todo.yml

# route request to the main service
kubectl create -f infrastructure/namespace/mspoc-todo/mspoc-todo-ingress.yml

# add the ip to hosts file
minikube ip

# troubleshoot ingress
# why is this in the kube-system namespace when we set it to mspoc-todo
kubectl -n kube-system get pods
kubectl -n kube-system logs nginx-ingress-controller-6fc5bcc8c9-j2xz2

# misc commands
# kubectl get all
# kubectl logs xxx
# kubectl describe ing
# kubectl get ing
# minikube ip

```