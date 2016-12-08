FROM ubuntu:xenial

# Install GlusterFS
RUN apt-get update -y
RUN apt-get install -y \
  glusterfs-server \
  attr

# Create data directory
RUN mkdir -p /data/shared-volume/brick1
RUN mkdir -p /data/shared-volume/brick2
RUN mkdir -p /data/shared-volume/brick3

# Install entrypoint
ADD bin/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
