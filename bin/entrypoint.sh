#!/bin/bash

# Connect to the other servers
for peer in $GLUSTER_PEERS ; do
  echo "Attempting peer probe $peer"
  gluster peer probe $peer
done
