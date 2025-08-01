_default:
    just --choose

build-workstation:
    sudo podman build -f Containerfile --build-arg TYPE="workstation" --build-arg BASE_IMAGE=$(grep '^WORKSTATION_IMAGE=' images.conf | cut -d'=' -f2-) -t local-boot:latest

build-gaming:
    sudo podman build -f Containerfile --build-arg TYPE="gaming" --build-arg BASE_IMAGE=$(grep '^GAMING_IMAGE=' images.conf | cut -d'=' -f2-) -t local-boot:latest

build-server:
    sudo podman build -f Containerfile --build-arg TYPE="server" --build-arg BASE_IMAGE=$(grep '^SERVER_IMAGE=' images.conf | cut -d'=' -f2-) -t local-boot:latest