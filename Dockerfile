FROM ubuntu:14.04
MAINTAINER Jasmin Beganović <bjasko@bring.out.ba>

RUN apt-get update 
RUN apt-get install -y samba krb5-user winbind libnss-winbind libpam-winbind supervisor rsyslog
RUN mkdir -p /var/log/supervisor
 

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/
RUN rm -rf /etc/krb5.conf

# save samba config for first RUN 

RUN cp -a  /etc/samba  /etc/samba_orig
RUN cp -a /var/lib/samba /var/lib/samba_orig

EXPOSE 139 445
VOLUME ["/var/lib/samba", "/etc/samba" "/etc/krb5.conf" ]
ADD nsswitch.conf /etc/nsswitch.conf
ADD init.sh /init.sh
RUN chmod 755 /init.sh
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf


ENTRYPOINT ["/init.sh"]
CMD ["app:start"]





