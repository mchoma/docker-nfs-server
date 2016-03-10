1. Login docker hub
docker login

2. Save old version of nfs-server image
docker pull docker.io/aosqe/nfs-server
docker tag docker.io/aosqe/nfs-server docker.io/aosqe/nfs-server:1.0
docker push docker.io/aosqe/nfs-server:1.0

3. Build new version, and push it.
docker build -t docker.io/aosqe/nfs-server https://raw.githubusercontent.com/jianlinliu/docker-nfs-server/master/Dockerfile
docker push docker.io/aosqe/nfs-server
