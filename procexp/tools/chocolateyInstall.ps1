﻿$ErrorActionPreference = 'Stop'
$installersFolder = (Get-QualiIntallersPathDetails).Path

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# *** Automatically filled ***
$packageArgs = @{
    packageName    = 'procexp'
    url            = "$installersFolder\ProcessExplorer.zip"
    unzipLocation  = $toolsDir
    checksum       = '5818f8df2afdde87163f26900dc4086998bd37792c040654bc61c44ebac38626'
    checksumType   = 'sha256'
    validExitCodes = @(0)
}
# *** Automatically filled ***

Install-ChocolateyZipPackage @packageArgs

@('procexp', 'procexp64') | % {
    New-Item "$toolsDir\$_.exe.gui" -Type File -Force | Out-Null
}

$registryPath = 'HKCU:\SOFTWARE\Sysinternals\Process Explorer'
if (!(Test-Path $registryPath)) {
    New-Item $registryPath -Force | Out-Null
}
New-ItemProperty -Path $registryPath -Name 'EulaAccepted' -Value 1 -Force | Out-Null

$shortcutPath = Join-Path $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms)) 'Process Explorer.lnk'
if (-not (Test-Path $shortcutPath)) {
    $targetPath = if ([Environment]::Is64BitOperatingSystem) { 'procexp64.exe' } else { 'procexp.exe' }
    Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath "$toolsDir\$targetPath"
}
