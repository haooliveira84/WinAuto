# The objective in this script is to cleanup files automatically, without disrupting any service.
# L'objectif de ce script est de nettoyer les fichiers automatiquement, sans perturber les services.

#Name: Rohan Scanavez - Limpeza de arquivos no C:
#Date: 21/07/2018

#### Variables ####
#### Variables ####

$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace(0xA)
$temp = get-ChildItem "env:\TEMP"
$temp2 = $temp.Value
$WinTemp = "c:\Windows\Temp\*"
$result_ini=Get-WmiObject Win32_LogicalDisk -Filter 'DriveType = 3' |Foreach-Object {($_.FreeSpace)/1GB}

# Cleanup log events
# Événements de journal de nettoyage
wevtutil el | Foreach-Object {wevtutil cl "$_"}

# Remove temp files located in "C:\Users\USERNAME\AppData\Local\Temp"
# Supprimer les fichiers temporaires situés dans "C:\Users\USERNAME\AppData\Local\Temp"
write-Host "Removendo arquivos desnecessários em $temp2." -ForegroundColor Magenta
Remove-Item -Recurse  "$temp2\*" -Force -Verbose


# Empty Recycle Bin
# Poubelle de recyclage vide

write-Host "Limpando a lixeira" -ForegroundColor Cyan
$objFolder.items() | ForEach-Object { remove-item $_.path -Recurse -Confirm:$false}

# Remove Windows Temp Directory
# Supprimer le répertoire temporaire de Windows
write-Host "Removendo arquivos desnecessários em $WinTemp." -ForegroundColor Green
Remove-Item -Recurse $WinTemp -Force

# Running Disk Clean up Tool
# Exécution de l'outil Nettoyage du disque

write-Host "Executando tarefa de limpeza" -ForegroundColor Cyan
cleanmgr /sagerun:1 | out-Null

$([char]7)
Start-Sleep 1
$([char]7)
Start-Sleep 1

write-Host "Espaço liberado (GB): " -ForegroundColor Yellow

$result_fin=Get-WmiObject Win32_LogicalDisk -Filter 'DriveType = 3' |Foreach-Object {($_.FreeSpace)/1GB}

$liberado=$result_ini-$result_fin

[math]::Round(($liberado)*100, 2)


##### End of the Script #####
##### Fin du script #####