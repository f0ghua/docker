#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}

echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m docker
addgroup docker sudo
echo -e "123456\n123456" | (passwd docker)
export HOME=/home/docker
sudo sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config
/etc/init.d/ssh start
exec su docker
#su - user
#exec "$@"
