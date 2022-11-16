GUESTUSER=docker
USERHOME=/home/$USER
GUESTHOME=/home/$GUESTUSER
WORKSPACE=/workspace
REPO=gtr120-buildenv:v1.0
CN=gtr120-benv
echo -n "Docker ID:"
# --ipc="host" is a fix for share memory issue
docker run --ipc="host" --name=$CN \
    --rm -it --init -e DISPLAY -e LOCAL_USER_ID=`id -u $USER` -w $GUESTHOME \
    -v $USERHOME:/home/$GUESTUSER -v $WORKSPACE:/workspace $REPO
