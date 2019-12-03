FROM registry.redhat.io/rhel7.7
MAINTAINER EAP QE
EXPOSE 2049/tcp

# Attach OpenShift Container Platform Subscription
RUN subscription-manager register --username=qa@redhat.com --password=redhatqa --serverurl=subscription.rhn.stage.redhat.com
# Search pool which contains "OpenShift Container Platform" in output of
#RUN subscription-manager list --available
#RUN subscription-manager repos --list
#RUN subscription-manager attach  --pool=8a85f98960dbf6510160df23e3367451
#RUN subscription-manager attach --pool=8a85f98960dbf6510160df23eb447470

# Set Up Repositories
RUN subscription-manager repos \
    --enable="rhel-7-for-system-z-rpms"

RUN yum -y install nfs-utils nc
RUN yum clean all
ADD run_nfs /usr/local/bin/run_nfs

ENTRYPOINT ["/usr/local/bin/run_nfs"]
