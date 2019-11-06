# NFS server for testing

**1. Login to docker hub**
```shell script
docker login
```

**2. Build a new image**

To build a new `linux/amd64` image, run the following:

```shell script
cd linux-amd64
docker build -t docker.io/rjanik/amd64-linux-nfs-server:1.0 .
docker push docker.io/rjanik/amd64-linux-nfs-server:1.0
cd -
```

---

To build other architectures, than your host system, it's easiest to find a machine with the architecture you need.
If that cannot be done, see the resources for multiarch builds at the bottom of this README.

To build a new `s390x` image, run the following:

```shell script
cd s390x
docker build -t docker.io/rjanik/s390x-nfs-server:1.0 .
docker push docker.io/rjanik/s390x-nfs-server:1.0
cd -
```

**3. Build a manifest list**

First, enable experimental features in your docker daemon. Modify `/etc/docker/daemon.json` by adding:
```json
{
    "experimental": true
}
```

See [the documentation](https://docs.docker.com/engine/reference/commandline/dockerd/#daemon-configuration-file) for
more information.

Then, enable experimental features also in your docker cli. Modify `~/.docker/config.json` by adding:
```json
{
    "experimental": "enabled"
}
```

See [the documentation](https://docs.docker.com/engine/reference/commandline/cli/#experimental-features) for more
information.

Then, restart the docker daemon and run the build:

```shell script
systemctl restart docker
```

Then, create and push the manifest list:

```shell script
docker manifest create docker.io/rjanik/nfs-server:1.0 docker.io/rjanik/amd64-linux-nfs-server:1.0 docker.io/rjanik/s390x-nfs-server:1.0
docker manifest annotate docker.io/rjanik/nfs-server:1.0 docker.io/rjanik/amd64-linux-nfs-server:1.0 --os linux --arch amd64
docker manifest annotate docker.io/rjanik/nfs-server:1.0 docker.io/rjanik/s390x-nfs-server:1.0 --os linux --arch s390x
docker manifest push docker.io/rjanik/nfs-server:1.0
```

## Notes

**Checking supported architectures**

To easily check what architectures an image supports, run:

```
$ docker run mplatform/mquery rjanik/nfs-server:1.0
```

The image checked needs to be publicly available. `mquery` won't work on locally built images that haven't been pushed.

**Resources for multi-arch image building**

* https://developer.ibm.com/linuxonpower/2017/07/27/create-multi-architecture-docker-image/
* https://docs.docker.com/engine/reference/commandline/build/
* https://lobradov.github.io/Building-docker-multiarch-images/
* https://engineering.docker.com/2019/04/multi-arch-images/
* https://docs.docker.com/buildx/working-with-buildx/
* https://www.docker.com/blog/docker-official-images-now-multi-platform/
