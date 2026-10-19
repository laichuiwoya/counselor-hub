$ErrorActionPreference = 'Stop'
$warPath = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../target/counselor.war'))
$pattern = '(?i)-jar\s+"?' + [regex]::Escape($warPath) + '"?(?:\s|$)'
$processes = Get-CimInstance Win32_Process -Filter "Name='java.exe'" | Where-Object { $_.CommandLine -match $pattern }
if (!$processes) { Write-Host 'No running application launched by start.bat was found.'; exit 0 }
foreach ($appProcess in $processes) {
    Stop-Process -Id $appProcess.ProcessId
    Write-Host "Stopped counselor application (PID $($appProcess.ProcessId))."
}
