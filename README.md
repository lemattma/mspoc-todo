# Rails API + Kubernetes setup

## Dockerize the app

```bash
docker login
rake docker:push_image
```

## Cluster Setup

* https://kubernetes.io/docs/concepts/
* https://www.monkeyvault.net/rails-on-kubernetes-part-2/
* https://kubernetes.github.io/ingress-nginx/troubleshooting/
* https://cloud.google.com/blog/products/containers-kubernetes/your-guide-kubernetes-best-practices
* https://learnk8s.io/production-best-practices
* https://medium.com/@zwhitchcox/matchlabels-labels-and-selectors-explained-in-detail-for-beginners-d421bdd05362

```bash
minikube start

# initialise the namespace
kubectl create -f infrastructure/namespace/mspoc-todo/namespace.yml

# secrets
kubectl -n mspoc-todo create secret generic db-user --from-literal=username=postgres
kubectl -n mspoc-todo create secret generic secret-key-base --from-literal=secret-key-base=85d6555b10f75f61e8191b81d12c38ce37cefbaa24d62d9482ec1b1572f2901983328caca581d4fc731b9591b17d72e37e0e3662b24c0c2d07eadaa19182122e

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
# kubectl -n mspoc-todo delete pods -l app=mspoc-todo-app
```

Questions:

* what's spec?
* what's template?
* how to restart the ingress?
* best practices on selectors? app, tier?
* best practices on namespaces?
* best practices on secrets and config?
