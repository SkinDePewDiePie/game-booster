@ECHO OFF
if "%~1" EQU "" (
    exit /B
)

:color
set "param=^%~2" !
set "param=!param:"=\"!"
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"

if "%~1" EQU "/withOutUAC" (
    if "%~2" EQU "" (
        exit /B
    ) else (
        start "runhigh" /high "%~2"
    )
)

if "%~1" EQU "/withUAC" (
    if "%~2" EQU "" (
        exit /B
    ) else (
        echo CreateObject^("Shell.Application"^).ShellExecute "%~2", "", "", "runas", 10 > "%temp%\uacPrompt.vbs"
        "%temp%\uacPrompt.vbs"
        del "%temp%\uacPrompt.vbs"
        pushd "%CD%"
        cd /D "%~dp0"

        exit /B
   )
)
