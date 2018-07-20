# The objective is to export the input from SERIAL and forward this to an archive that Zabbix can read.
# L'objectif est d'exporter l'entrée de SERIAL et de la transférer vers une archive que Zabbix peut lire.

#Name: Rohan Scanavez - Monitor de temperatura (TMon v.1.0)
#Date: 20/07/2018

$port= new-Object System.IO.Ports.SerialPort COM3,9600,None,8,one
$port.ReadTimeout = 9000 		#Timeout is set to 9 seconds/Timeout est réglé sur 9 secondes
$port.DtrEnable = "true"
$port.open() 					#opens a serial connection/ouvre une connexion Serial


Start-Sleep 2 					#wait 2 seconds until Arduino is ready/attendez 2 secondes jusqu'à ce que Arduino soit prêt

$port.Write("93c") 				#writes your content to the serial connection/écrit votre contenu sur la connexion Serial

try
  {
   $Temperatura = $port.ReadLine()
  }

catch [TimeoutException]
  {
								#Error handling code here/Erreur de gestion du code ici
  }

finally
  {
  								    #Any cleanup code goes here/Tout code de nettoyage va ici
   $port.Close() 					#closes serial connection/ferme la connexion Serial
  }

return $Temperatura