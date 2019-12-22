[CmdletBinding(DefaultParameterSetName = "build")]
param
(
    [parameter(Position = 0, ParameterSetName = "clean", Mandatory = $true, HelpMessage = "Clean all build outputs")]
    [Switch]$Clean,
	
    [parameter(Position = 0, ParameterSetName = "build", Mandatory = $true, HelpMessage = "build all packages or a specific set of packages")]
    [Switch]$Build,
    
    [parameter(Position = 0, ParameterSetName = "publish", Mandatory = $true, HelpMessage = "publish all packages or a specific set of packages")]
    [Switch]$Publish,
    
    [parameter(Position = 0, ParameterSetName = "buildAndPublish", Mandatory = $true, HelpMessage = "clean, build and publish all packages or a specific set of packages")]	
    [Switch]$BuildAndPublish,
    
    [parameter(Position = 1, ParameterSetName = "build", Mandatory = $false, HelpMessage = "if specified only these packages will be build")]
    [parameter(Position = 1, ParameterSetName = "buildAndPublish", Mandatory = $false, HelpMessage = "if specified only these packages will be build and published")]
    [string[]]$PackageNames = $null
)

$ErrorActionPreference = 'Stop'

$chocolateyPacakgesNetworkFolder = '\\qsnas1\Storage\devops\chocolatey'
$rootPath = Split-Path $MyInvocation.MyCommand.Definition
$outputPath = Join-Path -Path $rootPath -ChildPath '.output'

function Test-ContainPackage([string]$longPackageName) {
    foreach ($packagesName in $PackageNames) {
        if ($longPackageName -match  $packagesName) { return $true }
    }
    return $false;
}

function Get-FilteredPackages($packagesItems) {
    if ($null -eq $PackageNames) { return $packagesItems }
    return $packagesItems | ? { Test-ContainPackage $_.BaseName }
}

function Get-PackagesDisplayName($packages) {
    if ($null -eq $PackageNames) {
        return 'all packages'
    }
    else { 
        return $packages | foreach { $_.BaseName }
    }
}

function Clean {
    Write-host 'Deleting output folder'
    Remove-Item -Path $outputPath -Recurse -Force -Confirm:$false
}

function Build {    
    New-Item -ItemType Directory $outputPath -Force -Confirm:$false -ErrorAction SilentlyContinue | Out-Null
    $allPackages = Get-ChildItem -Recurse -Path $rootPath -Filter "*.nuspec"
    $packages = Get-FilteredPackages $allPackages
    
    Write-host "Building $(Get-PackagesDisplayName $packages)"
    $packages | foreach { choco pack --outputdirectory '.output' $_.FullName }
}

function Publish {
    $allPackages = Get-ChildItem -Recurse -Path $outputPath -Filter "*.nupkg"
    $packages = Get-FilteredPackages $allPackages

    Write-host "Copying $(Get-PackagesDisplayName $packages) to $chocolateyPacakgesNetworkFolder"
    $packages | foreach { Copy-Item $_.FullName -Destination $chocolateyPacakgesNetworkFolder -Force -Confirm:$false }
}

if ($Clean) { Clean }
if ($Build) { Build }

if ($Publish -or $BuildAndPublish) {
    Clean
    Build
    Publish
}