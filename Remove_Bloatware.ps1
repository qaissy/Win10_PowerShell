$ErrorActionPreference = "SilentlyContinue"

#region < ========== Starting log file ========== >
# Log generation
$Log = @{
    Path    = "$env:windir\SoftwareDistribution\BloatwareRemoved.log"
    Append  = $true
    Force   = $true
    Confirm = $false
    Verbose = $true
 }
Start-Transcript @Log
#endregion

#region     < ========== Remove Bloatware ========== >
$AppsList = @(
  'Microsoft.BingWeather',
  'Microsoft.GetHelp',
  'Microsoft.Getstarted',
  'Microsoft.Messaging',
  'Microsoft.Microsoft3DViewer',
  'Microsoft.MicrosoftOfficeHub',
  'Microsoft.MicrosoftSolitaireCollection',
  'Microsoft.MixedReality.Portal',
  'Microsoft.OneConnect',
  'Microsoft.People',
  'Microsoft.Print3D',
  'Microsoft.ScreenSketch',
  'Microsoft.SkypeApp',
  'Microsoft.Wallet',
  'Microsoft.Windows.NarratorQuickStart',
  'Microsoft.WindowsAlarms',
  'Microsoft.WindowsFeedbackHub',
  'Microsoft.WindowsMaps',
  'Microsoft.WindowsSoundRecorder',
  'Microsoft.Xbox.TCUI',
  'Microsoft.XboxApp',
  'Microsoft.XboxGameOverlay',
  'Microsoft.XboxGamingOverlay',
  'Microsoft.XboxIdentityProvider',
  'Microsoft.XboxSpeechToTextOverlay',
  'Microsoft.YourPhone',
  'Microsoft.ZuneMusic',
  'Microsoft.ZuneVideo',
  'Microsoft.Todos',
  'Microsoft.BingNews',
  'Microsoft.OfficeLens',
  'Windows.CBSPreview',
  'Microsoft.NetworkSpeedTest'
)
ForEach ($App in $AppsList){
  #region Package
  $PackageFullName    = (Get-AppxPackage $App).PackageFullName
  Write-Output $PackageFullName
  switch ($null -ne $PackageFullName){
    true {
      Write-Output "Removing Package: $App"
      Remove-AppxPackage -package $PackageFullName
      Write-Output ''
    }
    false {
      Write-Output "Unable to find package: $App"
      Write-Output ''
    }
  }
  #endregion
  #region Provisioned Package
  $ProPackageFullName = (Get-AppxProvisionedPackage -online | Where-Object {$_.Displayname -eq $App}).PackageName
  Write-Output $ProPackageFullName
  switch ($null -ne $ProPackageFullName){
    true {
      Write-Output "Removing Package: $App"
      Remove-AppxPackage -package $ProPackageFullName
      Write-Output ''
    }
    false {
      Write-Output "Unable to find package: $App"
      Write-Output ''
    }
  }
  #endregion
}

#endregion

Stop-Transcript