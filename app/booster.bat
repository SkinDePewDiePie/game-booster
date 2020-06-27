@ECHO OFF
if "%~1" EQU "" (
    goto :help
)

:color
set "param=^%~2" !
set "param=!param:"=\"!"
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"

if "%~1" EQU "/withOutUAC" (
    if "%~2" EQU "" (
        goto :help
    ) else (
        start "runhigh" /high "%~2"
    )
)

if "%~1" EQU "/withUAC" (
    if "%~2" EQU "" (
        goto :help
    ) else (
        echo CreateObject^("Shell.Application"^).ShellExecute "cmd", '/c start "runhigh" /high "%~2"', "", "runas", 10 > "%temp%\uacPrompt.vbs"
        "%temp%\uacPrompt.vbs"
        del "%temp%\uacPrompt.vbs"
   )
)

:help
echo Game Booster for Windows
echo.
echo Command format:
echo %~n0
call :color 0F "[uacOrNo] [file]"
echo.
call :color 07 "  - uacOrNo: "
call :color 0F "Use UAC (/withUAC) or no (/withOutUAC)." & echo.
call :color 07 "  - file: " 
call :color 0F "The game/file to run with Game Booster."
echo.
echo Created by MisterMatteo_o.
echo.
