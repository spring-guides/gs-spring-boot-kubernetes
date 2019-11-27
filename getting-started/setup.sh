docker run -d -p 80:5000 --name registry registry:2
daemonConfig='/etc/docker/daemon.json'
jq -s '.[0] * .[1]' <( cat ${daemonConfig}) <(echo '{ "insecure-registries": [ "localhost" ] }') | sudo tee ${daemonConfig} > /dev/null
