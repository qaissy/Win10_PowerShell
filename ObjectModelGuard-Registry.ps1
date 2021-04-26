$ErrorActionPreference = "SilentlyContinue"

#region " Adding registry values
# Log generation
$Log = @{
    Path    = "$env:windir\SoftwareDistribution\ObjectModelGuard.log"
    Append  = $true
    Force   = $true
    Confirm = $false
    Verbose = $true
 }
Start-Transcript @Log

# Registry setup
$RegPath = "HKLM:\SOFTWARE\Microsoft\Office\16.0\Outlook"
$RegPathValue = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Office\16.0\Outlook\Security" -Name 'ObjectModelGuard'

if ($RegPathValue -eq '2'){
    Write-Output "$RegPath\Security with value of $RegPathValue already exists"
    exit 0
    }else{
    New-Item -Path $RegPath -Name 'Security' -Confirm:$false -Force

$ObjectModelGuard = @{
    Path         = "$RegPath\Security"
    Name         = 'ObjectModelGuard'
    Value        = '2'
    PropertyType = 'Dword'
    Confirm      = $false
    Force        = $true
    }
    New-ItemProperty @ObjectModelGuard
}

Stop-Transcript
#endregion