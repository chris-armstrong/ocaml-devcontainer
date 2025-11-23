group "default" {
    targets = [
        "latest",
        "5_3"
    ]
}

target "cross_platform" {
    platforms = [
        "linux/amd64"
    ]
}

target "root" {
    args = {
        USERNAME = "root"
        HOMEDIR = ""
    }
}

target "debian" {
    dockerfile = "./dockerfiles/debian.dockerfile"
}

target "ubuntu" {
    dockerfile = "./dockerfiles/ubuntu.dockerfile"
}

target "alpine" {
    dockerfile = "./dockerfiles/alpine.dockerfile"
}

group "latest" {
    targets = [
        "latest_debian",
        "latest_debian_root",
        "latest_ubuntu",
        "latest_ubuntu_root",
        "latest_alpine",
        "latest_alpine_root"
    ]
}

group "5_3" {
    targets = [
        "5_3_debian",
        "5_3_debian_root",
        "5_3_ubuntu",
        "5_3_ubuntu_root",
        "5_3_alpine",
        "5_3_alpine_root"
    ]
}

target "latest_version" {
    args = {
        OCAML_VERSION = "5.4.0"
    }
}

target "5_3" {
    args = {
        OCAML_VERSION = "5.3.0"
    }
}

target "latest_debian" {
    inherits = ["latest_version", "debian", "cross_platform"]
    tags =[
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4.0-debian",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4-debian",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5-debian",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:debian",

        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4.0",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:latest",
    ]
}

target "latest_debian_root" {
    inherits = ["latest_version", "debian", "root", "cross_platform"]
    tags = [
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4.0-debian-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4-debian-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5-debian-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:debian-root",

        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4.0-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:root",
    ]
}

target "latest_ubuntu" {
    inherits = ["latest_version", "ubuntu", "cross_platform"]
    tags =[
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4.0-ubuntu",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4-ubuntu",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5-ubuntu",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:ubuntu",
    ]
}

target "latest_ubuntu_root" {
    inherits = ["latest_version", "ubuntu", "root", "cross_platform"]
    tags = [
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4.0-ubuntu-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4-ubuntu-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5-ubuntu-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:ubuntu-root",
    ]
}

target "latest_alpine" {
    inherits = ["latest_version", "alpine", "cross_platform"]
    tags =[
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4.0-alpine",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4-alpine",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5-alpine",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:alpine",
    ]
}

target "latest_alpine_root" {
    inherits = ["latest_version", "alpine", "root", "cross_platform"]
    tags = [
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4.0-alpine-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.4-alpine-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5-alpine-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:alpine-root",
    ]
}

target "5_3_debian" {
    inherits = ["5_3_version", "debian", "cross_platform"]
    tags =[
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3.0-debian",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3-debian",


        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3.0",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3"
    ]
}

target "5_3_debian_root" {
    inherits = ["5_3_version", "debian", "root", "cross_platform"]
    tags = [
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3.0-debian-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3-debian-root",

        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3.0-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3-root"
    ]
}

target "5_3_ubuntu" {
    inherits = ["5_3_version", "ubuntu", "cross_platform"]
    tags =[
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3.0-ubuntu",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3-ubuntu"
    ]
}

target "5_3_ubuntu_root" {
    inherits = ["5_3_version", "ubuntu", "root", "cross_platform"]
    tags = [
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3.0-ubuntu-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3-ubuntu-root"
    ]
}

target "5_3_alpine" {
    inherits = ["5_3_version", "alpine", "cross_platform"]
    tags =[
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3.0-alpine",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3-alpine"

    ]
}

target "5_3_alpine_root" {
    inherits = ["5_3_version", "alpine", "root", "cross_platform"]
    tags = [
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3.0-alpine-root",
        "ghcr.io/chris-armstrong/ocaml-devcontainer:5.3-alpine-root"

    ]
}