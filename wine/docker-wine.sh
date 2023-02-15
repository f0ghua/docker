WORKSPACE=/home/fog
REPO=db9wine:v0.1
CN=db9wine-$USER
echo -n "Docker ID:"
docker run -d --ipc="host" --name=$CN --rm -it --init -e LOCAL_USER_ID=`id -u $USER` -v $WORKSPACE:/home/user $REPO
#docker run -d --ipc="host" --name=$CN --rm -it --init -e DISPLAY -e LOCAL_USER_ID=`id -u $USER` -v $WORKSPACE:/home/user $REPO
IP=`docker inspect $CN -f {{.NetworkSettings.IPAddress}}`
echo Docker Started.
echo -n Connecting to Docker - 3
sleep 1
echo -en "\b2"
sleep 1
echo -en "\b1"
sleep 1
echo -en "\n"
ssh -X -o PreferredAuthentications=password -o PubkeyAuthentication=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null user@$IP
echo -en "\n\nStopping ..."
docker stop $CN
echo -e "\nDone."
