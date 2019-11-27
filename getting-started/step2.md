Create a `Dockerfile` by running this command:

<pre><code class="execute">cat > Dockerfile << EOF
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

Then build the container image, giving it a tag (choose your own ID instead of "springguides" if you are going to push to Dockerhub):

`docker build -t springguides/demo .`{{execute}}

You can run the container locally:

`docker run -p 8080:8080 springguides/demo`{{execute T1}}

and check that it works:

`curl localhost:8080/actuator/health`{{execute T2}}

Finish off by killing the container:

`echo "Send Ctrl+C to kill the container"`{{execute T1 interrupt}}

You won't be able to push the image unless you authenticate with Dockerhub (`docker login`), but there's an image there already that should work. If you were authenticated you could:

`docker push springguides/demo`

In real life the image needs to be pushed to Dockerhub (or some other accessible repository) because Kubernetes pulls the image from inside its Kubelets (nodes), which are not in general connected to the local docker daemon. For the purposes of this scenario you can omit the push and just use the image that is already there.

> NOTE: Just for testing, there are workarounds that make `docker push` work with an insecure local registry, for instance, but that is out of scope for this scenario.