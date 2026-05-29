Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Path = "C:\Program Files\Windows Defender"

Write-Host "Target: $Path"

takeown /f $Path /a /r /d y | Out-Null
icacls $Path /grant Administrators:F /t /c | Out-Null
Remove-Item -Path $Path -Recurse -Force

Write-Host "Done."
