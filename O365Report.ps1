## Office365 Mailbox Report that outputs DisplayName, Email, MailboxType,  HiddenFromAddressListsEnabled, 
## IsLicensed, WhenCreated, LastPasswordChange, LastLogonTime, LastInteractionTime, LastLogoffTime


$DATA = @()
$O365_Emails = Get-Mailbox

Foreach($term in $O365_Emails){
    $email = $term.UserPRincipalName
    Write-Host "Checking $email"
    $user_data = Get-MsolUser -UserPrincipalName $email
    $email_data = Get-Mailbox $email
    $mailbox_stats = Get-MailboxStatistics -Identity $email

    $displayName = $term.DisplayName
    $MailboxType = $term.RecipientTypeDetails
    $GAL = $email_data.HiddenFromAddressListsEnabled
    $IsLicensed = $user_data.isLicensed
    $WhenCreated = $user_data.WhenCreated
    $LastPasswordChange = $user_data.LastPasswordChangeTimeStamp
    $LastLogonTime = $mailbox_stats.LastLogonTime
    $LastInteractionTime = $mailbox_stats.LastInteractionTime
    $LastLogoffTime = $mailbox_stats.LastLogoffTime


    $obj = New-Object -TypeName psobject
    $obj | Add-Member NoteProperty -Name "DisplayName" -Value $DisplayName
    $obj | Add-Member NoteProperty -Name "Email" -Value $email
    $obj | Add-Member NoteProperty -Name "MailboxType" -Value $MailboxType
    $obj | Add-Member NoteProperty -Name "HiddenFromAddressListsEnabled" -Value $GAL
    $obj | Add-Member NoteProperty -Name "IsLicensed" -Value $IsLicensed
    $obj | Add-Member NoteProperty -Name "WhenCreated" -Value $WhenCreated
    $obj | Add-Member NoteProperty -Name "LastPasswordChange" -Value $LastPasswordChange
    $obj | Add-Member NoteProperty -Name "LastLogonTime" -Value $LastLogonTime
    $obj | Add-Member NoteProperty -Name "LastInteractionTime" -Value $LastInteractionTime
    $obj | Add-Member NoteProperty -Name "LastLogoffTime" -Value $LastLogoffTime
    $DATA += $obj

}

Out-GridView | $DATA