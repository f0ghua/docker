FROM i386/debian:stretch-20210311 

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
#COPY Si35Setup.exe /apps/sourceinside/
#COPY tcmd951x32.exe wincmd-sercomm.key bzipplug.zip  sftpplug.zip  wcx_7zip.zip  wcx_lzma21.zip  wlx_anyelf_1.6.zip /apps/totalcmd/

#SHELL ["/bin/bash", "-c"]
#RUN echo $'\
#Acquire::http::Proxy "http://172.21.44.10:2802";\n\
#Acquire::https::Proxy "http://172.21.44.10:2802";\
#' > /etc/apt/apt.conf.d/proxy.conf

RUN sed -i s/deb.debian.org/mirrors.163.com/g /etc/apt/sources.list && sed -i s/security.debian.org/mirrors.163.com/g /etc/apt/sources.list
RUN apt-get update
# don't upgrade as docker suggestion
#RUN apt-get upgrade
RUN apt-get install -y sudo locales locales-all apt-utils dialog \
	unzip vim bzip2 dos2unix python man inetutils-ping net-tools openssh-server wine \
	&& ln -sf /bin/bash /bin/sh \
	&& sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
	&& locale-gen \
	&& update-locale LANG=en_US.UTF-8 \
	&& ln -sf /bin/bash /bin/sh \
	&& chmod +x /usr/local/bin/entrypoint.sh

# entry point
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]



