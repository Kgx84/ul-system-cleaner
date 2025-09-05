@echo off
REM SystemCleaner - Full Cleaning Tool
setlocal enabledelayedexpansion
set "log_file=%~dp0CleanLog.txt"

:menu
cls

echo =============================
echo      SystemCleaner Tool
echo =============================
echo.
echo Welcome to SystemCleaner by UnseenLight Team!
echo.
echo UnseenLight is a global, volunteer-run initiative of students and creators, born in Algeria and dedicated to fostering digital independence for the visually impaired worldwide.
echo We believe in accessible technology for everyone, and our tools are crafted with passion and inclusivity.
echo.
echo =============================
echo Select cleaning options:
echo 1. Clean Temp folders
echo 2. Clean Recycle Bin
echo 3. Clean Prefetch files
echo 4. Clean Recent files
echo 5. Clean Edge cache
echo 6. Clean Chrome cache
echo 7. Clean Firefox cache

set "clean_temp=no"
set "clean_recyclebin=no"
set "clean_prefetch=no"
set "clean_recent=no"
set "clean_edge=no"
set "clean_chrome=no"
set "clean_firefox=no"

set /p options=Enter option numbers separated by space (e.g. 1 2 3), or 0 to exit: 
if "%options%"=="0" goto :eof

for %%O in (%options%) do (
    if "%%O"=="1" set "clean_temp=yes"
    if "%%O"=="2" set "clean_recyclebin=yes"
    if "%%O"=="3" set "clean_prefetch=yes"
    if "%%O"=="4" set "clean_recent=yes"
    if "%%O"=="5" set "clean_edge=yes"
    if "%%O"=="6" set "clean_chrome=yes"
    if "%%O"=="7" set "clean_firefox=yes"
)

set "summary=Cleaning started at %date% %time%\n"
echo Cleaning started at %date% %time% > "%log_file%"

if "%clean_temp%"=="yes" (
    echo Cleaning Temp folders... >> "%log_file%"
    del /q /f "%USERPROFILE%\AppData\Local\Temp\*.*" >> "%log_file%" 2>&1
    del /q /f "%windir%\Temp\*.*" >> "%log_file%" 2>&1
    set "summary=!summary!Temp folders cleaned\n"
)
if "%clean_recyclebin%"=="yes" (
    echo Cleaning Recycle Bin... >> "%log_file%"
    PowerShell.exe -Command "Clear-RecycleBin -Force" >> "%log_file%" 2>&1
    set "summary=!summary!Recycle Bin cleaned\n"
)
if "%clean_prefetch%"=="yes" (
    if exist "C:\Windows\Prefetch" (
        echo Cleaning Prefetch files... >> "%log_file%"
        del /q /f "C:\Windows\Prefetch\*.*" >> "%log_file%" 2>&1
        set "summary=!summary!Prefetch files cleaned\n"
    )
)
if "%clean_recent%"=="yes" (
    echo Cleaning recent files... >> "%log_file%"
    del /q /f "%APPDATA%\Microsoft\Windows\Recent\*.*" >> "%log_file%" 2>&1
    set "summary=!summary!Recent files cleaned\n"
)
if "%clean_edge%"=="yes" (
    echo Cleaning Edge cache... >> "%log_file%"
    del /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" >> "%log_file%" 2>&1
    set "summary=!summary!Edge cache cleaned\n"
)
if "%clean_chrome%"=="yes" (
    echo Cleaning Chrome cache... >> "%log_file%"
    del /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*" >> "%log_file%" 2>&1
    set "summary=!summary!Chrome cache cleaned\n"
)
if "%clean_firefox%"=="yes" (
    echo Cleaning Firefox cache... >> "%log_file%"
    del /q /f "%APPDATA%\Mozilla\Firefox\Profiles\*\cache2\entries\*.*" >> "%log_file%" 2>&1
    set "summary=!summary!Firefox cache cleaned\n"
)

set "summary=!summary!Cleaning completed at %date% %time%!"
echo Cleaning completed at %date% %time% >> "%log_file%"

cls

echo =============================
echo      Cleaning Summary
echo =============================
echo.
echo !summary!
echo.
echo Details saved in CleanLog.txt
pause
endlocal
