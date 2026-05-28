@echo off
REM ===============================================
REM Configuration Variables
REM ===============================================
SET "SCRIPT_NAME=%~nx0"

REM --- 1. ADMIN CHECK & ELEVATION ROUTINE (The "No Ask") ---
net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Running as standard user... Relaunching minimized as Administrator!
    goto :RelaunchAdmin
) else (
    REM Script is already running as admin, proceed directly to main execution
    goto :MainExecution
)

:RelaunchAdmin
REM Launch a new instance of this script MINIMIZED and wait for it to finish.
start "" /min /wait "%SCRIPT_NAME%"
exit /b


:MainExecution
REM --- 2. VISUAL CLUTTER REDUCTION (Minimal Output) ---
title Windows Security DELETED!

@echo off
setlocal enabledelayedexpansion

REM Minimal initial feedback loop
echo =============================== > nul 2>&1
echo  DELETING SECURITY POLICIES... >> nul 2>&1
echo =============================== >> nul 2>&1
timeout /t 1 > nul


REM ===============================================
REM --- CORE DELETION LOGIC (The "Delete Forever") ---
REM ===============================================

REM --- A. DELETE WINDOWS DEFENDER POLICIES & FEATURES ---
echo [!] Deleting Windows Defender Policy Keys...
reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows Defender\Features" /f >nul 2>&1

REM Delete specific feature settings that were previously set to '0' (disabled) or '1' (enabled)
echo [!] Deleting Real-Time Protection Settings...
reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /f >nul 2>&1

echo [!] Deleting SpyNet/Reporting Settings...
reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\SpyNet" /f >nul 2>&1
reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Reporting" /f >nul 2>&1


REM --- B. DELETE CORE SECURITY SERVICES (Making them permanently absent/disabled) ---
echo [!] Deleting Service Startup Configurations...

REM Delete the startup key for core services instead of just setting it to 'disabled'
sc delete WinDefend >nul 2>&1
sc delete SecurityHealthService >nul 2>&1
sc delete WdBoot >nul 2>&1
sc delete wdFilter >nul 2>&1
sc delete WdNisDrv >nul 2>&1
sc delete WdNisSvc >nul 2>&1
sc delete "Wscsvc" >nul 2>&1

REM --- C. CLEANUP OTHER SECURITY SETTINGS (Optional but recommended) ---
echo [!] Cleaning up other related settings...
reg delete "HKLM\Software\Policies\Microsoft\MRT" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /f >nul 2>&1


REM ===============================================
REM --- FINALIZATION ---
REM ===============================================

echo. >> nul 2>&1
echo ✅ ALL MAJOR SECURITY POLICIES DELETED!          >> nul 2>&1
echo (Reboot recommended to ensure all services are gone) >> nul 2>&1
echo. >> nul 2>&1

:EndScript
pause
exit /b
