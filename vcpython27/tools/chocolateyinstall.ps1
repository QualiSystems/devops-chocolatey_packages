
$ErrorActionPreference = 'Stop';


$installersPath = (Get-QualiIntallersPathDetails).Path
$packageName= 'vcpython27'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "$installersPath/VCForPython27.msi"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  url           = $url

  silentArgs    = "ALLUSERS=1 /qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'Microsoft Visual C++ Compiler Package for Python 2.7'
  checksum      = '4e6342923a8153a94d44ff7307fcdd1f'
  checksumType  = 'md5'
}



Install-ChocolateyPackage @packageArgs
