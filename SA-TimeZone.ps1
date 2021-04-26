$ErrorActionPreference = "SilentlyContinue"


#region < ========== Starting log file ========== >
# Log generation
$Log = @{
    Path    = "$env:windir\SoftwareDistribution\SouthAfricaTimeZone.log"
    Append  = $true
    Force   = $true
    Confirm = $false
    Verbose = $true
 }
Start-Transcript @Log
#endregion

# Set timezone
Set-TimeZone "South Africa Standard Time" -Confirm:$false -Verbose

Stop-Transcript