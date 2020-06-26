@ECHO OFF
if "%~1" equ ""(
  goto :help
)

if "%~2" neq ""(
  set /a subKey="%~2"
)

set /a key="%~1"

:color
set "param=^%~2" !
set "param=!param:"=\"!"
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"

:help
echo INI File for Windows
echo.
echo Command format:
echo %~n0
call :color 0F "[key] (subKey) +"
echo.
call :color 07 "  - key: "
call :color 0F "For getting the values of a specified key."
call :color 07 "  - subKey: " 
call :color 0F "(Optional) For getting a value of a specified sub-key."
echo.
echo Created by MisterMatteo_o.
echo.
