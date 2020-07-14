@ECHO OFF
if "%~1" equ "" (
  goto :help
)

if "%~2" equ "" (
  goto :help
)

if "%~3" neq "" (
  set /a timeout=%3
) else (
  set /a timeout=5
)

bitsadmin /cancel wgettingAFile > nul
bitsadmin /create /download wgettingAFile > nul
bitsadmin /addFile wgettingAFile %1 %2 > nul  
bitsadmin /resume wgettingAFile > nul
bitsadmin /setproxysettings wgettingAFile AUTODETECT > nul

set /a attempts=0
:repeat
set /a attempts+=1
if "%attempts%" equ 10 (
  call :color 0C "A timeout has occcured. Check your internet connection and retry."
)
bitsadmin /info wgettingAFile /verbose | find "STATE: ERROR" > nul 2>&1 && bitsadmin /cancel wgettingAFile && call :color 0C "An error has occured. Retry."
bitsadmin /info wgettingAFile /verbose | find "STATE: TRANSFERRED" > nul 2>&1 && goto :finish

w32tm /stripchart /computer:localhost /period:1 /dataonly /samples:%timeout% > nul 2>&1
goto :repeat

:finish
bitsadmin /complete wgettingAFile > nul
goto :end

for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
)

:help
echo WGET for Windows
echo.
echo Command format:
echo %~0 %ESC%[97m[url] [file] (timeout) %ESC%[0m
echo.
echo %ESC%[97m  - url: %ESC%[0m
echo %ESC%[97m    For wgetting a file on the World-Wide Web. %ESC%[0m & echo.
echo %ESC%[97m  - file: %ESC%[0m
echo %ESC%[97m    For saving the wgetted file with a name. %ESC%[0m & echo.
echo %ESC%[97m  - timeout:
echo %ESC%[97m    (Optional) Limit the time to ping the server. This is in seconds. %ESC%[0m
echo.
echo Created by MisterMatteo_o.
echo.

:end
echo WGET for Windows
echo.
echo %ESC%[97m%2 is finished. %ESC%[0m