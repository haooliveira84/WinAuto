# The objective in this script is to close all disconnected users in a given server.
# L'objectif de ce script est de fermer tous les utilisateurs déconnectés sur un serveur donné

#Name: Rohan Scanavez - Desconectar Usuarios
#Date: 07/08/2018

# Se não existir o diretório, ele o cria
# If the directory does not exist, it creates it
# Si le répertoire n'existe pas, il le crée

function Ensure-LogFilePath([string]$LogFilePath)
   {
 if (!(Test-Path -Path $LogFilePath)) 
     {New-Item $LogFilePath -ItemType directory >> $null}
   }
 
# Função criada para escrever diretamente no arquivo de log
# Function created to write directly to the log file
# Fonction créée pour écrire directement dans le log

function Write-Log([string]$message)
  {
   Out-File -InputObject $message -FilePath $LogFile -Append
  }

 # Função que inicializa e formata os dados de sessão
 # Function that initializes and formats session data
 # Fonction qui initialise et formate les données de session  
function Get-Sessions
{
   $queryResults = query session
   $starters = New-Object psobject -Property @{"SessionName" = 0; "UserName" = 0; "ID" = 0; "State" = 0; "Type" = 0; "Device" = 0;}
   foreach ($result in $queryResults)
   {
      try
      {
         if($result.trim().substring(0, $result.trim().indexof(" ")) -eq "SESSIONNAME")
         {
            $starters.UserName = $result.indexof("USERNAME");
            $starters.ID = $result.indexof("ID");
            $starters.State = $result.indexof("STATE");
            $starters.Type = $result.indexof("TYPE");
            $starters.Device = $result.indexof("DEVICE");
            continue;
         }
 
         New-Object psobject -Property @{
            "SessionName" = $result.trim().substring(0, $result.trim().indexof(" ")).trim(">");
            "Username" = $result.Substring($starters.Username, $result.IndexOf(" ", $starters.Username) - $starters.Username);
            "ID" = $result.Substring($result.IndexOf(" ", $starters.Username), $starters.ID - $result.IndexOf(" ", $starters.Username) + 2).trim();
            "State" = $result.Substring($starters.State, $result.IndexOf(" ", $starters.State)-$starters.State).trim();
            "Type" = $result.Substring($starters.Type, $starters.Device - $starters.Type).trim();
            "Device" = $result.Substring($starters.Device).trim()
         }
      } 
      catch 
      {
         $e = $_;
         Write-Log "ERROR: " + $e.PSMessageDetails
      }
   }
}

# Chamando as funções
# Function call
# Fonctions d'appel

Ensure-LogFilePath($ENV:LOCALAPPDATA + "\DisconnectedSessions")
$LogFile = $ENV:LOCALAPPDATA + "\DisconnectedSessions\" + "sessions_" + $([DateTime]::Now.ToString('yyyyMMdd')) + ".log"
 
[string]$IncludeStates = '^(Disc)$'
Write-Log -Message "LIMPEZA DE SESSOES DESCONECTADAS"
Write-Log -Message "================================"
$DisconnectedSessions = Get-Sessions | Where-Object {$_.State -match $IncludeStates -and $_.UserName -ne ""} | Select-Object ID, UserName
Write-Log -Message "Sessoes finalizadas"
Write-Log -Message "-------------------"
foreach ($session in $DisconnectedSessions)
{
   logoff $session.ID
   Write-Log -Message $session.Username
}
Write-Log -Message " "
Write-Log -Message "Concluido"

# Escrevendo dados de saida
# write output
# écrire donné

Get-Content $logfile
Pause
