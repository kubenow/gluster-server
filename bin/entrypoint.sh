#!/bin/bash

# Start glusterd
service glusterfs-server start

# Get peers
peers_domain=${PEERS_DOMAIN:-gluster-server.default}
gluster_peers=$(getent hosts gluster-server.default | awk '{ print $1 }')

# Connect to the other servers
for peer in $gluster_peers ; do
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
peers_arr=($gluster_peers)
gluster volume create shared-volume \
    replica 3 \
    ${peers_arr[@]/%/:/data/shared-volume/brick1} \
    ${peers_arr[@]/%/:/data/shared-volume/brick2} \
    ${peers_arr[@]/%/:/data/shared-volume/brick3} \
    force \
    && gluster volume start shared-volume \
    || true # ignore error, this was likely done by anoter peer

tail -f /dev/null # Hang on :-)
