#! /bin/bash

# install docker
yum install docker git -y

# Start Docker
service docker start

# Install Docker Compose
curl -L https://github.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
usermod -aG docker ec2-user

# Create docker compose file
cat <<EOF > /root/secrets.json
${bot_secrets}
EOF

# Create docker compose file
cat <<EOF > /root/docker-compose.yml
${docker_compose_file}
EOF

# Create telegraf config file
mkdir -p /srv/telegraf/
cat <<EOF > /srv/telegraf/telegraf.conf
${telegraf_config}
EOF

# Create filebeat config file
mkdir -p /srv/filebeat/
cat <<EOF > /srv/filebeat/filebeat.yml
${filebeat_config}
EOF

# Create logstash config file
mkdir -p /srv/logstash/
cat <<EOF > /srv/logstash/logstash.conf
${logstash_config}
EOF

/usr/local/bin/docker-compose -f /root/docker-compose.yml -p sol up -d
