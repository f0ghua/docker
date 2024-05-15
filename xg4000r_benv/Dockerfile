FROM ubuntu:18.04 AS xg4000r-buildenv

# LABEL about the custom image
LABEL maintainer="fog_hua@sdc.sercomm.com"
#LABEL version="1.0"
LABEL description="This is custom Docker Image for RMDU build environment."

# the mirror sites are missing with some packages(e.g. zip, less)
#RUN sed -i s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g /etc/apt/sources.list && sed -i s/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g /etc/apt/sources.list

# we need i386 libraries to support some tools  
RUN dpkg --add-architecture i386 && apt-get update

# Set the locale
RUN apt-get install -y --no-install-recommends \
    locales locales-all
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set timezone
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

RUN apt-get install -y --no-install-recommends \
    ca-certificates apt-utils \
    libncurses5-dev python python3 unzip \
    git gawk wget file curl sudo runit \
    vim net-tools inetutils-ping dos2unix \
	device-tree-compiler cron expect tclsh
	
# install packages from russia team 
RUN apt-get install -y --allow-downgrades \
    libc6-dev libc-dev-bin linux-libc-dev \
    libssl-dev \
    build-essential gcc-multilib g++-multilib lib32z1 lib32ncurses5 \
    libmpc3 libmpc3:i386 libmpfr6 libmpfr6:i386 libgmp-dev libmpfr-dev \
    libmpc-dev libmpfrc++-dev liblzo2-dev libglib2.0-dev \
    make cmake autotools-dev autoconf automake liblzo2-dev libtool \
    autopoint autoconf-archive uuid-dev pkgconf gettext rsync bc \
    bison flex byacc kmod 
    
RUN apt-get install -y --no-install-recommends \    
    libz-dev \
    openssh-server \
	zip less bsdmainutils quilt smbclient
	
RUN apt-get install -y --no-install-recommends \ 
	software-properties-common
RUN apt-add-repository ppa:openjdk-r/ppa && apt-get update	
RUN apt-get install -y --no-install-recommends \  
	unionfs-fuse zlib1g-dev zlib1g:i386 pkg-config gperf \
	libc6:i386 texinfo sharutils \
	swig gdisk parted udev cpio

RUN ln -sf /bin/bash /bin/sh

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY ./files/libiconv.so.2.6.1 /usr/local/lib/libiconv.so.2.6.1
RUN ln -sf /usr/local/lib/libiconv.so.2.6.1 /usr/local/lib/libiconv.so \
    && ln -sf /usr/local/lib/libiconv.so.2.6.1 /usr/local/lib/libiconv.so.2 \
    && ln -sf /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 /usr/lib/x86_64-linux-gnu/libcrypto.so \
    && ln -sf /usr/include/i386-linux-gnu/openssl/opensslconf.h /usr/include/openssl/opensslconf.h \
    && ln -sf /usr/lib/i386-linux-gnu/libmpfr.so.6 /usr/lib/i386-linux-gnu/libmpfr.so.4 \
    && ldconfig
    
# switch default python to 3.6
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.6 2

RUN wget https://mirrors.tuna.tsinghua.edu.cn/git/git-repo -O /usr/local/bin/repo && chmod +x /usr/local/bin/repo

# update apt source list so that it can work in imera (x64 only)
RUN cp /etc/apt/sources.list /etc/apt/sources.list.ORIGINAL
COPY sources.list /etc/apt/sources.list

RUN echo $'\
search 172.21.1.245\n\
nameserver 172.21.1.231\
' > /etc/resolv.conf

# add toolchain
ADD ./files/asdk-10.2.0-a55-EL-5.10-g2.30-a96-210331.tar.bz2 /share/rlx

# entry point
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]
