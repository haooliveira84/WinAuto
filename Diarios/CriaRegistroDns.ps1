# The purpose of this script is to create an A record in DNS by providing only two parameters: the record name and the ip.
# L'objectif de ce script est de créer un enregistrement A dans DNS en ne fournissant que deux paramètres: le nom de l'enregistrement et l'adresse IP.
# O objetivo desse script é criar um registro A no DNS fornecendo apenas dois parâmetros: o nome do registro e o ip.

#Name: Rohan Scanavez - Criar registro A no DNS
#Date: 24/08/2018

#muda o tratamento do PS para que pare na ocorrencia de erro
$ErrorActionPreference= "stop"

#informe o servidor DNS e o nome da zona 
$dns_server="seven-ddc001"
$nome_zona="by7.corp"


function CriaRegistroA
  {  
    param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true
        )]
         [string]$SeuRegisroA, 
         [string]$SeuIP
        )

    Add-DnsServerResourceRecordA -ComputerName $dns_server -Name $SeuRegisroA -ZoneName $nome_zona -AllowUpdateAny -IPv4Address $SeuIP
  }

function MostraRegistroA
  {
    param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true
        )]
         [string]$arg1
        )

    Get-DnsServerResourceRecord -ComputerName $dns_server -ZoneName $nome_zona -Name $arg1
  }

##PARA TESTES

<########################
clear

	try
	{  
     CriaRegistroA $nome_registro $novo_ip
     Write-Host "Foi criado o seguinte registro: "
     Write-Host ""
     MostraRegistroA $nome_registro
	}  
	catch
	{
	 Write-Host "Já havia um registro"
     Write-Host ""
     MostraRegistroA $nome_registro
    }
########################>