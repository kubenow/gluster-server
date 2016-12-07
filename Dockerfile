FROM ubuntu:xenial

# Install GlusterFS
RUN apt-get update -y
RUN apt-get install -y \
  glusterfs-server \
  attr \
  daemon

# Install entrypoint
ADD bin/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
