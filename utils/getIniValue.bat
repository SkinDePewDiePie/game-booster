@ECHO OFF
if "%~1" equ ""(
  goto :help
)

if "%~2" equ ""(
  goto :help
)

if "%~3" neq ""(
  set /a subKey="%~2"
)

set /a key="%~1"
set /a file="%~2"
set /a flag=""

if "%~subKey" equ ""(
  for /f "tokens=*" %%a in(%file%) do(
    if "%~flag" neq ""(
      echo %%a | find "[" > nul && set /a flag="" ||(
        echo %%a
      )
    ) else(
      if "%%a" equ "%~key" set /a flag="1"
    )
  )
) else(
  for /f "tokens=2 delims==" %%a in ('find /i "%~subKey=" %~file') do echo %%a
)

:color
set "param=^%~2" !
set "param=!param:"=\"!"
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"

:help
echo Getting INI Value for Windows
echo.
echo Command format:
echo %~n0
call :color 0F "[key] [file] (subKey)"
echo.
call :color 07 "  - key: "
call :color 0F "For getting the values of a specified key." & echo.
call :color 07 "  - file: "
call :color 0F "For getting the file." & echo.
call :color 07 "  - subKey: " 
call :color 0F "(Optional) For getting a value of a specified sub-key."
echo.
echo Created by MisterMatteo_o.
echo.
