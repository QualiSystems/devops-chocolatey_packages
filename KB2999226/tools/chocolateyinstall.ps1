$clientInstallersFolder = (Get-QualiIntallersPathDetails).KB2999226Client
$serverInstallersFolder = (Get-QualiIntallersPathDetails).KB2999226Server

$msuData = @{
  '6.0-client' = @{
    Url = "$clientInstallersFolder\Windows6.0-KB2999226-x86.msu"
    Url64 = "$clientInstallersFolder\Windows6.0-KB2999226-x64.msu"
    Checksum = 'AE380F63BF4E8700ADA686406B04B01230A339B09EDF7819814A4C0BF4AB72E1'
    Checksum64 = '10069DE7315CA3F405E2579846AF5DAB3089A8496AE4C1AB61763480F43A05A8'
  }
  '6.0-server' = @{
    Url = "$serverInstallersFolder\Windows6.0-KB2999226-x86.msu"
    Url64 = "$serverInstallersFolder\Windows6.0-KB2999226-x64.msu"
    Checksum = 'AE380F63BF4E8700ADA686406B04B01230A339B09EDF7819814A4C0BF4AB72E1'
    Checksum64 = '10069DE7315CA3F405E2579846AF5DAB3089A8496AE4C1AB61763480F43A05A8'
  }
  '6.1-client' = @{
    Url = "$clientInstallersFolder\Windows6.1-KB2999226-x86.msu"
    Url64 = "$clientInstallersFolder\Windows6.1-KB2999226-x64.msu"
    Checksum = '909E76C81EF0EB176144B253DDFFE7A8FDFACEBFAA15E97DEF003D2262FBF084'
    Checksum64 = '43234D2986CA9B0DE75D5183977964D161A8395C3396279DDFC9B20698E5BC34'
  }
  '6.1-server' = @{
    Url64 = "$serverInstallersFolder\Windows6.1-KB2999226-x64.msu"
    Checksum64 = '43234D2986CA9B0DE75D5183977964D161A8395C3396279DDFC9B20698E5BC34'
  }
  '6.2-client' = @{
    Url = "$clientInstallersFolder\Windows8-RT-KB2999226-x86.msu"
    Url64 = "$clientInstallersFolder\Windows8-RT-KB2999226-x64.msu"
    Checksum = '0F36750FBB06FEE23131F68B4D0943841EED24730EC1D5D77DEDC41D359BE88D'
    Checksum64 = '50CAE25DA33FA950222D1A803E42567291EB7FEB087FA119B1C97FE9D41CD9F8'
  }
  '6.2-server' = @{
    Url64 = "$serverInstallersFolder\Windows8-RT-KB2999226-x64.msu"
    Checksum64 = '50CAE25DA33FA950222D1A803E42567291EB7FEB087FA119B1C97FE9D41CD9F8'
  }
  '6.3-client' = @{
    Url = "$clientInstallersFolder\Windows8.1-KB2999226-x86.msu"
    Url64 = "$clientInstallersFolder\Windows8.1-KB2999226-x64.msu"
    Checksum = 'B83251219C5390536B02BEBAF5E43A6F13381CE1DB43E76483BCE07C4BCF877B'
    Checksum64 = '9F707096C7D279ED4BC2A40BA695EFAC69C20406E0CA97E2B3E08443C6381D15'
  }
  '6.3-server' = @{
    Url64 = "$serverInstallersFolder\Windows8.1-KB2999226-x64.msu"
    Checksum64 = '9F707096C7D279ED4BC2A40BA695EFAC69C20406E0CA97E2B3E08443C6381D15'
  }
}

$servicePackRequirements = @{
  '6.0' = @{ ServicePackNumber = 1; ChocolateyPackage = $null }
  '6.1' = @{ ServicePackNumber = 1; ChocolateyPackage = 'KB976932' }
}

chocolateyInstaller\Install-WindowsUpdate -Id 'KB2999226' -MsuData $msuData -ChecksumType 'sha256' -ServicePackRequirements $servicePackRequirements
