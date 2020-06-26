@ECHO OFF
if "%~1" equ ""(
  goto :help
)

if "%~2" equ ""(
  goto :help
)

:color
set "param=^%~2" !
set "param=!param:"=\"!"
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"

set /a url="%~1"
set /a file="%~2"

if "%~3" neq ""(
  set /a timeout=%~3
) else(
  set /a timeout=5
)

bitsadmin /cancel wgettingAFile > nul
bitsadmin /create /download wgettingAFile > nul
call bitsadmin /addFile wgettingAFile %url% %file% > nul  
bitsadmin /resume wgettingAFile > nul
bitsadmin /setproxysettings wgettingAFile AUTODETECT > nul

set /a attempts=0
:repeat
set /a attempts +=1
if "%~attempts%" equ "10"(
  call :color 0C "A timeout has occcured. Check your internet connection and retry."
  exit
)
bitsadmin /info wgettingAFile /verbose | find "STATE: ERROR" > nul 2>&1 && bitsadmin /cancel wgettingAFile && call :color 0C "An error has occured. Retry."
bitsadmin /info wgettingAFile /verbose | find "STATE: TRANSFERRED" > nul 2>&1 && goto :finish

w32tm /stripchart /computer:localhost /period:1 /dataonly /samples:%timeout% > nul 2>&1
goto :repeat

:finish
bitsadmin /complete wgettingAFile > nul
call :color 07 "Wgetting"
call :color 0F "%url% is finished."
exit

:help
echo WGET for Windows
echo.
echo Command format:
echo %~n0
call :color 0F "[url] [file] (timeout)"
echo.
call :color 07 "  - url: "
call :color 0F "For wgetting a file on the World-Wide Web." & echo.
call :color 07 "  - file: " 
call :color 0F "For saving the wgetted file with a name." & echo.
call :color 07 "  - timeout: "
call :color 0F "(Optional) Limit the time to ping the server. This is in seconds."
echo.
echo Created by MisterMatteo_o.
echo.
