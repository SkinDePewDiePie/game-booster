@ECHO OFF
net session > nul 2>&1
if %errorLevel% equ 1(
  echo CreateObject^("Shell.Application"^).ShellExecute "cmd.exe", "/c %~0", "", "runas", 10 > "%temp%\uacPrompt.vbs"
  "%temp%\uacPrompt.vbs"
  del "%temp%\uacPrompt.vbs"
)

"%CD%\utils\getIniValue.bat" Config "%CD%\config.ini" Folder > %temp%\folderToInstall.tmp
set /a path=<"%temp%\folderToInstall.tmp"
del "%temp%\folderToInstall.tmp"

reg query HCKR\exefile\shell\game_booster > nul
if %errorlevel% equ 0(
  echo Game Booster is already installed.
  goto :end
)

for %%i in(0 1 2) do(
  set /a points=%%i

  if %points% equ 0(
    cls
    echo Adding the registry keys.

    reg add HKCR\exefile\shell\game_booster
    reg add HKCR\exefile\shell\game_booster /v @ /t REG_SZ /d "Open with Game Booster"
    reg add HKCR\exefile\shell\game_booster /v Icon /t REG_SZ /d "%path%\icon.ico"

    reg add HKCR\exefile\shell\game_booster_admin
    reg add HKCR\exefile\shell\game_booster_admin /v @ /t REG_SZ /d "Open with Game Booster (admin)"
    reg add HKCR\exefile\shell\game_booster_admin /v HasLuaShield /t REG_SZ /d ""
    reg add HKCR\exefile\shell\game_booster_admin /v Icon /t REG_SZ /d "%path%\icon.ico"
  )

  if %points% equ 1(
    cls
    echo Adding the registry keys..
    
    reg add HKCR\exefile\shell\game_booster\command
    reg add HKCR\exefile\shell\game_booster\command /v @ /t REG_SZ /d "cmd /c \"start /min %path%\\app\\booster.vbs /withOutUAC \"%1\"\""
    reg add HKCR\exefile\shell\game_booster\command /v IsolatedCommand /t REG_SZ /d "cmd /c \"start /min %path%\\app\\booster.vbs /withOutUAC \"%1\"\""
  )

  if %points% equ 2(
    cls
    echo Adding the registry keys...

    reg add HKCR\exefile\shell\game_booster_admin\command
    reg add HKCR\exefile\shell\game_booster_admin\command /v @ /t REG_SZ /d "cmd /c \"start /min %path%\\app\\booster.vbs /withUAC \"%1\"\""
    reg add HKCR\exefile\shell\game_booster_admin\command /v IsolatedCommand /t REG_SZ /d "cmd /c \"start /min %path%\\app\\booster.vbs /withUAC \"%1\"\""

    goto :end
    set /a points=3
  )
)

:end
timeout /t 03 /nobreak > nul
exit
