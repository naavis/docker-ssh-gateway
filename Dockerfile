FROM ghcr.io/linuxserver/openssh-server:arm64v8-latest

RUN apk update && \
    apk add --no-cache fail2ban && \
    echo "[Init]" >> /etc/fail2ban/action.d/iptables-common.local && \
    echo "blocktype = DROP" >> /etc/fail2ban/action.d/iptables-common.local && \
    mkdir -p /etc/services.d/fail2ban && \
    echo '#!/usr/bin/with-contenv bash' >> /etc/services.d/fail2ban/run && \
    echo 'exec 2>&1 /usr/bin/fail2ban-client -f start' >> /etc/services.d/fail2ban/run && \
    mkdir -p /config/logs/openssh && \
    touch /config/logs/openssh/current && \
    sed -i -e 's/\/var\/log\/messages/\/config\/logs\/openssh\/current/g' /etc/fail2ban/jail.d/alpine-ssh.conf
