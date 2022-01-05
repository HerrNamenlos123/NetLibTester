@echo off

cd "%~dp0"

:: Call the script in all submodules recursively
for /D %%i in (modules/*) do (
    if exist "%~dp0modules/%%i/push-to-master.bat" (
        call "%~dp0modules/%%i/push-to-master.bat" nopause
    )
)

if [%~1] == [] (
    Pause
)