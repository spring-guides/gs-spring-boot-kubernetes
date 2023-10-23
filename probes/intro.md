Spring Boot comes with features that make it work well in Kubernetes. This scenario shows you how to add liveness and readiness probes to a Spring Boot application in Kubernetes. To do this we need to do two things:

1. Add some endpoints to a Spring Boot application and build and push a Docker image
2. Configure the probes in a few lines of YAML
3. Deploy the image as a container in Kubernetes

You will need a few minutes of time. We don't cover all the features of Spring and Spring Boot. For that you could go to the [Spring guides](https://spring.io/guides) or [Spring project homepages](https://spring.io/projects).

We also don't cover all the options available for building containers. There is a [Spring Boot topical guide](https://spring.io/guides/topicals/spring-boot-docker) covering some of those options in more detail.

When it comes to deploying the application to Kubernetes, there are far too many options to cover them all in one tutorial. We can look at one or two, but the emphasis will be on getting something working as quickly as possible, not on how to deploy to a production cluster.

Source code for this guide is in [Github](https://github.com/spring-guides/gs-spring-boot-kubernetes/tree/main/probes).