_default:
    just --choose

build-workstation:
    podman build -f Containerfile --build-arg BASE_IMAGE=$(grep '^WORKSTATION_IMAGE=' images.conf | cut -d'=' -f2-) -t local-boot:latest