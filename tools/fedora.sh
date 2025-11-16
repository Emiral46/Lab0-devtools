#!/usr/bin/env bash

# Author : Emir Alemdar
# Year   : 2025

echo () {
    printf "\n%b\n" "[iac] $1"
}

echo "Updating dnf packages... you may have to enter your password here"
sudo dnf upgrade

echo "Installing dependencies.."
sudo dnf install git \
    perl \
    python3 \
    python3-pip \
    gperf \
    autoconf \
    bc \
    bison \
    gcc \
    clang \
    make \
    -y

sudo dnf group install "development-tools" -y

sudo dnf install \
    flex \
    ca-certificates \
    ccache \
    gperftools-devel \
    numactl \
    perl-doc \
    libfl2 \
    libfl-devel \
    zlib-ng \
    zlib-ng-devel \
    qemu qemu-user \
    gtkwave \
    jq \
    -y

# Install Verilator
echo "Installing Verilator"
sudo dnf install verilator -y
verilator --version

echo "Installing riscv-gnu-toolchain... this may require your password..."
# shellcheck disable=SC1091
tools_download_link="https://github.com/Emiral46/Lab0-devtools/releases/download/v1.0.0/riscv-gnu-toolchain-2022-09-21-Linux-x86_64.tar.gz"

cd /tmp
rm -rf riscv-gnu-toolchain.tar.gz
curl --output riscv-gnu-toolchain.tar.gz -L "${tools_download_link}"
sudo rm -rf /opt/riscv
sudo tar -xzf riscv-gnu-toolchain.tar.gz --directory /opt
export PATH="/opt/riscv/bin:$PATH"
if ! grep "/opt/riscv/bin" ~/.bashrc > /dev/null; then
    # shellcheck disable=SC2016
    printf '\n%s' 'export PATH="/opt/riscv/bin:$PATH"' >> ~/.bashrc
fi
rm -rf riscv-gnu-toolchain.tar.gz
