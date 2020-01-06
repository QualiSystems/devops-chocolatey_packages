﻿$installersPath = (Get-QualiIntallersPathDetails).Path
$packageParameters = Get-PackageParameters

$packageArgs = @{
  packageName    = 'DotfuscatorPro'
  fileType       = 'MSI'
  url            = "$installersPath\DotfuscatorPro_4.8.1000_2.0.msi"
  checksum       = '2A7C5205FBCDD31961C114ABB3C950D12E0FFE07DA1F9B8F8042EAF8549BBB92'
  checksumType   = 'sha256'
  silentArgs     = "ALLUSERS=1 /qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes = @(0)
}

$licenseKey = $packageParameters['LICENSEKEY']
if (-not [string]::IsNullOrEmpty($licenseKey)) {
  Write-Host 'Setting Dotfuscator license environment variable'
  Install-ChocolateyEnvironmentVariable 'DOTFUSCATOR_LICENSE' $licenseKey 'Machine'
}

Install-ChocolateyPackage @packageArgs