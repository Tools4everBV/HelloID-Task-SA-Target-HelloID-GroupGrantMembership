# HelloID-Task-SA-Target-HelloID-GroupGrantMembership
###########################################################
# Form mapping
$formObject = @{
    groupToAddGUID = $form.groupToAddGUID
    groupToAddName = $form.groupToAddName
    groupGUID      = $form.groupGUID
    groupName      = $form.groupName
}

try {
    Write-Information "Executing HelloID action: [GrantMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToAddName)]"
    Write-Verbose "Creating authorization headers"
    # Create authorization headers with HelloID API key
    $pair = "${portalApiKey}:${portalApiSecret}"
    $bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
    $base64 = [System.Convert]::ToBase64String($bytes)
    $key = "Basic $base64"
    $headers = @{"authorization" = $Key }

    Write-Verbose "Granting Membership to HelloIDGroup: [$($formObject.groupName)] for HelloIDGroup: [$($formObject.groupToAddName)]"
    $splatAddGroupParams = @{
        Uri         = "$($portalBaseUrl)/api/v1/groups/$($formObject.groupGUID)/membergroups"
        Method      = "POST"
        Body        = ([System.Text.Encoding]::UTF8.GetBytes((@{ "groupGuid" = $formObject.groupToAddGUID } | ConvertTo-Json -Depth 10)))
        Verbose     = $false
        Headers     = $headers
        ContentType = "application/json"
    }
    $response = Invoke-RestMethod @splatAddGroupParams

    $auditLog = @{
        Action            = "GrantMembership"
        System            = "HelloID"
        TargetIdentifier  = [String]$formObject.groupToAddGUID
        TargetDisplayName = [String]$formObject.groupToAddName
        Message           = "HelloID action: [GrantMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToAddName)] executed successfully"
        IsError           = $false
    }
    Write-Information -Tags "Audit" -MessageData $auditLog

    Write-Information "HelloID action: [GrantMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToAddName)] executed successfully"
}
catch {
    $ex = $_
    $auditLog = @{
        Action            = "GrantMembership"
        System            = "HelloID"
        TargetIdentifier  = [String]$formObject.groupToAddGUID
        TargetDisplayName = [String]$formObject.groupToAddName
        Message           = "Could not execute HelloID action: [GrantMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToAddName)], error: $($ex.Exception.Message)"
        IsError           = $true
    }
    if ($($ex.Exception.GetType().FullName -eq "Microsoft.PowerShell.Commands.HttpResponseException")) {
        $auditLog.Message = "Could not execute HelloID action: [GrantMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToAddName)]"
        Write-Error "Could not execute HelloID action: [GrantMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToAddName)], error: $($ex.ErrorDetails)"
    }
    Write-Information -Tags "Audit" -MessageData $auditLog
    Write-Error "Could not execute HelloID action: [GrantMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToAddName)], error: $($ex.Exception.Message)"
}
###########################################################