@ECHO OFF
if "%~1" EQU "" (
    exit /B
)

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