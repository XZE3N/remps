[void][reflection.assembly]::loadwithpartialname("system.windows.forms")
[system.windows.forms.sendkeys]::sendwait('{PRTSC}')
Get-Clipboard -Format Image | ForEach-Object -MemberName Save -ArgumentList "c:\Users\$env:UserName\screenshot.png"