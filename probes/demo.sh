mkdir demo
(cd demo; curl -L https://github.com/spring-guides/gs-spring-boot-kubernetes/archive/main.tar.gz | tar xz gs-spring-boot-kubernetes-main/initial --strip-components 2)

docker run -d -p 80:5000 --name registry registry:2
