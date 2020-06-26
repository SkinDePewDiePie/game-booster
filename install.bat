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

for %%i in(0 1 2) do(
  set /a points=%%i

  if %points% equ 0(
    cls
    echo Ajout des valeurs sur le registre.
    reg add HKCR\exefile\shell\game_booster
    reg add HKCR\exefile\shell\game_booster /v @ /t REG_SZ /d "Open with Game Booster"
    reg add HKCR\exefile\shell\game_booster /v Icon /t REG_SZ /d "%path%\icon.ico"
  )

  if %points% equ 1(
    cls
    echo Ajout des valeurs sur le registre..
     
  )

  if %points% equ 2(
    cls
    echo Ajout des valeurs sur le registre...
    set /a points=3
  )
)

timeout /t 03 /nobreak > nul
exit
