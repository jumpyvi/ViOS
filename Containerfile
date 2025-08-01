# Allow build scripts to be referenced without being copied into the final image
ARG BASE_IMAGE=none

FROM scratch AS ctx
COPY build_files /


# Base Image
FROM ${BASE_IMAGE}

ARG TYPE=none

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh "${TYPE}" && \
    ostree container commit
    

RUN bootc container lint
