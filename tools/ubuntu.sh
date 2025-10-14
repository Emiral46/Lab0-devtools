#!/usr/bin/env bash

# Author : Emir Alemdar
# Year   : 2025

echo () {
    printf "\n%b\n" "[iac] $1"
}

echo "Updating apt packages... you may have to enter your password here"
sudo apt update

echo "Installing dependencies.."
sudo apt install -y git \
    perl \
    python3 \
    python3-pip \
    gperf \
    autoconf \
    bc \
    bison \
    gcc \
    clang \
    make

sudo apt install -y \
    flex \
    build-essential \
    ca-certificates \
    ccache \
    libgoogle-perftools-dev \
    numactl \
    perl-doc \
    libfl2 \
    libfl-dev \
    zlib1g \
    zlib1g-dev \
    qemu qemu-user \
    gtkwave \
    jq

# Install Verilator
echo "Installing Verilator"
sudo apt install -y verilator
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
