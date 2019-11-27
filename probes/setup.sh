# sed -i -e 's,JAVA_HOME=.*$,JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64",' /etc/environment
launch.sh
docker run -d -p 80:5000 --name registry registry:2
daemonConfig='/etc/docker/daemon.json'
jq -s '.[0] * .[1]' <( cat ${daemonConfig}) <(echo '{ "insecure-registries": [ "localhost" ] }') | sudo tee ${daemonConfig} > /dev/null
