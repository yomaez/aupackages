import-module au

$releases = 'https://notepad-plus-plus.org/downloads/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $url64   = $download_page.links | ? innerHTML -like '*Current Version*' | select innerHTML
    $version = $url64 -split {$_ -eq ' ' -or $_ -eq '<'} | select -last 1 -skip 1
    @{
        URL64   = 'https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v' + $version +'/npp.' + $Version + '.Installer.x64.exe'
        Version = $version
    }
}

update -ChecksumFor 64