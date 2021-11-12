import-module au

$releases = 'https://www.7-zip.org/download.html'

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

    $url64   = $download_page.links | ? href -match '.msi$' | % href | select -First 1
    $version = $url64 -split '/|.msi' | select -Last 1 -skip 1
    $version = $url64 -split 'z|-' | select -last 1 -skip 1
    @{
        URL64   = 'https://www.7-zip.org/a/' + $url64
        Version = $version
    }
}

update -ChecksumFor 64