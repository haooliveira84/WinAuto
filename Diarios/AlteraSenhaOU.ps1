<#
CRIADO POR:   Rohan Scanavez
E-MAIL:       rohangustavo@gmail.com.br
OBJETIVO:     Trocar todas as senhas dos usuarios dentro de uma OU
#>

# Converter para string
$pwd = "senha_desejada"
$password = "senha_desejada"
$pwd = convertto-securestring $password -asplaintext -force



# Mostrar senha gerada na console
$password

$users = Get-ADUser -filter * -searchbase "D. NAME DA OU QUE CONTEM OS USUARIOS"
echo "COUNT:"
($users | measure).Count
 
foreach ($user in $users)
    {
     Set-ADAccountPassword -Identity $user.SAMAccountName -NewPassword $pwd -Reset
     $usuario_alterado = $user.UserPrincipalName
     "Senha de $usuario_alterado alterada para $password"
    }
