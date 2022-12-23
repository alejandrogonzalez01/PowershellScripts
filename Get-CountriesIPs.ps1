$CSV_PATH = "CHANGE ME" ## Column name for IPs should be RemoteIP
$IPs = Import-Csv $CSV_PATH

$API = "https://api.iplocation.net/?ip="
$DATA_Output = @()
foreach($IP in $IPs){
    $url = $API + $IP.RemoteIP
    $content = curl $url
    $data = $content | ConvertFrom-Json
    $IP = $data.ip
    $Country = $data.country_name
    Write-Host "Finished $IP"

    $obj = New-Object -TypeName PSObject
    $obj | Add-Member NoteProperty -Name "IP" -Value $IP
    $obj | Add-Member NoteProperty -Name "Country" -Value $Country

    $DATA_Output += $obj
    
}

$DATA_Output | Export-Csv "IP_AND_COUNTRY.csv"