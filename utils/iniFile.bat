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
