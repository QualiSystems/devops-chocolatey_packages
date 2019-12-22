[CmdletBinding(DefaultParameterSetName = "build")]
param
(
    [parameter(Position = 0, ParameterSetName = "clean", Mandatory = $true, HelpMessage = "Clean all build output, boxes, logs and chef dependencied and kitchen folders")]
    [Switch]$Clean,
	
    [parameter(Position = 0, ParameterSetName = "build", Mandatory = $true, HelpMessage = "compile all packages")]	
    [Switch]$Build,
    
    [parameter(Position = 0, ParameterSetName = "publish", Mandatory = $true, HelpMessage = "publish all packages")]	
    [Switch]$Publish,
    
    [parameter(Position = 0, ParameterSetName = "publish", Mandatory = $true, HelpMessage = "clean, build and publish all packages")]	
    [Switch]$BuildAndPublish
)

$rootPath = Split-Path $MyInvocation.MyCommand.Definition
$outputPath = Join-Path -Path $rootPath -ChildPath '.output'

if ($Clean -or $BuildAndPublish) {
    Remove-Item -Path $outputPath -Recurse -Force -Confirm:$false
}


if ($Build -or $BuildAndPublish) {
    New-Item -ItemType Directory $outputPath -Force -Confirm:$false -ErrorAction SilentlyContinue | Out-Null
    Get-ChildItem -Recurse -Path $rootPath -Filter "*.nuspec" | foreach { choco pack --outputdirectory '.output' $_.FullName }
}