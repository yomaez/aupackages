import-module au



function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    


    $AppPackage = "vscode" #Choco Package Name

    #Pull Version from Choco List
    $PackageVersion = choco list $AppPackage -e | Select -Index 1 
    $CharArray =$PackageVersion.Split(" ")
    $LatestPackageVersion = $CharArray[1]

    
    
    @{
        URL64   = 'https://update.code.visualstudio.com/' + $LatestPackageVersion + '/win32-x64/stable'
        Version = $LatestPackageVersion
    }
}

update -ChecksumFor 64