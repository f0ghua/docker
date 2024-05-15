GUESTUSER=docker
USERHOME=/home/$USER
WORKSPACE=/workspace
REPO=rmdu-buildenv
CN=rmdu-benv_$USER
echo -n "Docker ID:"
docker run -d --ipc="host" --name=$CN --rm -it --init -e DISPLAY -e LOCAL_USER_ID=`id -u $USER` -v $USERHOME:/home/$GUESTUSER -v $WORKSPACE:/workspace $REPO
IP=`docker inspect $CN -f {{.NetworkSettings.IPAddress}}`
echo Docker Started.
echo -n Connecting to Docker - 3
sleep 1
echo -en "\b2"
sleep 1
echo -en "\b1"
sleep 1
echo -en "\n"
#ssh $GUESTUSER@$IP
sshpass -p 123456 ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $GUESTUSER@$IP
echo -en "\n\nStopping ..."
docker stop $CN
echo -e "\nDone."
