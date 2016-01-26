#!/usr/bin/env bash

# Make sure we're not confused by old, incompletely-shutdown apache
# context after restarting the container. apache won't start correctly
# if it thinks it is already running.
rm -rf /run/apache2* /tmp/apache2*

exec /usr/sbin/apache2ctl -D FOREGROUND