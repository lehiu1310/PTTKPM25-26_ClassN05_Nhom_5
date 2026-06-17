@echo off
setlocal

set "PROJECT_DIR=%~dp0.."
for %%i in ("%PROJECT_DIR%") do set "REPO_DIR=%%~fi"
pushd "%PROJECT_DIR%"

set "APPDATA=%REPO_DIR%\.runtime\appdata"
set "LOCALAPPDATA=%REPO_DIR%\.runtime\localappdata"
set "PUB_CACHE=%REPO_DIR%\.runtime\pub-cache"
set "GRADLE_USER_HOME=%REPO_DIR%\.runtime\gradle"
set "FLUTTER_ROOT=%REPO_DIR%\.runtime\flutter"
set "JAVA_HOME=%REPO_DIR%\.runtime\jdk\jdk-17.0.19+10"
set "ANDROID_HOME=%REPO_DIR%\.runtime\android-sdk"
set "ANDROID_SDK_ROOT=%REPO_DIR%\.runtime\android-sdk"
set "ANDROID_AVD_HOME=%REPO_DIR%\.runtime\avd"
set "PATH="
set "Path=%FLUTTER_ROOT%\bin\mingit\cmd;%FLUTTER_ROOT%\bin;%JAVA_HOME%\bin;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\emulator;C:\Windows\System32;C:\Windows;C:\Windows\System32\WindowsPowerShell\v1.0"

if not exist "%APPDATA%" mkdir "%APPDATA%"
if not exist "%LOCALAPPDATA%" mkdir "%LOCALAPPDATA%"
if not exist "%PUB_CACHE%" mkdir "%PUB_CACHE%"
if not exist "%GRADLE_USER_HOME%" mkdir "%GRADLE_USER_HOME%"

call "%FLUTTER_ROOT%\bin\flutter.bat" pub get --offline
if errorlevel 1 (
  popd
  endlocal
  exit /b 1
)

"%FLUTTER_ROOT%\bin\cache\dart-sdk\bin\dart.exe" analyze lib

popd
endlocal
