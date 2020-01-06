$ErrorActionPreference = 'Stop';

$softwareName = 'Dotfuscator Professional Edition*'
[array]$key = Get-UninstallRegistryKey -SoftwareName $softwareName

if ($key.Count -eq 1) {
  $packageId = $key[0].PSChildName
  Uninstall-ChocolateyPackage -PackageName $packageName `
                              -SoftwareName $softwareName `
                              -FileType 'MSI' `
                              -SilentArgs "$packageId /quiet /qn /norestart" `
                              -File '' `
                              -ValidExitCodes @(0, 3010) # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx                              
  Uninstall-ChocolateyEnvironmentVariable -VariableName 'DOTFUSCATOR_LICENSE' -VariableType 'Machine'
}
elseif ($key.Count -eq 0) {
  Write-Warning "$($packageArgs['packageName']) has already been uninstalled by other means."
}
elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % { Write-Warning "- $($_.DisplayName)" }
}