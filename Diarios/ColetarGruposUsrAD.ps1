# The objective in this script is to show all groups that a user belongs.
# L'objectif de ce script est d'afficher tous les groupes auxquels un utilisateur appartient.

#Name: Rohan Scanavez - Mostrar grupos
#Date: 03/08/2018

$usuarios=Get-ADUser -Filter * -SearchBase "DC=by7,DC=corp"
$buscar="wiki*"

ForEach ($usuario in $usuarios){

  $resultado_grupo=Get-ADPrincipalGroupMembership $usuario | Where-Object {$_.name -like $buscar}
  if ($resultado_grupo.name -like $buscar) { 
   $resultado_nome=$usuario.name
   write-Host "Nome: $resultado_nome" -ForegroundColor DarkBlue -BackgroundColor White
   $resultado_grupo.name
  }
}
