


function authMe {
    [hashtable]$return = @{}
    try {
        $credentials = Get-StoredCredential -Target $credentialsTarget
        Import-Module AzureAD
        Connect-AzureAD -Credential $credentials

        $return.UserName = $credentials.UserName
        
        #Prepare Microsoft Graph API Calls
        $ReqTokenBody = @{
            Grant_Type    = "client_credentials"
            Scope         = "https://graph.microsoft.com/.default"
            client_Id     = $clientID
            Client_Secret = $clientSecret
        } 
        $return.AppToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantName/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody
        $ReqTokenBody = @{
            Grant_Type    = "Password"
            client_Id     = $clientId
            Client_Secret = $clientSecret
            Username      = $credentials.UserName
            Password      = $credentials.GetNetworkCredential().Password
            Scope         = $scope
        } 

        $return.UserToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantName/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody
    } catch {
        Write-Error -Message "authentication error! $PSItem"
        exit
    }
    return $return
}

