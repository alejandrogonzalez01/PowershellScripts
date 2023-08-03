## Script will Get DHCP Leases and cross reference it with Active Directory to identify "Active AD Computers"


$SCOPEIDs = $("10.1.0.0", "10.17.0.0", "10.4.0.0", "10.4.0.0", "192.168.20.0", "10.10.0.0", "10.7.0.0")
$DHCPLeases = @()
$DHCPComputers = @()
$ActiveADComputers = @()
$DNS_TLD = ".jupiter.com"
foreach($SCOPE in $SCOPEIDs){
    $DHCPLeases += Get-DhcpServerv4Lease -ScopeId $SCOPE
    $DHCPLeases += Get-DhcpServerv4Reservation -ScopeId $SCOPE
}
$DHCPLeases = $DHCPLeases | Select Hostname, IPAddress  -Unique
$ADComputers = Get-ADComputer -Filter "Enabled -eq '$True' -and DNSHostName -like '*jupiter.com'" -Properties * | Select DNSHostName, Enabled, LastLogonDate

foreach($Computer in $ADComputers){
    $DNSName = $Computer.DNSHostName
    if($DHCPLeases.Hostname -contains $DNSName){
        $ActiveADComputer_HostName = $DNSName
        $ActiveADComputer_IP = $DHCPLeases.IPAddress.IPAddressToString[$DHCPLeases.Hostname.IndexOf($DNSName)]
        $obj = New-Object -TypeName PSObject
        $obj | Add-Member NoteProperty -Name "HostName" -Value $ActiveADComputer_HostName
        $obj | Add-Member NoteProperty -Name "IPAddress" -Value $ActiveADComputer_IP

        $ActiveADComputers += $obj
    }
}


$ActiveADComputers | export-csv ActiveADComputers.csv

