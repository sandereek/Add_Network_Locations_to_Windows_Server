function Add-NetworkLocation {
    <#
        Author: 
            
            Tom White, 2015.
        
        Description:
    
            Creates a network location shortcut using the specified path, name and target.
            Replicates the behaviour of the 'Add Network Location' wizard, creating a special folder as opposed to a simple shortcut.
    
            Returns $true on success and $false on failure.
    
            Use -Verbose for extended output.
    
        Example:
    
            Add-NetworkLocation -networkLocationPath "$env:APPDATA\Microsoft\Windows\Network Shortcuts" -networkLocationName "Network Location" -networkLocationTarget "\\server\share" -Verbose
    #>
        [CmdLetBinding()]
        param
        (
            [Parameter(Mandatory = $true)][string]$networkLocationPath,
            [Parameter(Mandatory = $true)][string]$networkLocationName ,
            [Parameter(Mandatory = $true)][string]$networkLocationTarget
        )
        Begin {
            Write-Verbose -Message "Network location path: `"$networkLocationPath`"."
            Write-Verbose -Message "Network location name: `"$networkLocationName`"."
            Write-Verbose -Message "Network location target: `"$networkLocationTarget`"."
            Set-Variable -Name desktopIniContent -Option ReadOnly -value ([string]"[.ShellClassInfo]`r`nCLSID2={0AFACED1-E828-11D1-9187-B532F1E9575D}`r`nFlags=2")
        }
        Process {
            Write-Verbose -Message "Checking that `"$networkLocationPath`" is a valid directory..."
            if (Test-Path -Path $networkLocationPath -PathType Container) {
                try {
                    Write-Verbose -Message "Creating `"$networkLocationPath\$networkLocationName`"."
                    [void]$(New-Item -Path "$networkLocationPath\$networkLocationName" -ItemType Directory -ErrorAction Stop)
                    Write-Verbose -Message "Setting system attribute on `"$networkLocationPath\$networkLocationName`"."
                    Set-ItemProperty -Path "$networkLocationPath\$networkLocationName" -Name Attributes -Value ([System.IO.FileAttributes]::System) -ErrorAction Stop
                }
                catch [Exception] {
                    Write-Error -Message "Cannot create or set attributes on `"$networkLocationPath\$networkLocationName`". Check your access and/or permissions."
                    return $false
                }
            }
            else {
                Write-Error -Message "`"$networkLocationPath`" is not a valid directory path."
                return $false
            }
            try {
                Write-Verbose -Message "Creating `"$networkLocationPath\$networkLocationName\desktop.ini`"."
                [object]$desktopIni = New-Item -Path "$networkLocationPath\$networkLocationName\desktop.ini" -ItemType File
                Write-Verbose -Message "Writing to `"$($desktopIni.FullName)`"."
                Add-Content -Path $desktopIni.FullName -Value $desktopIniContent
            }
            catch [Exception] {
                Write-Error -Message "Error while creating or writing to `"$networkLocationPath\$networkLocationName\desktop.ini`". Check your access and/or permissions."
                return $false
            }
            try {
                $WshShell = New-Object -ComObject WScript.Shell
                Write-Verbose -Message "Creating shortcut to `"$networkLocationTarget`" at `"$networkLocationPath\$networkLocationName\target.lnk`"."
                $Shortcut = $WshShell.CreateShortcut("$networkLocationPath\$networkLocationName\target.lnk")
                $Shortcut.TargetPath = $networkLocationTarget
                $Shortcut.Description = "Created $(Get-Date -Format s) by $($MyInvocation.MyCommand)."
                $Shortcut.Save()
            }
            catch [Exception] {
                Write-Error -Message "Error while creating shortcut @ `"$networkLocationPath\$networkLocationName\target.lnk`". Check your access and permissions."
                return $false
            }
            return $true
        }
    }
    
    
    function Add-HEINEKENNetworkLocation {
    
    <#
        Author: 
            
            Sander Eek, 2020
        
        Description:
    
        Converts a UNC path into a Network location procesable by the Add-NetworkLocation
    
        Example:
    
        Add-HEINEKENNetworkLocation -networkLocation "\\at1slnz100.at1.heiway.net\dat\linien\oi\03_Sekretariat"
    #>
    
    
        param
        (
            [Parameter(Mandatory = $true)][string]$networkLocation
        )
        
    
        $nLastIndexOf = $networkLocation.LastIndexOf('\')
        $nlength = $networkLocation.Length
        $nNumChars = $nlength - $nLastIndexOf
        $NetworkLocationName = $networkLocation.substring($nLastIndexOf + 1, $nNumChars - 1)
        write-Host "-------------------------------------------------------------------------------------------------------"
        $Result = Add-NetworkLocation -networkLocationPath "$env:APPDATA\Microsoft\Windows\Network Shortcuts" -networkLocationName $NetworkLocationName -networkLocationTarget $networkLocation -Verbose 
        If (!$Result) { pause }
    }
    
    
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\branareport$"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\CompensationBenefices$"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\facilitygs"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\npi$"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\QualityControl$"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\brewhse"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\bshop"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\bshoplab"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\Corporate Affairs"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\dgle"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\engn"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\FGOOD"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\FINANCE"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\gar"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\HR"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\HR_2"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\Management_Team$"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\MARKETING"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\purc"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\rsh"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\secur"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\sles"
Add-HEINEKENNetworkLocation -networkLocation "\\Ht1spapsccm01.ht1.heiway.net\departments$\whse"