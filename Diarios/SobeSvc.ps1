# The objective in this script is to start every stopped service.
# L'objectif de ce script est de démarrer chaque service arrêté.

#Name: Rohan Scanavez - Subir todos os serviços parados
#Date: 21/07/2018

# Show stopped services
# Afficher les services arrêtés


Get-Service | ?{$_.Status -like 'Stopped'}

$stoppedServices = Get-WmiObject win32_service -Filter "startmode = 'manual' AND state != 'running'" | select -expand name

foreach ($stoppedService in $stoppedServices) {
  Set-Service -Service $stoppedService -Status Running
}

##### End of the Script #####
##### Fin du script #####