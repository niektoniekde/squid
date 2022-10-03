# Description
Image based on official Alpine Linux image with ``squid`` and ``bash`` installed via apk.
Entrypoint is ``entrypoint.bash`` BASH script executing following actions:
* check if there is includable configuration in ``/usr/local/etc/squid/conf.d`` (exit with error if there is none)
* create ``/srv/data/coredump`` directory if not already present (``/srv/data`` is volume)
* launch ``squid`` with custom basic config (``-f``) and without daemon mode (``-N``)

## Configuration
Custom basic configuration file provided as parameter to ``squid`` sets only
``coredump_dir``, ``pid_filename`` directives and then includes configuration
files in directory ``/usr/local/etc/squid/conf.d`` by wildcard pattern ``*.conf``.
This directory is volume and it should be mount in Read-Only mode.

With above in mind it's obvious that all configuration is expected to be provided
by included configuration files. That's why entrypoint script fails with error
when there are none.

## Volumes
There are two volumes by default, one for configuration files and one for persistent data:
* ``/usr/local/etc/squid/conf.d`` - configuration files
* ``/srv/data`` - persistent data
