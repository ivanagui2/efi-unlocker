@echo off
setlocal ENABLEEXTENSIONS
echo.
echo EFI Unlocker 1.0.0 for VMware Workstation
echo =========================================
echo (c) Dave Parsons 2018
echo.
echo Set encoding parameters...
chcp 850

net session >NUL 2>&1
if %errorlevel% neq 0 (
    echo Administrator privileges required!
    exit /b
)

echo.
set KeyName="HKLM\SOFTWARE\Wow6432Node\VMware, Inc.\VMware Player"
:: delims is a TAB followed by a space
for /F "tokens=2* delims=	 " %%A in ('REG QUERY %KeyName% /v InstallPath') do set InstallPath=%%B
echo VMware is installed at: %InstallPath%

for /F "tokens=2* delims=	 " %%A in ('REG QUERY %KeyName% /v ProductVersion') do set ProductVersion=%%B
echo VMware product version: %ProductVersion%

for /F "tokens=1,2,3,4 delims=." %%a in ("%ProductVersion%") do (
   set Major=%%a
   set Minor=%%b
   set Revision=%%c
   set Build=%%d
)

:: echo Major: %Major%, Minor: %Minor%, Revision: %Revision%, Build: %Build%

:: Check version is gt 14
if %Major% lss 14 (
    echo VMware Workatation/Player version 14 or greater required!
    exit /b
)

pushd %~dp0

echo.
echo Patching 32-bit ROM...
xcopy /F /Y "%InstallPath%x64\EFI32.ROM" .
.\windows\uefipatch.exe EFI32.ROM patches.txt -o EFI32-MACOS.ROM
del /f EFI32.ROM

echo.
echo Patching 64-bit ROM...
xcopy /F /Y "%InstallPath%x64\EFI64.ROM" .
.\windows\uefipatch.exe EFI64.ROM patches.txt -o EFI64-MACOS.ROM
del /f EFI64.ROM

popd
echo.
echo Finished