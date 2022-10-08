#! /bin/bash
set -eE
CONFD="/usr/local/etc/squid/conf.d"
CDMPD="/srv/data/coredump"
LOGSD="/srv/data/log"

if ! [[ -n $(ls -1A ${CONFD}) ]]; then
  echo "ERROR: there are no configuration files to be included in directory: '${CONFD}' " >&2
  exit 100
fi

if ! [[ -d ${CDMPD} ]]; then mkdir -p "${CDMPD}"; fi
if ! [[ -d ${LOGSD} ]]; then mkdir -p "${LOGSD}"; fi
chmod ug=rwX,o-rX -R "${CDMPD}"
chmod ug=rwX,o-rX -R "${LOGSD}"

exec /usr/sbin/squid -N -f "/usr/local/etc/squid/squid.conf"
