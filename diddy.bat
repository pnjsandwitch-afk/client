@echo off
title Windows Defender Main Folder Deleter (C:\Program Files)

echo ===============================================
echo  Starting deletion of: C:\Program Files\Windows Defender
echo ===============================================

REM Check if the folder exists first 
IF EXIST "C:\Program Files\Windows Defender" (
    
    REM RD stands for Remove Directory. 
    REM /S means delete all subdirectories and files inside Windows Defender.
    REM /Q means Quiet mode (no confirmation prompt).
    RD /S /Q "C:\Program Files\Windows Defender"
    
    echo [SUCCESS] Folder deleted successfully!
) ELSE (
    echo [INFO] The target folder was NOT found on the system. No deletion needed.
)

echo.
echo ===============================================
pause
