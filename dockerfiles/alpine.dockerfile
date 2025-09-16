FROM alpine:3

LABEL org.opencontainers.image.source=https://github.com/chris-armstrong/ocaml-devcontainer

USER root

RUN apk add \
        bash \
        build-base \
        ca-certificates \
        curl \
        git \
        gpg \
        m4 \
        openssh-client \
        unzip \
        sudo \
        zsh 

ARG TARGETARCH
ARG TARGETOS
ARG OPAM_VERSION=2.4.1

RUN /bin/bash -c 'echo bash --version && declare -A target_arch_map=( ["amd64"]="x86_64" ["arm64"]="arm64") && \
    curl -OL https://github.com/ocaml/opam/releases/download/${OPAM_VERSION}/opam-${OPAM_VERSION}-${target_arch_map[$TARGETARCH]}-${TARGETOS} && \
    sudo install opam-${OPAM_VERSION}-${target_arch_map[$TARGETARCH]}-${TARGETOS} /usr/local/bin/opam'

ARG USERNAME=ocaml
ARG HOMEDIR=/home
ARG USE_OMZ=true
COPY script-library/alpine-*.sh /tmp/script-library/
RUN /tmp/script-library/alpine-create-user.sh ${USERNAME} \
    && su ${USERNAME} -c /tmp/script-library/alpine-oh-my-zsh.sh ${USE_OMZ} \
    && rm -rf /tmp/script-library

USER ${USERNAME}
ARG OCAML_VERSION=
RUN opam init --disable-sandbox --yes --compiler=${OCAML_VERSION}
ENV OPAM_SWITCH_PREFIX="${HOMEDIR}/${USERNAME}/.opam/${OCAML_VERSION}"
ENV CAML_LD_LIBRARY_PATH="${OPAM_SWITCH_PREFIX}/lib/stublibs:${OPAM_SWITCH_PREFIX}/lib/ocaml/stublibs:${OPAM_SWITCH_PREFIX}/lib/ocaml"
ENV OCAML_TOPLEVEL_PATH="${OPAM_SWITCH_PREFIX}/lib/toplevel"
ENV MANPATH="${MANPATH}:${OPAM_SWITCH_PREFIX}/man"
ENV PATH="${OPAM_SWITCH_PREFIX}/bin:${PATH}"

RUN opam install --yes \
        dune \
        ocaml-lsp-server \
        ocamlformat
