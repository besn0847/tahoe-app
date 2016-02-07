FROM tahoe-base

RUN mkdir -p /etc/tahoe/private

ADD tahoe/tahoe.cfg /etc/tahoe/
ADD tahoe/tahoe-client.tac /etc/tahoe/

EXPOSE 3456 8097

CMD tahoe  start /etc/tahoe/ -l /var/log/tahoe.log -n
