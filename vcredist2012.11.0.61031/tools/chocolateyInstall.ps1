$installersPath = (Get-QualiIntallersPathDetails).VCredist11
$packageName = 'vcredist2012'
$installerType = 'EXE'
$32BitUrl = "$installersPath\vcredist_x86.exe"
$64BitUrl = "$installersPath\vcredist_x64.exe"
$silentArgs = '/Q'
$validExitCodes = @(0,3010)


#first install vcredist targetting actual CPU architecture
Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl $64BitUrl -validExitCodes $validExitCodes `
            -checksum B924AD8062EAF4E70437C8BE50FA612162795FF0839479546CE907FFA8D6E386 `
            -checksumType sha256 `
            -checksum64 681BE3E5BA9FD3DA02C09D7E565ADFA078640ED66A0D58583EFAD2C1E3CC4064 `
            -checksumType64 sha256            

$is64bit = Get-ProcessorBits 64;
if($is64bit) {
    #in case of x64 also install x86 vcredist
    Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl -validExitCodes $validExitCodes `
                -checksum B924AD8062EAF4E70437C8BE50FA612162795FF0839479546CE907FFA8D6E386 `
                -checksumType sha256
}


