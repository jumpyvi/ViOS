# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM ghcr.io/ublue-os/bazzite:stable

COPY ublue-logo.png /tmp/ublue-logo.png

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    cp /tmp/ublue-logo.png /usr/share/pixmaps/fedora-gdm-logo.png && cp /tmp/ublue-logo.png /usr/share/plymouth/themes/spinner/silverblue-watermark.png && \
    ostree container commit
    

RUN bootc container lint
