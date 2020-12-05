$url = "https://github.com/XZE3N/remps/archive/main.zip"
$output = "C:\Users\$env:UserName\main.zip"
$start_time = Get-Date
$location = "C:\Users\$env:UserName\"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)

Expand-Archive -Path $output -DestinationPath $location -Force
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)" 
rm $output