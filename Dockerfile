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

# Backup initial configuration
RUN mkdir /etc/glusterfs_bkp /var/lib/glusterd_bkp
RUN cp -r /etc/glusterfs/* /etc/glusterfs_bkp
RUN cp -r /var/lib/glusterd/* /var/lib/glusterd_bkp

# Set entrypoint
ADD bin/entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
