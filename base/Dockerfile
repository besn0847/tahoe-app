FROM debian:sid

ADD preferences /etc/apt/

RUN echo "deb http://ftp.fr.debian.org/debian squeeze main" >> /etc/apt/source.list &&\
	echo "deb http://ftp.fr.debian.org/debian sid main contrib non-free" >> /etc/apt/source.list &&\
	echo "deb http://security.debian.org/ sid/updates main contrib non-free" >> /etc/apt/source.list &&\
	apt-get update &&\
	apt-get install -y --force-yes --no-install-recommends \
		python-twisted tahoe-lafs &&\
	apt-get autoclean &&\
        apt-get autoremove &&\
        rm -rf /var/lib/apt/lists/* &&\
	mkdir /etc/tahoe /data 

EXPOSE 3456
	
WORKDIR /data

RUN tahoe --version
