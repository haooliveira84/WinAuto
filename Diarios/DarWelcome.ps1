# The purpose of the script is to send an email to all employees hired by EmpresaX in the last X days
# L'objectif de ce script est d'envoyer un email à tous les employés embauchés par EmpresaX au cours des X derniers jours.
#Name: Rohan Scanavez - DarWelcome
#Date: 10/08/2018


# Set the parameters for sending e-mail. The variable $data_criacao specifies the number of days that the employee has been hired.
# Définissez les paramètres d'envoi du courrier électronique. La variable $ data_criacao spécifie le nombre de jours pendant lesquels l'employé a été embauché.

$data_criacao=  "-7"
$smtpserver =   "dominio-com-br.mail.protection.outlook.com"
$from =         "boasvindas@boasvindas.com.br"
$subject =      "Bem vindo a EmpresaX"

# Here we must customize the email that we will send
# Ici, nous devons personnaliser l'e-mail que nous enverrons
function cria-email($para_usuario)
  {
    $body = $null
    $body += "<html>"
    $body += "<head>"
    $body += "<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>"
    $body += "</head>"
    $body += "<body>"
    $body += "Ol&aacute; $para_usuario,<br><br>"
    $body += "Seja bem-vindo a EmpresaX.<br><br>"
    $body += "Os links abaixo tem como objetivo lhe deixar a par de assuntos essenciais da empresa.<br><br>"
    $body += "Todos os Comunicados, Normas e Documentos gerais da EmpresaX s&atilde;o encontrados na <a href='http://intranet.angeloni.com.br'>Intranet</a>. Abaixo listamos alguns mais relevantes inicialmente: <br><br>"
    $body += "<ul>"
    $body += "<li>Temos uma vers&atilde;o digital da <a href='http://intranet.empresaX.com.br/Segurana da TI/Cartilha de Seguran%C3%A7a da Informa%C3%A7%C3%A3o.pdf'>Cartilha de Conscientiza&ccedil;&atilde;o de Seguran&ccedil;a da Informa&ccedil;&atilde;o</a>, entregue fisicamente no per&iacute;odo de integra&ccedil;&atilde;o, que traz dicas e orienta&ccedil;&otilde;es para os colaboradores da EmpresaX e que deve ser tratada com extrema import&acirc;ncia. Ela &eacute; uma s&iacute;ntese da nossa <a href='http://intranet.empresaX.com.br/Paginas/Seguran%E7a-da-Informa%E7%E3o.aspx'>Pol&iacute;tica de Seguran&ccedil;a da Informa&ccedil;&atilde;o (PSI)</a> e suas Normas complementares. &Eacute; importante a leitura cuidadosa desses documentos pois neles voc&ecirc; ficar&aacute; por dentro do que a empresa espera e determina sobre comportamento e conduta digital segura;</li>"
    $body += "<li>Qualquer incidente ou anormalidade de seguran&ccedil;a da informa&ccedil;&atilde;o percebida pelo colaborador deve ser informada pelo e-mail seguranca.informacao@angeloni.com.br para que possa ser tratada pelo time de Resposta a Incidentes;</li>"
    $body += "<li>A EmpresaX orienta ao uso de um padr&atilde;o para assinaturas de e-mail que pode ser <a href='http://intranet.angeloni.com.br/sites/oraculo/Paginas/Padroniza%C3%A7%C3%A3o Assinaturas de e-mail.aspx'>consultado aqui</a>;</li>"
    $body += "<li>Em caso de problemas ou solicita&ccedil;&otilde;es relacionadas &agrave; Tecnologia da Informa&ccedil;&atilde;o voc&ecirc; dever&aacute; registr&aacute;-los no <a href='http://servicedesk.empresaX.com.br'>Portal do Servicedesk</a>. O atendimento pode ser feito pelo telefone (xx) xxxx-xxxx.</li>"
    $body += "<ul>"
    $body += "Email enviado " + $date + " , as " + $time + "."
    $body += "</ul>"
    $body += "</body>"
    $body += "</html>"
    return $body
  }

# Creates a message on the screen to inform who the welcome email was sent to.  
# Crée un message à l'écran pour indiquer à qui l'e-mail de bienvenue a été envoyé.  
function cria-report()
  {
    write-host "------------------------"
    write-host "- EMAIL DE BOAS VINDAS -"
    write-host "------------------------"
    write-host " "
    write-host "O email foi enviado para os usuarios a seguir:"
    write-host " " 
   }

# Here, we do the research to identify our target users.   
# Ici, nous effectuons la recherche pour identifier nos utilisateurs cibles.

$users = Get-aduser -filter * -Properties created, mail | Where-Object {$_.created -gt (Get-Date).AddDays($data_criacao)}|Select-Object name,created, mail
Clear-Host
cria-report

foreach ($user in $users) 
  {
    $usuario=$user.name   
    $to=$user.mail
    $date = get-date -format dd/MM/yyyy 
    $time = get-date -format t
    $email=cria-email($user.name)
    Send-MailMessage -To $to -From $From -subject $subject -Bodyashtml $email -SmtpServer $smtpServer
    Write-host "$usuario"
   }
write-host " "