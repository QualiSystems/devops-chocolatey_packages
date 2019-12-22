[CmdletBinding(DefaultParameterSetName = "build")]
param
(
    [parameter(Position = 0, ParameterSetName = "clean", Mandatory = $true, HelpMessage = "Clean all build output, boxes, logs and chef dependencied and kitchen folders")]
    [Switch]$Clean,
	
    [parameter(Position = 0, ParameterSetName = "build", Mandatory = $true, HelpMessage = "compile all packages")]	
    [Switch]$Build,
    
    [parameter(Position = 0, ParameterSetName = "publish", Mandatory = $true, HelpMessage = "publish all packages")]	
    [Switch]$Publish,
    
    [parameter(Position = 0, ParameterSetName = "buildAndPublish", Mandatory = $true, HelpMessage = "clean, build and publish all packages")]	
    [Switch]$BuildAndPublish
)

$chocolateyPacakgesNetworkFolder = '\\qsnas1\Storage\devops\chocolatey'
$rootPath = Split-Path $MyInvocation.MyCommand.Definition
$outputPath = Join-Path -Path $rootPath -ChildPath '.output'

function Clean {
    Write-host 'Deleting output folder'
    Remove-Item -Path $outputPath -Recurse -Force -Confirm:$false
}

function Build {
    Write-host 'Packing all packages'
    New-Item -ItemType Directory $outputPath -Force -Confirm:$false -ErrorAction SilentlyContinue | Out-Null
    Get-ChildItem -Recurse -Path $rootPath -Filter "*.nuspec" | foreach { choco pack --outputdirectory '.output' $_.FullName }
}

function Publish {
    Write-host "Copying all packages to $chocolateyPacakgesNetworkFolder"
    Get-ChildItem -Recurse -Path $outputPath -Filter "*.nupkg" | foreach { Copy-Item $_.FullName -Destination $chocolateyPacakgesNetworkFolder -Force -Confirm:$false }
}

if ($Clean -or $BuildAndPublish) { Clean }
if ($Build -or $BuildAndPublish) { Build }

if ($Publish -or $BuildAndPublish) {
    Clean
    Build
    Publish
}