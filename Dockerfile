FROM jsafrane/nfsexporter
MAINTAINER aos-qe@redhat.com
RUN mkdir -p /mnt/data
RUN chown -R nfsnobody:nfsnobody /mnt/data
RUN chmod 777 /mnt/data
ENTRYPOINT ["/usr/local/bin/run_nfs", "/mnt/data"]
