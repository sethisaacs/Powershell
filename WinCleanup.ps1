# --- Clear Windows Update Cache ---
Write-Host "Stopping Windows Update services..." -ForegroundColor Yellow
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
Stop-Service -Name bits -Force -ErrorAction SilentlyContinue
$UpdateCache = "C:\Windows\SoftwareDistribution\Download"
if (Test-Path $UpdateCache) {
    Write-Host "Deleting files in $UpdateCache..." -ForegroundColor Yellow
    try {
        Remove-Item "$UpdateCache\*" -Recurse -Force -ErrorAction Stop
        Write-Host "Windows Update cache cleared." -ForegroundColor Green
    } catch {
        Write-Host "Failed to clear Windows Update cache: $_" -ForegroundColor Red
    }
} else {
    Write-Host "$UpdateCache not found!" -ForegroundColor DarkGray
}
Write-Host "Starting Windows Update services..." -ForegroundColor Yellow
Start-Service -Name wuauserv -ErrorAction SilentlyContinue
Start-Service -Name bits -ErrorAction SilentlyContinue
# --- Clear All Users' TEMP Folders ---
Write-Host "`nClearing TEMP folders for all users..." -ForegroundColor Cyan
$UserProfiles = Get-ChildItem 'C:\Users' -Directory | Where-Object {
    $_.Name -notin @('Public', 'Default', 'Default User', 'All Users', 'Administrator')
}
foreach ($Profile in $UserProfiles) {
    $TempPath = Join-Path -Path $Profile.FullName -ChildPath 'AppData\Local\Temp'
    if (Test-Path $TempPath) {
        Write-Host "Clearing TEMP folder for user: $($Profile.Name) at $TempPath" -ForegroundColor Yellow
        try {
            Remove-Item "$TempPath\*" -Recurse -Force -ErrorAction Stop
            Write-Host "Cleared TEMP folder for $($Profile.Name)." -ForegroundColor Green
        } catch {
            Write-Host "Failed to clear TEMP for $($Profile.Name): $_" -ForegroundColor Red
        }
    } else {
        Write-Host "No TEMP folder found for $($Profile.Name) at expected path." -ForegroundColor DarkGray
    }
}
Write-Host "All done!" -ForegroundColor Cyan
