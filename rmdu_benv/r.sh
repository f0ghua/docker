GUESTUSER=docker
REPO=rmdu-buildenv:v1.0
#REPO=mirrors.sdc.sercomm.com:5000/rmdu-buildenv:v1.0

USERHOME=/home/$USER
USERID=`id -u $USER`
GUESTHOME=/home/$GUESTUSER
WORKPATH=$(echo "`pwd`"|sed "s/$USER/$GUESTUSER/")
WORKSPACE=/workspace
COVPATH=/opt/cov-analysis-linux64-2022.9.1
CN=rmdu-benv_${USER}_$(uuidgen)
echo -n "Docker ID:"
# --ipc="host" is a fix for share memory issue
docker run --ipc="host" --name=$CN --hostname docker-$USERID\
    --rm -it --init -e DISPLAY -e LOCAL_USER_ID=$USERID \
    -w $WORKPATH \
    -v $USERHOME:/home/$GUESTUSER -v $WORKSPACE:/workspace -v $COV_PATH:$COVPATH $REPO
