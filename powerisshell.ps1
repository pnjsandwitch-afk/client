@echo off
title Windows Defender Robust Deleter (TI $\rightarrow$ Admin)

set "TargetFolder=C:\Program Files\Windows Defender"

IF EXIST "%TargetFolder%" (
    
    echo ===============================================
    echo  Attempt 1: Deleting using TrustedInstaller...
    echo ===============================================
    
    REM Try to delete using the runas command targeting TrustedInstaller credentials
    runas /user:TrustedInstaller "cmd /c rd /s /q "%TargetFolder%""
    
    IF %ERRORLEVEL% EQU 0 (
        echo [SUCCESS] Folder deleted successfully via TrustedInstaller!
    ) ELSE (
        echo [WARNING] TrustedInstaller deletion failed. Trying Administrator privileges...
        
        REM Attempt 2: Delete using current Admin context
        rd /s /q "%TargetFolder%"
        
        IF %ERRORLEVEL% EQU 0 (
            echo [SUCCESS] Folder deleted successfully via Administrator!
        ) ELSE (
            echo ===============================================
            echo  ❌ FATAL FAILURE: Both attempts failed. Check permissions/locks.
            echo ===============================================
        )
    )

) ELSE (
    echo [INFO] The target folder "%TargetFolder%" was NOT found on the system. No deletion needed.
)

echo.
pause
