#!/usr/bin/env bash
set -e

printf "EFI Unlocker 1.0.0 for VMware Workstation\n"
printf "=========================================\n"
printf "(c) Dave Parsons 2018\n\n"

# Ensure we only use unmodified commands
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

version=`grep -i player.product.version /etc/vmware/config | cut -d'"' -f2- | rev | cut -c 2- | rev`
build=`grep -i product.buildnumber /etc/vmware/config | cut -d'"' -f2- | rev | cut -c 2- | rev`
IFS='.' read -a product <<< "$version"

printf "VMware product version: ${version}.${build}\n\n"
#printf "Major:    ${product[0]}\n"
#printf "Minor:    ${product[1]}\n"
#printf "Revision: ${product[2]}\n"
#printf "Build:    ${build}\n"

# Check version is 14+
if [[ ${product[0]} -lt 14 ]]; then
   printf "VMware Workatation/Player version 14 or greater required!\n"
   exit 1
fi

printf "Patching 32-bit ROM...\n"
cp -v /usr/lib/vmware/roms/EFI32.ROM .
./linux/UEFIPatch EFI32.ROM patches.txt -o EFI32-MACOS.ROM
rm -fv EFI32.ROM

printf "\nPatching 64-bit ROM...\n"
cp -v /usr/lib/vmware/roms/EFI64.ROM .
./linux/UEFIPatch EFI64.ROM patches.txt -o EFI64-MACOS.ROM
rm -fv EFI64.ROM

printf "\nFinished!\n"
