$clientInstallersFolder = (Get-QualiIntallersPathDetails).KB3033929Client
$serverInstallersFolder = (Get-QualiIntallersPathDetails).KB3033929Server

$msuData = @{
    '6.1-client' = @{
        Url = "$clientInstallersFolder\Windows6.1-KB3033929-x86.msu"
        Checksum = '246C300A6AE6DCA99453F6839745AC0015953528A7065BED1B015F91B80CF64D'
        Url64 = "$clientInstallersFolder\Windows6.1-KB3033929-x64.msu"
        Checksum64 = '5318587007EDB6C8B29310FF18DA479A162B486B9101A7DE735F94A70DBC3B31'
    }
    '6.1-server' = @{
        Url64 = "$serverInstallersFolder\Windows6.1-KB3033929-x64.msu"
        Checksum64 = '5318587007EDB6C8B29310FF18DA479A162B486B9101A7DE735F94A70DBC3B31'
    }
}

$servicePackRequirements = @{
    '6.1' = @{ ServicePackNumber = 1; ChocolateyPackage = 'KB976932' }
}

chocolateyInstaller\Install-WindowsUpdate -Id 'KB3033929' -MsuData $msuData -ChecksumType 'sha256' -ServicePackRequirements $servicePackRequirements
