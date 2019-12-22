$path = (Get-QualiIntallersPathDetails).VCredist14

$installData32 = @{
  Url = "$path\VC_redist.x86.exe"
  Checksum = 'e59ae3e886bd4571a811fe31a47959ae5c40d87c583f786816c60440252cd7ec'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = "$path\VC_redist.x64.exe"
  Checksum64 = '40ea2955391c9eae3e35619c4c24b5aaf3d17aeaa6d09424ee9672aa9372aeed'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.24.28127'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
