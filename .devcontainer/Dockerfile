# Use plain Ubuntu
FROM ubuntu:24.04

RUN apt update \
    && apt install -y --no-install-recommends \
        cmake                       \
        clangd                      \
        usbutils                    \
        git                         \
        ninja-build                 \
        build-essential             \
        wget                        \
        ca-certificates             \
        gdb-multiarch               \
        binutils-multiarch          \
        automake                    \
        autoconf                    \
        libtool                     \
        libftdi-dev                 \
        libusb-1.0-0-dev            \
        libhidapi-dev               \
        pkg-config                  \
        clang-format                \
        gperf                       \
        ccache                      \
        dfu-util                    \
        device-tree-compiler        \
        python3                     \
        python3-dev                 \
        python3-pip                 \
        python3.12-venv             \
        python3-tk                  \
        xz-utils                    \
        file                        \
        make                        \
        gcc                         \
        gcc-multilib                \
        g++-multilib                \
        libsdl2-dev                 \
        libmagic1                   \
    && apt-get clean                \
	&& apt-get autoremove --purge

# gid 46 inside, on nixos plugdev doesn't exist, create it yourself!
RUN usermod -aG plugdev ubuntu

USER ubuntu

# shell and environment setup; A bunch of calls to west that can take a long time first run
RUN echo "source /home/ubuntu/workdir/env_setup.sh" >> /home/ubuntu/.bashrc \
    && echo "source /home/ubuntu/workdir/env_setup.sh" >> /home/ubuntu/.zshrc