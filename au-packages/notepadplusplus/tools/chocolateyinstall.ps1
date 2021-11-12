
$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = '' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe' #only one of these: exe, msi, msu
  url64bit      = 'https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.1.9/npp.8.1.9.Installer.x64.exe'
  softwareName  = 'Notepad ++' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum64    = '23bde004114ee4d17b11608da2c78fda365874fd64194a6ea167dd3050576b42'
  checksumType64= 'sha256' #default is checksumType

  # MSI
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
  
}

Install-ChocolateyPackage @packageArgs # https://docs.chocolatey.org/en-us/create/functions/install-chocolateypackage
