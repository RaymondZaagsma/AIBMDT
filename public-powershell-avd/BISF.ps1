Write-Output 'BISF Start'

$bisfPath = 'C:\Program Files (x86)\Base Image Script Framework (BIS-F)'
$jsonPath = "https://raw.githubusercontent.com/RaymondZaagsma/AIBMDT/main/public-json-avd/BISFconfig_MicrosoftWindows10EnterpriseforVirtualDesktops_64-bit.json", "https://raw.githubusercontent.com/RaymondZaagsma/AIBMDT/main/public-json-avd/BISFSharedConfig.json"
foreach ($file in $jsonPath) {
    $fileName = Split-Path $file -Leaf
    $outFile = Join-Path $bisfPath $fileName
    if (-not(Test-Path $outFile)) {
        Invoke-WebRequest $file -OutFile $outFile
    }
}
$startBISF = Join-Path $bisfPath "\Framework\PrepBISF_Start.ps1"
& $startBISF
Write-Output 'BISF Run Finished'