@echo off
setlocal

set "PROJECT_DIR=%~dp0.."
for %%i in ("%PROJECT_DIR%\..\..") do set "REPO_DIR=%%~fi"
set "ANDROID_HOME=%REPO_DIR%\.runtime\android-sdk"
set "ANDROID_SDK_ROOT=%ANDROID_HOME%"
set "ANDROID_AVD_HOME=%REPO_DIR%\.runtime\avd"
set "PATH="
set "Path=%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\emulator;C:\Windows\System32;C:\Windows;C:\Windows\System32\WindowsPowerShell\v1.0"

start "" "%ANDROID_HOME%\emulator\emulator.exe" -avd Medium_Phone -no-snapshot-load

endlocal
