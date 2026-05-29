@echo off
title Windows Defender Main Folder Deleter

echo ===============================================
echo  Starting deletion of: C:\ProgramData\Microsoft\Windows Defender
echo ===============================================

REM Check if the folder exists first (RD /S /Q checks for existence and deletes silently)
IF EXIST "C:\ProgramData\Microsoft\Windows Defender" (
    
    REM RD stands for Remove Directory. 
    REM /S means delete all subdirectories and files inside Windows Defender.
    REM /Q means Quiet mode (no confirmation prompt).
    RD /S /Q "C:\ProgramData\Microsoft\Windows Defender"
    
    echo [SUCCESS] Folder deleted successfully!
) ELSE (
    echo [INFO] The target folder was NOT found on the system. No deletion needed.
)

echo.
echo ===============================================
pause
