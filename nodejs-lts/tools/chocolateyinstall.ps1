$ErrorActionPreference = 'Stop';
$installersFolder = (Get-QualiIntallersPathDetails).NodeJsLts

$packageName= 'nodejs-lts'

$installerFile = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; Get-Item "$installersFolder\node-v12.14.0-x64.msi"
} else { Write-Host "Installing 32 bit version"; Get-Item "$installersFolder\node-v12.14.0-x86.msi" }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $installerFile
  softwareName  = 'Node.js'
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs