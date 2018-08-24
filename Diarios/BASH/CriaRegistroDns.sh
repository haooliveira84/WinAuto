#!/bin/bash

usage="USAGE: sh ./CriaRegistroA.sh [registro] [ip]"

case $1 in
"--help") 
	echo $usage
	exit 0
	;;
esac

registro=$1
ip=$2

if [ -z "$registro" ] || [ -z "$ip" ] ;
then 
  echo "Argumento nao especificado!"
  echo $usage
  exit 0

else
 registro="$registro.by7.corp"
 {
   echo "update add $registro 86400 A $ip"
   echo 
 } | nsupdate -v -d

 echo ""
 echo "REGISTRO "$registro " associado ao IP " $ip " com sucesso"
fi
