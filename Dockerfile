FROM ubuntu:xenial

# Install GlusterFS
RUN apt-get update -y
RUN apt-get install -y \
  glusterfs-server \
  attr \
  daemon

# Create data directory
RUN mkdir -p /data/brick/volume

# Install entrypoint
ADD bin/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
