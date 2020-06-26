@ECHO OFF
if "%~1" equ ""(
  goto :help

)

if "%~2" equ ""(
    goto :help



)

set /a url="%~1"
set /a file="%~2"

if

"%~3" neq ""(

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
  echo A timeout has occcured. Check your internet connection and retry.
  exit
)
bitsadmin /info wgettingAFile /verbose | find "STATE: ERROR" > nul 2>&1 && bitsadmin /cancel wgettingAFile && echo An error has occured. Retry.
bitsadmin /info wgettingAFile /verbose | find "STATE: TRANSFERRED" > nul 2>&1 && goto :finish

w32tm /stripchart /computer:localhost /period:1 /dataonly /samples:%timeout% > nul 2>&1
goto :repeat

:finish
bitsadmin /complete wgettingAFile > nul
echo Whgetting [37m"%url%"[0 is finished.
exit




:help
echo WGET for Windows
echo.
echo Command format:
echo %~n0 [37m^[url^][0m [37m^[file^][0m
echo.
echo - url: For wgetting a file on t he World-Wide Web.
echo - file: For saving the wgetted file with a name.
echo.
echo Created by MisterMatteo_o.
echo.
