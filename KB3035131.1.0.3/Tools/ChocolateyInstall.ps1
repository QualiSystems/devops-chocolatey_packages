$clientInstallersFolder = (Get-QualiIntallersPathDetails).KB3035131Client
$serverInstallersFolder = (Get-QualiIntallersPathDetails).KB3035131Server

$msuData = @{
    '6.3-client' = @{
        Url = "$clientInstallersFolder\Windows8.1-KB3035131-x86.msu"
        Checksum = '61C80C09EBE58558A7CF15F6892B392BC73A2EF669255A236562B6196FFE47C0'
        Url64 = "$clientInstallersFolder\Windows8.1-KB3035131-x64.msu"
        Checksum64 = 'A9D6F7B519AD3A22ABDE3AF7CE3EBB90FF84A028EDE2154AC5D0548C88CCFEDD'
    }
    '6.3-server' = @{
        Url64 = "$serverInstallersFolder\Windows8.1-KB3035131-x64.msu"
        Checksum64 = 'A9D6F7B519AD3A22ABDE3AF7CE3EBB90FF84A028EDE2154AC5D0548C88CCFEDD'
    }
    '6.2-client' = @{
        Url = "$clientInstallersFolder\Windows8-RT-KB3035131-x86.msu"
        Checksum = '3CBA7162DE2ECFD14E2C5B8805C15C74E15898E1D1DEAAAEDCC18BB50ACB5BC3'
        Url64 = "$clientInstallersFolder\Windows8-RT-KB3035131-x64.msu"
        Checksum64 = '22CBF7E733C55C4F90DFA0864AE8B61F07E522825DE7DDD94439FF4D1F4D2766'
    }
    '6.2-server' = @{
        Url64 = "$serverInstallersFolder\Windows8-RT-KB3035131-x64.msu"
        Checksum64 = '22CBF7E733C55C4F90DFA0864AE8B61F07E522825DE7DDD94439FF4D1F4D2766'
    }
    '6.1-client' = @{
        Url = "$clientInstallersFolder\Windows6.1-KB3035131-x86.msu"
        Checksum = '65608782ED5A77293436ADE0B1CDA37668A30D8E27198A6CD331704ADDC3D782'
        Url64 = "$clientInstallersFolder\Windows6.1-KB3035131-x64.msu"
        Checksum64 = '589F6BA1097937E99B3CECC113D3535FBF7DE4E40623D3145E89E4EBCBE028AC'
    }
    '6.1-server' = @{
        Url64 = "$serverInstallersFolder\Windows6.1-KB3035131-x64.msu"
        Checksum64 = '589F6BA1097937E99B3CECC113D3535FBF7DE4E40623D3145E89E4EBCBE028AC'
    }
    '6.0-client' = @{
        Url = "$clientInstallersFolder\Windows6.0-KB3035131-x86.msu"
        Checksum = 'E883D65A9DB0669DA158DC27C8FD63C4C91D1EEA46C3B415391030EA6B3C1083'
        Url64 = "$clientInstallersFolder\Windows6.0-KB3035131-x64.msu"
        Checksum64 = '391D27E4A62C52F2DD83DEC869728EC67A76694C6181E4E0287B565B86E8FE0E'
    }
    '6.0-server' = @{
        Url = "$serverInstallersFolder\Windows6.0-KB3035131-x86.msu"
        Checksum = 'E883D65A9DB0669DA158DC27C8FD63C4C91D1EEA46C3B415391030EA6B3C1083'
        Url64 = "$serverInstallersFolder\Windows6.0-KB3035131-x64.msu"
        Checksum64 = '391D27E4A62C52F2DD83DEC869728EC67A76694C6181E4E0287B565B86E8FE0E'
    }
}

$servicePackRequirements = @{
    '6.1' = @{ ServicePackNumber = 1; ChocolateyPackage = 'KB976932' }
    '6.0' = @{ ServicePackNumber = 2; ChocolateyPackage = $null }
}

chocolateyInstaller\Install-WindowsUpdate -Id 'KB3035131' -MsuData $msuData -ChecksumType 'sha256' -ServicePackRequirements $servicePackRequirements
