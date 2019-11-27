
Quickly create a deployment manifest for the application on Kubernetes:

<pre><code class="execute">
kubectl create service clusterip demo --tcp=8080:8080 --dry-run -o yaml > deployment.yaml
echo --- >> deployment.yaml
kubectl create deployment demo --image localhost/springguides/demo --dry-run -o yaml | egrep -v status >> deployment.yaml
</code></pre>

Let's add some configuration to the deployment for probes, as would be typical for an app using Spring Boot actuators:

<pre><code class="execute">cat >> deployment.yaml &lt;&lt;EOF
        livenessProbe:
          httpGet:
            path: /actuator/info
            port: 8080
          initialDelaySeconds: 10
          periodSeconds: 3
        readinessProbe:
          httpGet:
            path: /actuator/health
            port: 8080
          initialDelaySeconds: 20
          periodSeconds: 10
EOF
</code></pre>

Then deploy to Kubernetes

`kubectl apply -f deployment.yaml`{{execute}}

and check the app is running 

`kubectl get all`{{execute}}

Sample output:

```
NAME                        READY   STATUS    RESTARTS   AGE
pod/demo-7b4cfc5767-24qgr   0/1     Running   0          6s

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/demo         ClusterIP   10.97.182.253   <none>        8080/TCP   7s
service/kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP    9m22s

NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/demo   0/1     1            0           7s

NAME                              DESIRED   CURRENT   READY   AGE
replicaset.apps/demo-7b4cfc5767   1         1         0       7s
master
```

Now we can connect to the application. First create an SSH tunnel:

`kubectl port-forward svc/demo 8080:8080`{{execute T1}}

and then you can verify that the app is running:

`curl localhost:8080/actuator/health`{{execute T2}}

```
{"status":"UP"}
```

That it! You have an application with probes (if the probes fail the app will not be running).