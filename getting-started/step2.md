Create a `Dockerfile` by running this command:

<pre><code class="execute">
cat > Dockerfile << EOF
FROM openjdk:8-jdk-alpine AS builder
WORKDIR target/dependency
ARG APPJAR=target/*.jar
COPY \${APPJAR} app.jar
RUN jar -xf ./app.jar

FROM openjdk:8-jre-alpine
VOLUME /tmp
ARG DEPENDENCY=target/dependency
COPY --from=builder \${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=builder \${DEPENDENCY}/META-INF /app/META-INF
COPY --from=builder \${DEPENDENCY}/BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","com.example.demo.DemoApplication"]
EOF
</code></pre>

Then build the container image, giving it a tag (choose your own ID instead of "localhost/springguides" if you are going to push to Dockerhub):

`docker build -t localhost/springguides/demo .`{{execute}}

You can run the container locally:

`docker run -p 8080:8080 localhost/springguides/demo`{{execute T1}}

Sample output:

```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.2.1.RELEASE)

2019-11-27 11:32:48.296  INFO 1 --- [           main] com.example.demo.DemoApplication         : Starting DemoApplication on 9f7d342794b4with PID 1 (/app started by root in /)
2019-11-27 11:32:48.313  INFO 1 --- [           main] com.example.demo.DemoApplication         : No active profile set, falling back to default profiles: default
2019-11-27 11:32:51.782  INFO 1 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 2 endpoint(s) beneath base path'/actuator'
2019-11-27 11:32:52.851  INFO 1 --- [           main] o.s.b.web.embedded.netty.NettyWebServer  : Netty started on port(s): 8080
2019-11-27 11:32:52.864  INFO 1 --- [           main] com.example.demo.DemoApplication         : Started DemoApplication in 5.662 seconds(JVM running for 6.273)
```

Check that it works:

`curl localhost:8080/actuator/health`{{execute T2}}

```
{"status":"UP"}
```

Finish off by killing the container:

`echo "Send Ctrl+C to kill the container"`{{execute T1 interrupt}}

> NOTE: In this tutorial environment, you will be able to push the image even though you did not authenticate with Dockerhub (`docker login`). If you are running locally you can change the image label and push to Dockerhub, or there's an image `springguides/demo` already there that should work if you want to skip this step.

`docker push localhost/springguides/demo`{{execute}}

The image needs to be pushed to Dockerhub (or some other accessible registry) because Kubernetes pulls the image from inside its Kubelets (nodes), which are not in general connected to the local docker daemon.
