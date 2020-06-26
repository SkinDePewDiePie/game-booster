@ECHO OFF
if "%~0" equ ""(
  goto :help

) else(

if "%~1" equ ""(
    goto :help
 
  )
)

:help
echo WGET for Windows
echo Command format:
echo wget.bat [37m(file to download)[0m [37m(save to the file)[0m
echo Created by MisterMatteo_o.
