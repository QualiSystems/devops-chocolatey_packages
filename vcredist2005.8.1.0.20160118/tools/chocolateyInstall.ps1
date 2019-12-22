$installersPath = (Get-QualiIntallersPathDetails).VCredist8
$packageName = 'vcredist2005'
$installerType = 'exe'
$url = "$installersPath\vcredist_x86.EXE"
$checksum = 'b8fab0bb7f62a24ddfe77b19cd9a1451abd7b847'
$checksumType = 'sha1'
$url64 = "$installersPath\vcredist_x64.EXE"
$checksum64 = 'ee916012783024dac67fc606457377932c826f05'
$checksumType64 = 'sha1'
$silentArgs = '/Q'
$validExitCodes = @(0,3010)  # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -Url "$url" `
                          -Url64bit "$url64" `
                          -SilentArgs "$silentArgs" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"

if (Get-ProcessorBits 64) {
  Install-ChocolateyPackage -PackageName "$packageName" `
                            -FileType "$installerType" `
                            -Url "$url" `
                            -SilentArgs "$silentArgs" `
                            -ValidExitCodes $validExitCodes `
                            -Checksum "$checksum" `
                            -ChecksumType "$checksumType"
}