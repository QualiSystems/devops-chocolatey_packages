$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageName = 'pyenv-win'
Uninstall-ChocolateyZipPackage $packageName

UnInstall-ChocolateyPath "$toolsDir\pyenv-win-1.2.4\pyenv-win\shims" 'Machine'
UnInstall-ChocolateyPath "$toolsDir\pyenv-win-1.2.4\pyenv-win\shims" 'User'

UnInstall-BinFile -Name "pyenv" -Path "$toolsDir\pyenv-win-1.2.4\pyenv-win\bin\pyenv.bat"