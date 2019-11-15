FROM fedora:30
MAINTAINER Richard Janík <rjanik@redhat.com>
EXPOSE 2049/tcp

RUN dnf -y install nfs-utils nc
RUN dnf clean all
ADD run_nfs /usr/local/bin/run_nfs

ENTRYPOINT ["/usr/local/bin/run_nfs"]
