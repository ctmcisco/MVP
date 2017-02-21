﻿function Get-MVPContributionType
{
    [CmdletBinding(DefaultParameterSetName='All')]
    PARAM(
        [parameter(ParameterSetName='All')]
        [int]$Offset=1,

        [parameter(ParameterSetName='All')]
        [int]$Limit=5,

        [parameter(ParameterSetName='ID')]
        [System.String]$ID
    )


    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode))
    {
	    Write-Warning -Message "You need to use Set-MVPConfiguration first to set the Primary Key"
	    break
    }


    #Splat
    $Splat = @{
        Uri = "https://mvpapi.azure-api.net/mvp/api/contributions/contributiontypes"
        Headers = @{
            "Ocp-Apim-Subscription-Key" = $global:MVPPrimaryKey
            Authorization = $Global:MVPAuthorizationCode}
    }

    
    if ($ID)
    {
        $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/contributions/$ID"
    }


   $out =invoke-RestMethod @Splat
   [pscustomobject]$out
    
}