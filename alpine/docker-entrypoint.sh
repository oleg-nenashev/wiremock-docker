#!/bin/sh

set -e

# Set `java` command if needed
if [ "$1" = "" -o "${1#-}" != "$1" ]; then
  set -- java $JAVA_OPTS -cp /var/wiremock/lib/*:/var/wiremock/extensions/* wiremock.Run "$@"
fi

# allow the container to be started with `-e uid=`
if [ "$uid" != "" ]; then
  # Change the ownership of /home/wiremock to $uid
  chown -R $uid:$uid /home/wiremock

  set -- su-exec $uid:$uid "$@"
fi

exec "$@"
