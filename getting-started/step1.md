
> NOTE: A Kubernetes cluster will start for you in the terminal on the right (if you are on a phone or a small device, rotate it to landscape to see the terminal). When the prompt appears you can proceed with the tutorial.

The first thing we will do is create a Spring Boot application. If you have one you prefer to use already in github, you could clone it in the terminal (`git` and `java` are installed already). Or you can create an application from scratch using start.spring.io:

`curl https://start.spring.io/starter.tgz -d dependencies=webflux,actuator | tar -xzvf -`{{execute}}

You can then build the application: 

`./mvnw install`{{execute}}

> NOTE: It will take a couple of minutes the first time, but then once the dependencies are all cached it will be fast.

And you can see the result of the build. If the build was successful, you should see a JAR file, something like this:

`ls -l target/*.jar`{{execute}}

```
-rw-r--r-- 1 root root 19463334 Nov 15 11:54 target/demo-0.0.1-SNAPSHOT.jar
```

The JAR is executable:

`java -jar target/*.jar`{{execute T1}}

The app has some built in HTTP endpoints by virtue of the "actuator" dependency we added when we downloaded the project. So you will see something like this in the logs on startup:

```
...
2019-11-15 12:12:35.333  INFO 13912 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 2 endpoint(s) beneath base path '/actuator'
2019-11-15 12:12:36.448  INFO 13912 --- [           main] o.s.b.web.embedded.netty.NettyWebServer  : Netty started on port(s): 8080
...
```

So you can curl the endpoints:

`curl localhost:8080/actuator | jq .`{{execute T2}}

```
{
  "_links": {
    "self": {
      "href": "http://localhost:8080/actuator",
      "templated": false
    },
    "health-path": {
      "href": "http://localhost:8080/actuator/health/{*path}",
      "templated": true
    },
    "health": {
      "href": "http://localhost:8080/actuator/health",
      "templated": false
    },
    "info": {
      "href": "http://localhost:8080/actuator/info",
      "templated": false
    }
  }
}
```

Finally:

`echo "Send Ctrl+C to kill the application"`{{execute T1 interrupt}}