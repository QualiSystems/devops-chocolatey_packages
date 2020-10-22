$ErrorActionPreference = 'Stop'; # stop on all errors


$packageName = 'azurestorageemulator' # arbitrary name for the package, used in messages
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installersFolder = (Get-QualiIntallersPathDetails).Path
$url = "$installersFolder\microsoftazurestorageemulator.msi"
$url64 = '' # 64bit URL here or remove - if installer is both, use $url
#$fileLocation = Join-Path $toolsDir 'NAME_OF_EMBEDDED_INSTALLER_FILE'
#$fileLocation = Join-Path $toolsDir 'SHARE_LOCATION_OF_INSTALLER_FILE'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'msi' #only one of these: exe, msi, msu
  url            = $url
  url64bit       = $url64
  #file         = $fileLocation

  #MSI
  silentArgs     = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes = @(0, 3010, 1641)
  # optional, highly recommended
  softwareName   = 'microsoft azure storage emulator*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum       = '4ab98e9a50e9984fef497114fc5d9340aa2cef46f86ffa85fc0b5b4c4365cf53'
  checksumType   = 'sha256' #default is md5, can also be sha1
  checksum64     = '4ab98e9a50e9984fef497114fc5d9340aa2cef46f86ffa85fc0b5b4c4365cf53'
  checksumType64 = 'sha256' #default is checksumType
}

Install-ChocolateyPackage @packageArgs