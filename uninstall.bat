@ECHO OFF
net session > nul 2>&1
if %errorLevel% equ 1(
  echo CreateObject^("Shell.Application"^).ShellExecute "cmd.exe", "/c %~0", "", "runas", 10 > "%temp%\uacPrompt.vbs"
  "%temp%\uacPrompt.vbs"
  del "%temp%\uacPrompt.vbs"
)

reg query HCKR\exefile\shell\game_booster > nul
if %errorlevel% equ 1(
  echo Game Booster is not installed.
  goto :end
)

for %%i in(0 1 2) do(
  set /a points=%%i

  if %points% equ 0(
    cls
    echo Deleting the registry keys.

    reg delete HKCR\exefile\shell\game_booster
  )

  if %points% equ 1(
    cls
    echo Deleting the registry keys..
    
    reg delete HKCR\exefile\shell\game_booster_admin
  )

  if %points% equ 2(
    cls
    echo Deleting the registry keys... 

    goto :end
    set /a points=3
  )
)

:end
timeout /t 03 /nobreak > nul
exit
