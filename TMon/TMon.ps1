# The objective is to export the input from SERIAL and forward this to an archive that Zabbix can read.
# L'objectif est d'exporter l'entrée de SERIAL et de la transférer vers une archive que Zabbix peut lire.
# v.1.0


$port= new-Object System.IO.Ports.SerialPort COM5,9600,None,8,one
$port.Open();
$port.ReadExisting();