
$ErrorActionPreference = 'Stop'; # stop on all errors



$packageArgs = @{
  packageName   = '7zippackage'
  unzipLocation = $toolsDir
  fileType      = 'msi' #only one of these: exe, msi, msu
  url64bit      = ''
  softwareName  = '7Zip' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum64    = ''
  checksumType64= 'sha256' #default is checksumType

  # MSI
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
  
}

Install-ChocolateyPackage @packageArgs # https://docs.chocolatey.org/en-us/create/functions/install-chocolateypackage

