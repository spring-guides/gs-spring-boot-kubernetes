mkdir demo
(cd demo; curl -L https://github.com/spring-guides/gs-spring-boot-kubernetes/archive/master.tar.gz | tar xz gs-spring-boot-kubernetes-master/initial --strip-components 2)

docker run -d -p 80:5000 --name registry registry:2
daemonConfig='/etc/docker/daemon.json'
jq -s '.[0] * .[1]' <( cat ${daemonConfig}) <(echo '{ "insecure-registries": [ "localhost" ] }') | sudo tee ${daemonConfig} > /dev/null
