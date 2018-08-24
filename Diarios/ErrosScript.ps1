# The objective in this script is to get information from HTML file and make a simple report.
# L'objectif de ce script est d'obtenir des informations à partir d'un fichier HTML et de créer un rapport simple.

#Name: Rohan Scanavez - ErrosScriptTSM
#Date: 16/08/2018

$ErrorActionPreference="stop"

#Variaveis auxiliares
$i=0
$cont=0

$dia=Get-Date -format dd-MM-yyyy
#EXAMPLE $dia="16-07-2018"

$mes="Nenhum","1 - Janeiro","2 - Fevereiro","3 - Março","4 - Abril","5 - Maio","6 - Junho", "7 - Julho","8 - Agosto","9 - Setembro","10 - Outubro","11 - Novembro","12 - Dezembro"
$arquivo="M:\Clientes\Dropbox (BySeven)\Tecnologia\TUPY\Auditoria TSM\Arquivos recebidos\2018\"+$mes[(($dia.split("-"))[1])]+"\$dia.htm"

# Create HTML file Object
$HTML = New-Object -Com "HTMLFile"

# Write HTML content according to DOM Level2 
$HTML.IHTMLDocument2_write($(get-content "$arquivo" -raw ))
$Colunas = $HTML.getElementsByTagName("td")


function Escreve-Cabecalho()
 {
  write-host "STATUS  RESULTS SCHEDULE_START    ACTUAL_START      SCHEDULE_NAME \ NODE_NAME \ DOMAIN_NAME" -ForegroundColor WHITE -BackgroundColor Black
  write-host " "
 }


Escreve-Cabecalho

foreach ($coluna in $colunas)
{   if ($coluna.InnerText -like " Status*")
      { $cont++ }
    if ($cont -ne "0")
      {

       if ($coluna.InnerText -like "Missed*" -or $coluna.InnerText -like "Failed*" -or $coluna.InnerText -like "Severed*") 
        {   if ($coluna.InnerText -like "Missed*") {write-host -nonewline $coluna.InnerText  -ForegroundColor YELLOW}
            if ($coluna.InnerText -like "Failed*") {write-host -nonewline $coluna.InnerText  -ForegroundColor RED}        
            if ($coluna.InnerText -like "Severed*"){write-host -nonewline $coluna.InnerText  -ForegroundColor RED -BackgroundColor Gray} 
            
          Write-Host -nonewline " "$colunas[$i+2].InnerText
          if ($colunas[$i+2].InnerText -like "") { write-host -nonewline "------"}
  
          if ($colunas[$i+3].InnerText -like "") { write-host -nonewline "------"}
             
          Write-Host -nonewline " "$colunas[$i+3].InnerText
     
          if ($colunas[$i+4].InnerText -like "") { write-host -nonewline "  ----------------"}
           else {Write-Host -nonewline " "$colunas[$i+4].InnerText}
          
          Write-Host -nonewline " "$colunas[$i+5].InnerText"\"
          Write-Host " "$colunas[$i+6].InnerText 
          
        }
          
  $i++ 
      }
 }
