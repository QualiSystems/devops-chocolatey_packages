$kb = "KB2919442"
$packageName = "KB2919442"
$silentArgs = "/quiet /norestart /log:`"$env:TEMP\$kb.Install.evt`""
$installersFolder = (Get-QualiIntallersPathDetails).KB2919442

$os = Get-WmiObject -Class Win32_OperatingSystem
$version = [Version]$os.Version

if ($version -eq $null -or $version -lt [Version]'6.3' -or $version -ge [Version]'6.4') {
	Write-Host "Skipping installation because this hotfix only applies to Windows 8.1 and Windows Server 2012 R2."
	return
}

if (Get-HotFix -id $kb -ea SilentlyContinue)
{
	Write-Host "Skipping installation because hotfix $kb is already installed."
	return
}

if ($os.ProductType -eq '1') {
	# Windows 8.1
	$url = "$installersFolder/Windows8.1-KB2919442-x86.msu"
	$url64 = "$installersFolder/Windows8.1-KB2919442-x64.msu"
	$checksum = '3368C3A329F402FD982B15B399368627B96973F008A5456B5286BDFC10C1169B'
	$checksum64 = 'C10787E669B484674584A990E069295E8B81B5366F98508010A3AE181B729482'
} else {
	# Windows Server 2012 R2
	$url64 = "$installersFolder/WindowsServer2012R2-KB2919442-x64.msu"
	$checksum64 = 'C10787E669B484674584A990E069295E8B81B5366F98508010A3AE181B729482'
}

Install-ChocolateyPackage $packageName 'msu' $silentArgs $url $url64 -checksum $checksum -checksum64 $checksum64 -checksumType 'sha256' -validExitCodes @(0, 3010, 0x80240017)
