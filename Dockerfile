ARG BASE_IMAGE=torizon/arm32v7-debian-wayland-base
FROM $BASE_IMAGE:latest
RUN apt update && apt install -y --no-install-recommends \
    libfontconfig1 \
    weston
COPY bin/ /totalcross
COPY bin/libtcvm.so /usr/lib/totalcross/
ENV LIBGL_ALWAYS_SOFTWARE=1