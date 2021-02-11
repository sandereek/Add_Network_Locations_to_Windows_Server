
<#
    Author: 
        
        Sander Eek, 2020
    
    Description:

    Includes the PowerShell Functions used to add a UNC path as a Network Location to Windows Server (also works on Windows Clients) and
    then calls the Add-HEINEKENNetworklocation function with the UNC path (folders are supported) that need to be added as a network location
    
#>

. .\homaas_v2\Add-NetworkLocation_for_LinkFixer.ps1

Add-HEINEKENNetworkLocation -networkLocation "\\at1slnz100.at1.heiway.net\dat\linien\oi\03_Sekretariat"