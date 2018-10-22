macOS EFI Unlocker V1.0 for VMware
==================================

1. Introduction
---------------

The macOS EFI Unlocker removes the check for server versions of Mac OS X verisons:

* 10.5 Leopard
* 10.6 Snow Leopard

allowing the non-server versions of Mac OS X to be run with VMware products. Later versions of Mac OS X and macOS
do not need the modified firmware due to Apple removing the restrictions imposed on 10.5 and 10.6.

EFI Unlocker 1 is designed for the following products:

* VMware Workstation and Player versions 14/15
* VMware Fusion versions 10/11

The checks for the server versions are done in VMware's virtual EFI firmware and looks for a file called
ServerVersion.plist in the installation media and the installed OS. The patch modifies the firmware to check
for a file present on all versions of Mac OS X called SystemVersion.plist.

The patch uses a tool called UEFIPatch to make the modifications.

Please note you may need to use macOS Unlocker version 3 to run on non-Apple hardware.

2. Patching the firmware
------------------------

Windows open a command prompt and run: efi-windows.cmd
Linux open a terminal session and run: efi-linux.sh
macOS open a terminal session and run: efi-macos.sh

The patched firmware files will be found in the same folder as the tool and are called:

EFI32-MACOS.ROM - 32-bit firmware
EFI64-MACOS.ROM - 64-bit firmware

3. Using the firmware
------------------------

There are 3 preferred ways to use the firmware, by VM, by user or by host system. For each option there are 2 possible
entries dependign on whether you are installing a 32 or 64-bit version of 10.5 or 10.6 as a guest.

32-bit:
efi32.filename = "filename"

64-bit:
efi64.filename = "filename"

You can add both and the correct one will be used based on the the guestos setting. You will need to put the full
filename for the patched files into the double quotes.

Before doing this make sure the VM is powered down and VMware is not running.

Per VM:
Open the vmx file for the guest and add the relevant lines from above.

Per User:
Add the 2 lines to the user defaults file which can be found in the following paths.
Windows: %APPDATA%\VMware\config.ini
Linux: ~/.vmware/config
macOS: ~/Library/Preferences/VMware Fusion/config

Per host:
Windows: %PROGRAMDATA%\VMware\VMware Workstation\config.ini
Linux: /etc/vmware/config
macOS: /Library/Preferences/VMware Fusion/config

4. Thanks
---------

Thanks goes to the UEFITools project for the patching tool used to modify the firmware.
https://forums.mydigitallife.net/threads/uefitool-uefi-firmware-image-viewer-and-editor.48979/
https://github.com/LongSoft/UEFITool

History
-------
21/10/18 1.0.0 - First release

(c) 2018 Dave Parsons
