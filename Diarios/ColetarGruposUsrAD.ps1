# The objective in this script is to show all groups that a user belongs.
# L'objectif de ce script est d'afficher tous les groupes auxquels un utilisateur appartient.

#Name: Rohan Scanavez - Mostrar grupos
#Date: 03/08/2018

$usuarios=Get-ADUser -Filter * -SearchBase "DC=by7,DC=corp"

ForEach ($usuario in $usuarios){

  $resultado=Get-ADPrincipalGroupMembership $usuario | Where-Object {$_.name -like "wiki*"}
  if ($resultado.name -like "wiki*") { 
   write-Host "Nome: $usuario.name" -ForegroundColor DarkBlue -BackgroundColor White
   $resultado.name
  }
}
