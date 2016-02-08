FROM tahoeapp_base

ADD startup.sh /

RUN mkdir -p /etc/tahoe/private && \
	chmod +x /startup.sh

ADD tahoe/tahoe.cfg /etc/tahoe/
ADD tahoe/tahoe.cfg-post /etc/tahoe/
ADD tahoe/tahoe-client.tac /etc/tahoe/
ADD tahoe/private/ssh_host_rsa_key /etc/tahoe/private/ 
ADD tahoe/private/ssh_host_rsa_key.pub /etc/tahoe/private/ 

EXPOSE 8021 8022

CMD /startup.sh
