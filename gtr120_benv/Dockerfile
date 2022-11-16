FROM ubuntu:18.04 AS gtr120_buildenv

# LABEL about the custom image
LABEL maintainer="fog_hua@sdc.sercomm.com"
#LABEL version="1.0"
LABEL description="This is custom Docker Image for GTR120 build environment."

ENV LANG en_US.UTF-8
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN sed -i s/archive.ubuntu.com/mirrors.163.com/g /etc/apt/sources.list && sed -i s/security.ubuntu.com/mirrors.163.com/g /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates apt-utils locales locales-all \
    build-essential libncurses5-dev python python3 unzip \
    git gawk wget file curl sudo runit pkg-config \
    vim net-tools inetutils-ping dos2unix \
    libssl1.0-dev libz-dev \
    openssh-server

# we need i386 libraries to support some tools	
RUN dpkg --add-architecture i386 && \
    apt-get install -y gcc-multilib
	
RUN ln -sf /bin/bash /bin/sh \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8 \
    && ln -sf /bin/bash /bin/sh \
    && chmod +x /usr/local/bin/entrypoint.sh

# switch default python to 3.6
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1 && \
	update-alternatives --install /usr/bin/python python /usr/bin/python3.6 2

RUN wget https://storage.googleapis.com/git-repo-downloads/repo -O /usr/local/bin/repo && chmod +x /usr/local/bin/repo

# update apt source list so that it can work in imera (x64 only)
RUN cp /etc/apt/sources.list /etc/apt/sources.list.ORIGINAL
COPY sources.list /etc/apt/sources.list

# entry point
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]
