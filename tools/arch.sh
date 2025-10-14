#!/usr/bin/env bash

# Author : Emir Alemdar
# Year   : 2025

AUR_HELPER=""

echo () {
    printf "\n%b\n" "[iac] $1"
}

echo "Updating pacman packages... you may have to enter your password here"
sudo pacman -Syu

echo "Installing dependencies.."
sudo pacman -S \
    perl \
    python3 \
    python-pip \
    gperf \
    autoconf \
    bc \
    bison \
    gcc \
    clang \
    make

sudo pacman -S \
    flex \
    base-devel \
    ca-certificates \
    ccache \
    gperftools \
    numactl \
    zlib \
    qemu \
    qemu-user \
    gtkwave \
    jq

# Install Verilator
echo "Installing Verilator"
sudo pacman -S verilator
verilator --version

if [ -f /usr/bin/yay ]; then
    AUR_HELPER="yay"
elif [ -f /usr/bin/paru ]; then
    AUR_HELPER="paru"
elif [ -f /usr/bin/pikaur ]; then
    AUR_HELPER="pikaur"
elif [ -f /usr/bin/trizen ]; then
    AUR_HELPER="trizen"
else
    echo "AUR helper not found. Compiling aur packages manually..."
fi

# Install riscv-gnu-toolchain
echo "Installing riscv-gnu-toolchain from AUR..."
if [ -n "$AUR_HELPER" ]; then
    "$AUR_HELPER" -S riscv-gnu-toolchain-bin
else
    git clone https://aur.archlinux.org/riscv-gnu-toolchain-bin.git
    cd riscv-gnu-toolchain-bin
    makepkg -si
    cd ..
    rm -rf riscv-gnu-toolchain-bin
fi

echo "Installing Visual Studio Code from AUR... If you installed Code-OSS from pacman, make sure to type y to the prompt for removing it..."
if [ -n "$AUR_HELPER" ]; then
    "$AUR_HELPER" -S visual-studio-code-bin
else
    git clone https://aur.archlinux.org/visual-studio-code-bin.git
    cd visual-studio-code-bin
    makepkg -si
    cd ..
    rm -rf visual-studio-code-bin
fi
