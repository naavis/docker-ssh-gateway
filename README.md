# OpenSSH + fail2ban Docker image

The Dockerfile in this repository builds an image based on [linuxserver.io's
linuserver/openssh-server](https://github.com/linuxserver/docker-openssh-server)
and adds Fail2ban intrusion prevention system to it.

## Parameters

Container images are configured using parameters passed at runtime (such as
those above). These parameters are separated by a colon and indicate
`<external>:<internal>` respectively. For example, `-p 8080:80` would expose
port `80` from inside the container to be accessible from the host's IP on port
`8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `--hostname=` | Optionally the hostname can be defined. |
| `-p 2222` | ssh port |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London |
| `-e PUBLIC_KEY=yourpublickey` | Optional ssh public key, which will automatically be added to authorized_keys. |
| `-e PUBLIC_KEY_FILE=/path/to/file` | Optionally specify a file containing the public key (works with docker secrets). |
| `-e SUDO_ACCESS=false` | Set to `true` to allow `linuxserver.io`, the ssh user, sudo access. Without `USER_PASSWORD` set, this will allow passwordless sudo access. |
| `-e PASSWORD_ACCESS=false` | Set to `true` to allow user/password ssh access. You will want to set `USER_PASSWORD` or `USER_PASSWORD_FILE` as well. |
| `-e USER_PASSWORD=password` | Optionally set a sudo password for `linuxserver.io`, the ssh user. If this or `USER_PASSWORD_FILE` are not set but `SUDO_ACCESS` is set to true, the user will have passwordless sudo access. |
| `-e USER_PASSWORD_FILE=/path/to/file` | Optionally specify a file that contains the password. This setting supersedes the `USER_PASSWORD` option (works with docker secrets). |
| `-e USER_NAME=linuxserver.io` | Optionally specify a user name (Default:`linuxserver.io`) |
| `-v /config` | Contains all relevant configuration files. |


For more information, check the [docker-openssh-server README](https://github.com/linuxserver/docker-openssh-server/blob/master/README.md)