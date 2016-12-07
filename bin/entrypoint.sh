#!/bin/bash

# Start glusterd
service glusterfs-server start

# Connect to the other servers
for peer in $GLUSTER_PEERS ; do
  echo "Attempting peer probe $peer"
  wait_time=0
  retrials=${PROBE_RETRIALS:-35} # Try for 10 minutes by default
  until gluster peer probe $peer || [ $wait_time -eq $retrials ]; do
    sleep_time=$(( wait_time++ ))
    echo "Try again in $sleep_time s"
    sleep $sleep_time
  done
done

echo "Attempting shared-volume creation"
peers_arr=($GLUSTER_PEERS)
gluster volume create shared-volume replica 3 \
    ${peers_arr[@]/%/:/data/brick1/vol} \
    force \
    && gluster volume start shared-volume \
    || true # ignore error, this was likely done by anoter peer

tail -f /dev/null # Hang on :-)
