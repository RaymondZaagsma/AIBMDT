# Software install Script
#
# Applications to install:
#



#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion

#region MDT Task Sequence
try {
    $installargs = "C:\DeploymentShare\Scripts\LiteTouch.vbs"
    Write-Host 'Running MDT LiteTouch Task Sequence'
    Start-Process -FilePath cscript -Wait -ArgumentList $installargs
    if (Test-Path "C:\DeploymentShare\Scripts\LiteTouch.vbs") {
        Write-Log "MDT has been installed"
    }
    else {
        write-log "Error locating MDT Deployment Share"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing MDT Task Sequence: $ErrorMessage"
}
#endregion

#region Time Zone Redirection
$Name = "fEnableTimeZoneRedirection"
$value = "1"
# Add Registry value
try {
    New-ItemProperty -ErrorAction Stop -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name $name -Value $value -PropertyType DWORD -Force
    if ((Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services").PSObject.Properties.Name -contains $name) {
        Write-log "Added time zone redirection registry key"
    }
    else {
        write-log "Error locating the Teams registry key"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error adding teams registry KEY: $ErrorMessage"
}
#endregion