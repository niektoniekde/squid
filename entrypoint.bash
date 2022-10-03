#! /bin/bash
set -eE
CONFD="/usr/local/etc/squid/conf.d"
CDMPD="/srv/data/coredump"

if ! [[ -n $(ls -1A ${CONFD}) ]]; then
  echo "ERROR: there are no configuration files to be included in directory: '${CONFD}' " >&2
  exit 100
fi

if ! [[ -d ${CDMPD} ]]; then
  mkdir /srv/data/coredump
fi

/usr/sbin/squid -N -f "/usr/local/etc/squid/squid.conf"
