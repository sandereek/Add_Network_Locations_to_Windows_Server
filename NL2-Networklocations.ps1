. .\Add-NetworkLocation_on_WinServer.ps1

# Add-HEINEKENNetworkLocation -networkLocation "\\UNCpath\Share\Folder" -networklocationname "Networklocationname"
# Network locations are stored in %appdata%\Microsoft\Windows\Network Shortcuts

Add-HEINEKENNetworkLocation -networkLocation "\\nl2sbunfile01.nl2.heiway.net\dfsroot$\V\DataProj\wg-Manuals-Colonne1+2" 
Add-HEINEKENNetworkLocation -networkLocation "\\nl2sbunfile01.nl2.heiway.net\dfsroot$\V\DataProj\wg-Manuals-Colonne3+9+10"
Add-HEINEKENNetworkLocation -networkLocation "\\nl2sbunfile01.nl2.heiway.net\dfsroot$\V\DataProj\wg-Manuals-Colonne4"
Add-HEINEKENNetworkLocation -networkLocation "\\nl2sbunfile01.nl2.heiway.net\dfsroot$\V\DataProj\wg-RayA-Tech"
