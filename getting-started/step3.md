Before you can start, you need to install and start the Kubernetes cluster.

Check that you have a Kubernetes cluster running:

`kubectl get all`{{execute}}

```
NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/kubernetes   ClusterIP   10.43.0.1       <none>        443/TCP    2d18h
```

Now we can deploy our Spring Boot application.


You have a container that runs and exposes port 8080, so all you need to make Kubernetes run it is some YAML. To avoid having to look at or edit YAML, for now, you can ask `kubectl` to generate it for you. The only thing that might vary here is the `--image` name. If you deployed your container to your own repository, use its tag instead of this one:

`
kubectl create deployment demo --image=localhost/springguides/demo --dry-run -o=yaml > deployment.yaml`{{execute}}

`echo --- >> deployment.yaml`{{execute}}

`kubectl create service clusterip demo --tcp=8080:8080 --dry-run -o=yaml >> deployment.yaml
`{{execute}}

You can take the YAML generated above and edit it if you like, or you can just apply it:

`kubectl apply -f deployment.yaml`{{execute}}

```
deployment.apps/demo created
service/demo created
```

Check that the application is running:

`kubectl get all`{{execute}}

```
NAME                             READY     STATUS      RESTARTS   AGE
pod/demo-658b7f4997-qfw9l        1/1       Running     0          146m

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/kubernetes   ClusterIP   10.43.0.1       <none>        443/TCP    2d18h
service/demo         ClusterIP   10.43.138.213   <none>        8080/TCP   21h

NAME                   READY     UP-TO-DATE   AVAILABLE   AGE
deployment.apps/demo   1/1       1            1           21h

NAME                              DESIRED   CURRENT   READY     AGE
replicaset.apps/demo-658b7f4997   1         1         1         21h
d
```

> TIP: Keep doing `kubectl get all` until the demo pod shows its status as "Running".

Now you need to be able to connect to the application, which you have exposed as a Service in Kubernetes. One way to do that, which works great at development time, is to create an SSH tunnel:

`kubectl port-forward svc/demo 8080:8080`{{execute T1}}

then you can verify that the app is running:

`curl localhost:8080/actuator/health`{{execute T2}}

```
{"status":"UP"}
```