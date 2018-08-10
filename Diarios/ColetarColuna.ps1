# O objetivo do script é executar o comanto ctstat, direcionar a saida para um arquivo de texto e ler uma informação em um coluna específica
#Name: Rohan Scanavez - Alerta do CTSTAT
#Date: 10/08/2018

# Definir localização do ctstat:
PowerShell.exe -Command "& ""E:\TOTVS\CtreeServer\V9.5.3\win32\tools\cmdline\admin\client\ctstat -vas -i 2 1 -h 20 -s FAIRCOMS -u ADMIN -p ADMIN > E:\temp\zabbix.txt"

# Pegar conteúdo do arquivo
$original=Get-Content E:\temp\zabbix.txt
$final=($original.split(" ").split("/"))

# Retornar o valor da coluna específica
return $final[86]