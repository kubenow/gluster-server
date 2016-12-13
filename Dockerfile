FROM ubuntu:xenial

# Add GlusterFS repo
RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:gluster/glusterfs-3.9

# Install GlusterFS
RUN apt-get update -y
RUN apt-get install -y \
  glusterfs-server \
  attr

# Make bricks directory
RUN mkdir -p /var/bricks

# Set entrypoint
ENTRYPOINT service glusterfs-server start && \
  tail -c +1 -F /var/log/glusterfs/glusterd.log
