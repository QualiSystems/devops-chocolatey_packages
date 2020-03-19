$ErrorActionPreference = 'Stop';
$installersFolder = (Get-QualiIntallersPathDetails).Path

$packageName = 'pyenv-win'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = "$installersFolder\pyenv-win-1.2.4.zip"

$packageArgs = @{
    packageName   = $packageName
    unzipLocation = $toolsDir
    url           = $url
    checksum      = '218C5046F2D4D8682CDDE915F58698E3B215EB84AA325AB0A0EE0201C82CF387'
    checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyPath "$toolsDir\pyenv-win-1.2.4\pyenv-win\shims" 'Machine'
Install-ChocolateyPath "$toolsDir\pyenv-win-1.2.4\pyenv-win\shims" 'User'

Install-BinFile -Name "pyenv" -Path "$toolsDir\pyenv-win-1.2.4\pyenv-win\bin\pyenv.bat"