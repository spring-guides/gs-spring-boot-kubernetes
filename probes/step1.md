
Kubernetes has 3 types of probe. The most important are liveness and readiness. Not all apps need probes, and not all apps need readiness if they have a liveness probe. But in cases where both are present they would map naturally to `/actuator/info` (liveness) and `/actuator/health` (readiness). These endpoints are provided out of the box by the https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#production-ready-endpoints[Spring Boot Actuators] feature.

> NOTE: The `/health` and `/info` endpoints are actually the *only* actuators enabled and exposed over HTTP by default. You don't have to worry about the others until you want to use them.

If a readiness probe fails then the app is taken out of the load balancer rotation, and no more traffic is sent to it, until it passes again. It can continue to pass liveness checks the whole time it is out of rotation.

Open the `demo/pom.xml`{{open}} in the editor and add the actuator dependency:

<pre><code class="copy">&lt;dependency>
  &lt;groupId>org.springframework.boot&lt;/groupId>
  &lt;artifactId>spring-boot-starter-actuator&lt;/artifactId>
&lt;/dependency>
</code></pre>

In the terminal, pop into the `demo` director with `cd demo`{{execute}}. Build the app `./mvnw package`{{execute}}:

```
[INFO] Scanning for projects...
[INFO]
[INFO] --------------------------< com.example:demo >--------------------------
[INFO] Building demo 0.0.1-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
...

...
[INFO] Replacing main artifact with repackaged archive
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  40.807 s
[INFO] Finished at: 2019-11-27T14:00:53Z
[INFO] ------------------------------------------------------------------------
```

And build the container:

`docker build -t localhost/springguides/demo .`{{execute}}

> NOTE: There is a Docker (v2) registry running on `localhost`  port 80, just to make the tutorial work smoothly, and so you don't have to authenticate to Dockerhub. If you prefer to use Dockerhub just remove `localhost/` from the container labels (or insert another registry host instead of `localhost`).

You can test that the container is working:

`docker run -p 8080:8080 localhost/springguides/demo`{{execute}}

Sample output:

```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.2.1.RELEASE)

2019-11-27 10:13:54.838  INFO 1 --- [           main] com.example.demo.DemoApplication         : Starting DemoApplication on 051fa7c2fe52with PID 1 (/app started by root in /)
2019-11-27 10:13:54.842  INFO 1 --- [           main] com.example.demo.DemoApplication         : No active profile set, falling back to default profiles: default
2019-11-27 10:14:00.070  INFO 1 --- [           main] trationDelegate$BeanPostProcessorChecker : Bean 'org.springframework.transaction.annotation.ProxyTransactionManagementConfiguration' of type [org.springframework.transaction.annotation.ProxyTransactionManagementConfiguration] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)
2019-11-27 10:14:01.093  INFO 1 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 2 endpoint(s) beneath base path'/actuator'
2019-11-27 10:14:01.809  INFO 1 --- [           main] o.s.b.web.embedded.netty.NettyWebServer  : Netty started on port(s): 8080
2019-11-27 10:14:01.816  INFO 1 --- [           main] com.example.demo.DemoApplication         : Started DemoApplication in 1.793 seconds(JVM running for 2.061)
```

If the Actuator endpoints are there you can test with `curl localhost:8080/actuator/health`{{execute T2}}:

```
{"status":"UP"}
```

Once you are sure it is working you can kill the container:

`echo "Send Ctrl+C to kill the application"`{{execute T1 interrupt}}

And push it to the local registry:

`docker push localhost/springguides/demo`{{execute}}

Great! Now you have a container image in a local Docker registry. You are ready to deploy it to Kubernetes.