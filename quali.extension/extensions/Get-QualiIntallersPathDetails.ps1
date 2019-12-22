<#
.SYNOPSIS
    Returns a hash with installers network paths

.EXAMPLE
    Get-QualiIntallersPathDetails

.OUTPUTS
    [string]
#>

$qualiUnattendIntallersPath = "\\qsnas1\Storage\devops\unattended"
$vsredistInstallersPath = "$qualiUnattendIntallersPath\VCredist"

function Get-QualiIntallersPathDetails {
    return @{
        'Path' = $qualiUnattendIntallersPath;
        'KB2919355' = "$qualiUnattendIntallersPath\KB2919355";
        'KB2919442' = "$qualiUnattendIntallersPath\KB2919442";
        
        'KB2999226Client' = "$qualiUnattendIntallersPath\KB2999226\Client";
        'KB2999226Server' = "$qualiUnattendIntallersPath\KB2999226\Server";
        
        'KB3033929Client' = "$qualiUnattendIntallersPath\KB3033929\Client";
        'KB3033929Server' = "$qualiUnattendIntallersPath\KB3033929\Server";        
        
        'KB3035131Client' = "$qualiUnattendIntallersPath\KB3035131\Client";
        'KB3035131Server' = "$qualiUnattendIntallersPath\KB3035131\Server";
        
        'VCredist14' = "$vsredistInstallersPath\14";
        'VCredist12' = "$vsredistInstallersPath\12";
        'VCredist11' = "$vsredistInstallersPath\11";
        'VCredist10' = "$vsredistInstallersPath\10";
        'VCredist9' = "$vsredistInstallersPath\9";
        'VCredist8' = "$vsredistInstallersPath\8";

        'Jdk' = "$qualiUnattendIntallersPath\jdk";
        'NodeJsLts' = "$qualiUnattendIntallersPath\nodejs-lts";
        'Python27' = "$qualiUnattendIntallersPath\python27";
        'Python38' = "$qualiUnattendIntallersPath\python38";
        'Chrome' = "$qualiUnattendIntallersPath\chrome";
        'Ruby' = "$qualiUnattendIntallersPath\ruby";
    }
}