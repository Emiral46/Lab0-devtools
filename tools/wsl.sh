#!/usr/bin/env bash

# Author : Emir Alemdar
# Year   : 2025

set -euo pipefail

echo () {
    printf "\n%b\n" "[iac] $1"
}

gzip_code=0

echo "Testing gzip"
gzip 2>/dev/null || gzip_code=$?
if [ "${gzip_code}" -eq 126 ]; then
    echo "Broken gzip detected; applying patch... you may need to enter your password..."
    printf '\x10' | sudo dd of=/usr/bin/gzip count=1 bs=1 conv=notrunc seek=$((0x189))
else
    echo "gzip working correctly"
fi

# Fix GTKwave warnings in WSL
echo -e '\nexport $(dbus-launch)' >> ~/.bashrc

echo "Installing usbipd library on Windows. This may require administrator access."
powershell.exe /c "winget install usbipd" || true
