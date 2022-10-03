FROM docker.io/alpine:latest

# install squid and bash packages
RUN apk --no-cache add squid bash

# prepare local configuration structure
RUN mkdir -p /usr/local/etc/squid/conf.d
COPY conf/squid.conf /usr/local/etc/squid/squid.conf
RUN chown root:        -R /usr/local/etc/squid
RUN chmod u=rwX,go=rX  -R /usr/local/etc/squid 

# prepare data volume mountpoint
RUN mkdir -p              /srv/data

# volumes declarations
VOLUME /usr/local/etc/squid/conf.d
VOLUME /srv/data

# prepare entrypoint
COPY entrypoint.bash /usr/local/bin/entrypoint.bash
RUN chmod u=rwx,go=rx /usr/local/bin/entrypoint.bash

# 'squid' user is present after
#  installing 'squid' software via apk
USER squid
ENTRYPOINT ["/usr/local/bin/entrypoint.bash"]
