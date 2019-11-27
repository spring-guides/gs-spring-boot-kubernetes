Spring Boot is a great way to write an application in Java. This scenario shows you how to create a Spring Boot application and run it in Kubernetes with as little fuss and bother as possible. And there's no YAML. To do this we need to do three things:

1. Create a Spring Boot application
2. Containerize it, and push the container to a registry
3. Deploy it to Kubernetes

You will need a few minutes of time. If you have credentials for a public docker registry, like [Dockerhub](https://dockerhub.com) or [Google Container Registry](https://cloud.google.com/container-registry/), that will help, but it won't stop you from completing the scenario.

We don't cover all the features of Spring and Spring Boot. For that you could go to the [Spring guides](https://spring.io/guides) or [Spring project homepages](https://spring.io/projects).

We also don't cover all the options available for building containers. There is a [Spring Boot topical guide](https://spring.io/guides/topicals/spring-boot-docker) covering some of those options in more detail.

When it comes to deploying the application to Kubernetes, there are far too many options to cover them all in one tutorial. We can look at one or two, but the emphasis will be on getting something working as quickly as possible, not on how to deploy to a production cluster.

Source code for this guide is in [Github](https://github.com/spring-guides/gs-spring-boot-kubernetes/tree/master/getting-started). It is deployed in [Katacoda](https://www.katacoda.com/springguides/scenarios/getting-started) where you can run the code interactively in your browser.