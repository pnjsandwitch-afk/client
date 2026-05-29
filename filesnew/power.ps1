$Path = "testpath"

Write-Host "Target: $Path"

Start-Process cmd -ArgumentList "/c takeown /f `"$Path`" /a /r /d y" -Verb RunAs -Wait
Start-Process cmd -ArgumentList "/c icacls `"$Path`" /grant Administrators:F /t /c" -Verb RunAs -Wait

Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Done."
