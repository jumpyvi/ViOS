_default:
    just --choose

build-workstation:
    podman build -f Containerfile --build-arg TYPE="workstation" --build-arg BASE_IMAGE=$(grep '^WORKSTATION_IMAGE=' images.conf | cut -d'=' -f2-) -t local-boot:latest

build-multimedia:
    podman build -f Containerfile --build-arg TYPE="multimedia" --build-arg BASE_IMAGE=$(grep '^MULTIMEDIA_IMAGE=' images.conf | cut -d'=' -f2-) -t local-boot:latest