FROM tahoe-base

RUN mkdir -p /etc/tahoe/private

ADD tahoe/tahoe.cfg /etc/tahoe/
ADD tahoe/tahoe-client.tac /etc/tahoe/
ADD tahoe/private/ssh_host_rsa_key /etc/tahoe/private/ 
ADD tahoe/private/ssh_host_rsa_key.pub /etc/tahoe/private/ 

EXPOSE 8021 8022

CMD tahoe  start /etc/tahoe/ -l /var/log/tahoe.log -n
