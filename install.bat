@ECHO OFF
net session > nul 2>&1
if %errorLevel% equ 1(
  echo CreateObject^("Shell.Application"^).ShellExecute "%~2", "", "", "runas", 10 > "%temp%\uacPrompt.vbs"
  "%temp%\uacPrompt.vbs"
  del "%temp%\uacPrompt.vbs"
)

for %%i in(0 1 2) do(
  set /a points=%%i

  if %points% equ 0(
     cls
     echo Ajout des valeurs sur le registre.
     reg add HKLM
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
