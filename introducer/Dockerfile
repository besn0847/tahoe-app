FROM tahoe-base

RUN mkdir-p  /etc/tahoe/tmp /etc/tahoe/logs/incidents /etc/tahoe/private

ADD tahoe/tahoe-introducer.tac /etc/tahoe/
ADD tahoe/tahoe.cfg /etc/tahoe/
ADD tahoe/my_nodeid /etc/tahoe/
ADD tahoe/node.url /etc/tahoe/
ADD tahoe/introducer.port /etc/tahoe/

ADD tahoe/private/introducer.furl /etc/tahoe/private/
ADD tahoe/private/logport.furl /etc/tahoe/private/
ADD tahoe/private/node.pem /etc/tahoe/private/
ADD tahoe/private/README /etc/tahoe/private/

EXPOSE 3456 44190

CMD tahoe  start /etc/tahoe/ -l /var/log/tahoe.log -n
