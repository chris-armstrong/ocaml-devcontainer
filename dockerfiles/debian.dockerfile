FROM debian:trixie

LABEL org.opencontainers.image.source=https://github.com/chris-armstrong/ocaml-devcontainer

USER root

ARG TARGETARCH
ARG TARGETOS
ARG OPAM_VERSION=2.4.1

RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        gpg \
        locales \
        m4 \
        opam \
        ssh-client \
        sudo \
        zsh \
        unzip \
        build-essential \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/list/*

RUN /bin/bash -c 'echo bash --version && declare -A target_arch_map=( ["amd64"]="x86_64" ["arm64"]="arm64") && \
    curl -OL https://github.com/ocaml/opam/releases/download/${OPAM_VERSION}/opam-${OPAM_VERSION}-${target_arch_map[$TARGETARCH]}-${TARGETOS} && \
    sudo install opam-${OPAM_VERSION}-${target_arch_map[$TARGETARCH]}-${TARGETOS} /usr/local/bin/opam'

ARG LOCALE=en_US.UTF-8
RUN export FORMAT=$(echo ${LOCALE} | cut -f2 -d.) \
    && export INPUT=$(echo ${LOCALE} | cut -f1 -d.) \
    && localedef -f ${FORMAT} -i ${INPUT} ${LOCALE}
ENV LC_ALL ${LOCALE}

ARG USERNAME=ocaml
ARG HOMEDIR=/home
ARG USE_OMZ=true
COPY script-library/debian-*.sh /tmp/script-library/
RUN /tmp/script-library/debian-create-user.sh ${USERNAME} \
    && su ${USERNAME} -c /tmp/script-library/debian-oh-my-zsh.sh ${USE_OMZ} \
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
