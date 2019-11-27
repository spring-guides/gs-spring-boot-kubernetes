Before you can start, you need to install and start the Kubernetes cluster.

## Install Kubectl

[Kubectl](https://github.com/kubernetes/kubectl) is the command line for Kubernetes. You can install it from Google storage:

`curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kubectl && chmod +x /usr/local/bin/kubectl
`{{execute}}

# Create a Cluster with Kind

[Kind](https://github.com/kubernetes-sigs/kind) is a tool for running Kubernetes in docker. It works well for integration testing, or for simple development-time use cases, where resources are constrained. You can install it from github:

`curl -Lo /usr/local/bin/kind https://github.com/kubernetes-sigs/kind/releases/download/v0.5.1/kind-linux-amd64 && chmod +x /usr/local/bin/kind`{{execute}}

and run it to create a (single node) Kubernetes cluster:

`kind create cluster`{{execute}}

Then set up the credentials to connect to to the cluster:

`mkdir -p ~/.kube && kind get kubeconfig > ~/.kube/config`{{execute}}

Check that it works:

`kubectl get all`{{execute}}

```
NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/kubernetes   ClusterIP   10.43.0.1       <none>        443/TCP    2d18h
```

Now we can deploy our Spring Boot application.