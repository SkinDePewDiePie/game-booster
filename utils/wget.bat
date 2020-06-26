@ECHO OFF
if "%~0" equ ""( goto :help )
if "%~1" equ ""( goto :help )

:help
echo WGET for Windows
echo Command format:
echo wget.bat [37m[(file to download)[0m
