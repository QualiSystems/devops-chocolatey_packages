$installersPath = (Get-QualiIntallersPathDetails).Path

$package = 'erlang'
$version = '21.3'

$params = @{
  PackageName    = $package
  FileType       = 'exe'
  SilentArgs     = '/S'
  Url            = "$installersPath\otp_win32_$version.exe"
  CheckSum       = 'f1e8153530ef91c9cdc4a73593fe0fe41755412244370060bd8e4b80572ba242'
  CheckSumType   = 'sha256'
  Url64          = "$installersPath\otp_win64_$version.exe"
  CheckSum64     = '4BFF2C3A537351852A914F1C1FE0DE2C2DF87AF6C501C552F323ABED08123D69'
  CheckSumType64 = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @params