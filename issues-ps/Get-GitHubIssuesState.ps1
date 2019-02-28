#Get-GitHubIssuesState.ps1
#Todo: 
#Author: Andres Gorzelany
#GitHub Handle: get-itips

param(
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [string]$Owner="",

    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [string]$Repo="",

    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [string[]]$Issues,

    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [string]$OAuthToken

)
#sample uri: "https://api.github.com/repos/MicrosoftDocs/office-docs-powershell/issues/1300"

$uri1stPart="https://api.github.com/repos/"

$uri2ndPart = $uri1stPart + $Owner + "/" + $Repo + "/issues/" 

$headers = @{
    'token' = $OAuthToken
}


Write-Host "Starting report on requested issues"
Write-Host "##################################"
foreach($issue in $issues){

    $uri = $uri2ndPart + $issue
    $result=Invoke-RestMethod -uri $uri -Headers $headers
    
    Write-Host $result.number -NoNewline
    Write-host " "-NoNewline
    Write-host $result.title -NoNewline
    Write-host " > "-NoNewline
    if($result.state.Equals("closed"))
    {
        write-host -ForegroundColor Red $result.state
    }
    else
    {
        write-host -ForegroundColor Green $result.state
    }
}

