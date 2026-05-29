@echo off
title Windows Defender Real Time Protection Disabler (Instant)

echo ===============================================
echo  Applying Real-Time Protection Disable...
echo ===============================================

REM --- 1. Set Registry Key: DisableRealtimeMonitoring = 1 ---
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f
echo [SUCCESS] Registry Key set!

REM --- 2. Force Policy Update ---
gpupdate /force
echo [SUCCESS] Group Policy updated to reflect change immediately.

REM --- 3. Restart Core Services (The immediate refresh) ---
net stop WinDefend
echo [INFO] Stopping Windows Defender Service...

net start WinDefend
echo [SUCCESS] Starting Windows Defender Service again!

echo.
echo ===============================================
echo  ✅ COMPLETE! ✅
echo Check the Windows Security GUI now to see RTP disabled instantly.
pause
