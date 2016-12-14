#!/bin/bash

set -e

# Copy initial configuration if needed
DIRS="/etc/glusterfs /var/lib/glusterd"
for dir in $DIRS ; do
  if [ ! "$(ls -A $dir)" ] ; then
    echo "Init $dir"
    cp -r ${dir}_bkp/* ${dir}
  fi
done

# Start glusterfs-server
service glusterfs-server start
tail -c +1 -F /var/log/glusterfs/glusterd.log
