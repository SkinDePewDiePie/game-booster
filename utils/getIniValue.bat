@ECHO OFF
if "%1" equ "" (
  goto :help
)

if "%2" equ "" (
  goto :help
) else (
  goto :main
)

for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
)

:help
echo Getting INI Value for Windows
echo.
echo Command format:
echo %~0 %ESC%[97m[key] [file] %ESC%[0m
echo.
echo %ESC%[97m  - key: %ESC%[0m
echo %ESC%[97m    For getting the values of a specified key. %ESC%[0m & echo.
echo %ESC%[97m  - file: %ESC%[0m
echo %ESC%[97m    For getting the file. %ESC%[0m & echo.
echo.
echo Created by MisterMatteo_o.
echo.

:main
for /F "tokens=1,2" %%a in (%2) do (
  echo %%a | findstr %1
)