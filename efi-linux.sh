#!/usr/bin/env bash
set -e

printf "EFI Unlocker 1.0.0 for VMware Workstation\n"
printf "=========================================\n"
printf "(c) Dave Parsons 2018\n\n"

# Ensure we only use unmodified commands
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

printf "Patching 32-bit ROM...\n"
cp -v /usr/lib/vmware/roms/EFI32.ROM .
./linux/UEFIPatch EFI32.ROM patches.txt -o EFI32-MACOS.ROM
rm -fv EFI32.ROM

printf "\nPatching 64-bit ROM...\n"
cp -v /usr/lib/vmware/roms/EFI64.ROM .
./linux/UEFIPatch EFI64.ROM patches.txt -o EFI64-MACOS.ROM
rm -fv EFI64.ROM

printf "\nFinished!\n"
