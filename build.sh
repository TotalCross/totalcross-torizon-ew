export DOCKER_CLI_EXPERIMENTAL=enabled

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

docker build . -t totalcross/app --no-cache