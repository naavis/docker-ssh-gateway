FROM ghcr.io/linuxserver/openssh-server:arm64v8-latest

RUN apk update && \
    # Install fail2ban
    apk add --no-cache fail2ban && \
    # Configure blocking action to DROP because my Docker host does not support REJECT
    echo "[Init]" >> /etc/fail2ban/action.d/iptables-common.local && \
    echo "blocktype = DROP" >> /etc/fail2ban/action.d/iptables-common.local && \
    # Add a service to automatically start fail2ban
    mkdir -p /etc/services.d/fail2ban && \
    echo '#!/usr/bin/with-contenv bash' >> /etc/services.d/fail2ban/run && \
    echo 'exec 2>&1 /usr/bin/fail2ban-client -f start' >> /etc/services.d/fail2ban/run && \
    # Create empty OpenSSH logfile because fail2ban breaks if it doesn't exist
    mkdir -p /config/logs/openssh && \
    touch /config/logs/openssh/current && \
    # Point fail2ban to /config/logs/openssh/current because that's where
    # OpenSSH is configured to produce logs in linuxserver.io's base image
    sed -i -e 's/\/var\/log\/messages/\/config\/logs\/openssh\/current/g' /etc/fail2ban/jail.d/alpine-ssh.conf
