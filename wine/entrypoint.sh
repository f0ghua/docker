#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}

echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
addgroup user sudo
#passwd -d user
echo -e "123456\n123456" | (passwd user)
export HOME=/home/user
sudo sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config
/etc/init.d/ssh start
su - user
exec "$@"
