## Distribution Groups, Unified Groups, Dynamic Groups
## DisplayName, RecipientTypeDetails, PrimarySMTPAddress, DistributionGroupName (DisplayName), DistributionGroupEmail (PrimarySMTPAddress), GroupType
cls
$CompanyName = Read-Host "Type the company name"

$GroupDATA = @()

$DistributionGroups = Get-DistributionGroup
$DynamicDistributionGroups = Get-DynamicDistributionGroup
$UnifiedGroups = Get-UnifiedGroup

## Cycling through each DISTRIBUTION GROUP
foreach($DG in $DistributionGroups){
    
    $GroupName = $DG.DisplayName
    $GroupEmail = $DG.PrimarySMTPAddress
    $GroupType = "Distribution Group"

    ## Getting members
    $members = Get-DistributionGroupMember -Identity $dg.PrimarySMTPAddress

    ## Cycling through each member of current Group
    foreach($member in $members){
      $UserDisplayName = $member.DisplayName
      $UserEmail = $member.PrimarySMTPAddress
      $UserType = $member.RecipientTypeDetails

      Write-Host "$UserDisplayName ($UserEmail) is a member of $GroupName ($GroupEmail)"
      $obj = New-Object -TypeName PSObject
      $obj | Add-Member NoteProperty -Name "DisplayName" -Value $UserDisplayName
      $obj | Add-Member NoteProperty -Name "EmailAddress" -Value $UserEmail
      $obj | Add-Member NoteProperty -Name "UserType" -Value $UserType
      $obj | Add-Member NoteProperty -Name "GroupName" -Value $GroupName
      $obj | Add-Member NoteProperty -Name "GroupEmail" -Value $GroupEmail
      $obj | Add-Member NoteProperty -Name "GroupType" -Value $GroupType

      $GroupDATA += $obj
    }
}

## DYNAMIC GROUP
foreach($DG in $DynamicDistributionGroups){
    
    $GroupName = $DG.DisplayName
    $GroupEmail = $DG.PrimarySMTPAddress
    $GroupType = "Dynamic Group"

    ## Getting members
    $members = Get-DynamicDistributionGroupMember -Identity $dg.PrimarySMTPAddress

    ## Cycling through each member of current Group
    foreach($member in $members){
      $UserDisplayName = $member.DisplayName
      $UserEmail = $member.PrimarySMTPAddress
      $UserType = $member.RecipientTypeDetails

      Write-Host "$UserDisplayName ($UserEmail) is a member of $GroupName ($GroupEmail)"
      $obj = New-Object -TypeName PSObject
      $obj | Add-Member NoteProperty -Name "DisplayName" -Value $UserDisplayName
      $obj | Add-Member NoteProperty -Name "EmailAddress" -Value $UserEmail
      $obj | Add-Member NoteProperty -Name "UserType" -Value $UserType
      $obj | Add-Member NoteProperty -Name "GroupName" -Value $GroupName
      $obj | Add-Member NoteProperty -Name "GroupEmail" -Value $GroupEmail
      $obj | Add-Member NoteProperty -Name "GroupType" -Value $GroupType

      $GroupDATA += $obj
    }
}
foreach($DG in $UnifiedGroups){
    
    $GroupName = $DG.DisplayName
    $GroupEmail = $DG.PrimarySMTPAddress
    $GroupType = "Unified Group"

    ## Getting members
    $members = Get-UnifiedGroupLinks -Identity $dg.PrimarySMTPAddress -LinkType Members

    ## Cycling through each member of current Group
    foreach($member in $members){
      $UserDisplayName = $member.DisplayName
      $UserEmail = $member.PrimarySMTPAddress
      $UserType = $member.RecipientTypeDetails

      Write-Host "$UserDisplayName ($UserEmail) is a member of $GroupName ($GroupEmail)"
      $obj = New-Object -TypeName PSObject
      $obj | Add-Member NoteProperty -Name "DisplayName" -Value $UserDisplayName
      $obj | Add-Member NoteProperty -Name "EmailAddress" -Value $UserEmail
      $obj | Add-Member NoteProperty -Name "UserType" -Value $UserType
      $obj | Add-Member NoteProperty -Name "GroupName" -Value $GroupName
      $obj | Add-Member NoteProperty -Name "GroupEmail" -Value $GroupEmail
      $obj | Add-Member NoteProperty -Name "GroupType" -Value $GroupType

      $GroupDATA += $obj
    }
}

$csvname = $CompanyName + " Group Members.csv" 
$GroupDATA | Export-Csv $csvname
