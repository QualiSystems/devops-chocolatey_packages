try { 
    $installersPath = (Get-QualiIntallersPathDetails).VCredist10
    $64BitInstallerPath = "$installersPath\vcredist_x64.exe"
    $32BitInstallerPath = "$installersPath\vcredist_x86.exe"
    
    $processor = Get-WmiObject Win32_Processor
    $is64bit = $processor.AddressWidth -eq 64
    Install-ChocolateyPackage 'vcredist2010' 'exe' '/Q' $32BitInstallerPath `
                -checksum 66B797B3B4F99488F53C2B676610DFE9868984C779536891A8D8F73EE214BC4B `
                -checksumType sha256

                
    if($is64bit) {
        Install-ChocolateyPackage 'vcredist2010_x64' 'exe' '/Q' $64BitInstallerPath `
                -checksum64 C6CD2D3F0B11DC2A604FFDC4DD97861A83B77E21709BA71B962A47759C93F4C8 `
                -checksumType64 sha256
    }

    # the following is all part of error handling
    Write-ChocolateySuccess 'vcredist2010'
} catch {
    Write-ChocolateyFailure 'vcredist2010' "$($_.Exception.Message)"
    throw 
}
