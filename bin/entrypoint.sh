#!/bin/bash

# Connect to the other servers
peer_list=$(echo $GLUSTER_PEERS)
for peer in $peer_list ; do
  gluster peer probe $peer
done
