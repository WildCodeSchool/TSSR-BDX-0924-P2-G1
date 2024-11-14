Clear-Host

#Importation du module Posh-SSH
Import-Module Posh-SSH

# Définition des fonctions

# Fonction pour enregistrer chaque information demandée dans un fichier

function SaveToFile {
  param (
    [string]$targetName,
    [string]$infoContent
    )
  # Format de la date
  $date = (Get-Date -Format "yyyyMMdd")

#  Write-Host "DEBUG//1 $targetName"

  # Nom du fichier
  $fileName = "info_" + $targetName + "_" + $date + ".txt"

  # Déterminer le dossier de sauvegarde
  $userProfile = [System.Environment]::GetFolderPath('UserProfile')
  $saveFolder = Join-Path $userProfile 'Documents'

  # Chemin complet du fichier
  $filePath = Join-Path $saveFolder $fileName
 
  # Écrire les informations dans le fichier
  $infoContent | Out-File -FilePath $filePath -Append -Encoding UTF8
  Write-Host "Informations sauvegardées dans le fichier : $filePath" -ForegroundColor Green
}

# Fonction pour ajouter une entrée au fichier log
function Add-LogEntry {
    param (
        [string]$Name,  
        [string]$event  
    )
   
 
    $logFile = "C:\Windows\System32\LogFiles\log_evt.log"
   
 
    $logEntry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $Name - $event"
   
    # Ajouter l'entrée au fichier log
    Add-Content -Path $logFile -Value $logEntry
}

function menuMain {
    Switch ($targetChoice) {
        1 { Write-Host "CIBLE UTILISATEUR"
        Add-LogEntry -event "Sélection de l'option 'Cible Utilisateur'"
        }
        2 { Write-Host "CIBLE ORDINATEUR"
        Add-LogEntry -event "Sélection de l'option 'Cible Ordinateur'"
        }
        default { Write-Host "Choix invalide"
        Add-LogEntry -event "Choix invalide dans le menu principal"
        }
       
    }
}

#function askUserId {
 #   Write-Host "Quel est votre identifiant?"
  #  $Name = Read-Host "Tapez votre identifiant"
#}

#function validateTarget {
    #Switch ($actions) {
        #1 { Write-Host "Choix utilisateur validé" }
        #2 { Write-Host "Choix ordinateur validé" }
        #default { Write-Host "Choix invalide" }
    #}
#}
function createUser {
    Write-Host "Souhaitez-vous créer ce nouvel utilisateur? (oui/non)"
    Add-LogEntry -user $Name -event "Demande de création de l'utilisateur"
   
    $createResponse = Read-Host

        If ($createResponse -eq "oui") {
           Invoke-SSHCommand -SessionId $session.SessionId -Command "New-LocalUser -Name '$Name'"
           Add-LogEntry -user $Name -event "Création de l'utilisateur$Name'"
   
           } else {
           Write-Host "Que souhaitez-vous faire?`n1- Repréciser votre identifiant`n2- Quitter"
           Add-LogEntry -user $Name -event "Demande de choix d'actions"
           $choixCreate = Read-Host "Taper votre choix "

           Switch ($choixCreate) {
                1 { IdUser }
                2 { exit }
                default { Write-Host "Choix invalide" }
            }
         }
}

function deleteUser {
    Write-Host "Suppression du compte (oui/non)"
    $deleteAnswer = Read-Host "Tapez votre choix"
    Add-LogEntry -user $Name -event "Demande de confirmation de suppression du compte"
    if ($deleteAnswer -eq "oui") {
        Invoke-SSHCommand -SessionId $session.SessionId -Command "Remove-LocalUser -Name '$Name'"
    Add-LogEntry -user $Name -event "Suppression du compte utilisateur '$Name'"
    } else {
        Pop-Location
    Add-LogEntry -user $Name -event "Annulation de la suppression du compte '$Name'"
    }
}

function modifyUser {
Write-host "Que souhaitez-vous modifier?`n1-Modifier votre nom`n2-Modifier votre mot de passe"
Add-LogEntry -user $Name -event "Demande du choix de la modification"
    $modif=Read-host
   Switch ($modif) {
    1 {
      $newName = Read_Host "Entrez le nouveau nom pour l'utilisateur : "
      Invoke-SSHCommand -SessionId $session.SessionId -Command "Rename-LocalUser -Name '$Name' -NewName '$newName'"
      Write-Host "Nom d'utilisateur modifié en $newName." -ForegroundColor Green
      Add-LogEntry -user $Name -event "Modification du nom d'utilisateur '$Name'"
        }
    2 {
      write-host "Indiquez le nouveau mot de passe"
      $mdp=read-host -AsSecureString
      Invoke-SSHCommand -SessionId $session.SessionId -Command "Set-LocalUser -Name '$Name' -Password (ConvertToString '$mdp' -AsPlainText -Force)"
       Add-LogEntry -user $Name -event "Modification du mot de passe de l'utilisateur '$Name'"
        }  
    default {Write-Host "Choix invalide"
     Add-LogEntry -user $Name -event "Choix invalide pour modification de compte"}
        }      
}

function ActionsUser {
    Switch ($action) {
        1 { modifyUser }
        2 { deleteUser }
        3 { infosUser }
        default { Write-Host "Choix invalide"
        Add-LogEntry -user $Name -event "Choix invalide"}
    }
}

function infosUser {
Write-Host "Quelles informations souhaitez-vous récupérer?`n1-Nom d'utilisateur`n2-Date de dernière connexion`n3-SID`n4-Retour`n5-Quitter"
Add-LogEntry -user $Name -event "Demandes d'informations à récupérer"
$recupUserInfo = Read-Host "Tapez votre choix"

# Initialisation du contenu informations à sauvegarder
$infoToSave = ""

  Switch ($recupUserInfo) {
 
      1 {
        $resUser = Invoke-SSHCommand -SessionId $session.SessionId -Command "Get-LocalUser | Where-Object { $_.Name -eq '$Name' } | Select-Object Name"
        $infoToSave = "Nom d'utilisateur : $($resUser.Output.Trim())"
        SaveToFile $Name $infoToSave
        Write-Host "=========================================================================" -ForegroundColor Cyan
        Write-Host "Nom d'utilisateur : $($resUser.Output.Trim())" -ForegroundColor Cyan
        Write-Host "=========================================================================" -ForegroundColor Cyan
        Add-LogEntry -user $Name -event "Affichage du nom d'utilisateur"
        }
      2 {
        $resConnexion = Invoke-SSHCommand -SessionId $session.SessionId -Command "Get-Localuser -Name '$Name'| Select-Object lastlogon"
        $infoToSave = "Dernière connexion : $($resConnexion.Output.Trim())"
        SaveToFile $Name $infoToSave
        Write-Host "=========================================================================" -ForegroundColor Cyan
        Write-Host "Dernière connexion : $($resConnexion.Output.Trim())" -ForegroundColor Cyan
        Write-Host "=========================================================================" -ForegroundColor Cyan
        Add-LogEntry -user $Name -event "Affichage de la date de dernière connexion"
        }
      3 {
        $resSID = Invoke-SSHCommand -SessionId $session.SessionId -Command "Get-Localuser -Name '$Name'| Select-Object SID"
        $infoToSave = "SID : $($resSID.Output.Trim())"
        SaveToFile $Name $infoToSave
        Write-Host "=========================================================================" -ForegroundColor Cyan
        Write-Host "SID : $($resSID.Output.Trim())" -ForegroundColor Cyan
        Write-Host "=========================================================================" -ForegroundColor Cyan
        Add-LogEntry -user $Name -event "Affichage du SID"
        }
      4 {
        ActionsUser
        Add-LogEntry -user $Name -event "Retour au menu précédent"
        }
      5 {
        Write-Host "==================================" -ForegroundColor Cyan
        Write-Host "|    Fermeture... Au revoir!    |" -ForegroundColor Cyan
        Write-Host "==================================" -ForegroundColor Cyan;
        Add-LogEntry -user $Name -event "Sortie du script"
        exit
        }
      default {
        Write-Host "Choix invalide"
        return infosUser
        Add-LogEntry -user $Name -event "Retour au menu précédent"
        }

   }
}

function IdUser {
    Write-Host "===============================`nQuel est votre identifiant ?"
    $Name = Read-Host "Entrer le nom de l'utilisateur client "

    #Vérification que l'utilisateur est connu sur la machine cliente
    #$userCheck = Invoke-SSHCommand -SessionId $session.SessionId -Command "whoami"
    #$getLocalUser = " DEBEUG $($userCheck.Output.Trim())"
    #$getLocalUser = Get-LocalUser | Where-Object { $_.Name -eq "wilder" }
    #write-host " DEBUG 2 $getLocalUser"
    If ($getLocalUser -like '$($Name)') {
        Write-Host "[Succès] L'utilisateur $Name est reconnu." -ForegroundColor Green
        Add-LogEntry -user $Name -event "Utilisateur $Name reconnu"
        } else {
        Write-Host "[Attention] Cet utilisateur est inconnu" -ForegroundColor Red
        Add-LogEntry -user $Name -event "Utilisateur inconnu"
        createUser
        }
}

function IdOrdi {
    Write-Host "===============================`nQuel est votre identifiant ?"
    Add-LogEntry -user $Name -event "Demandes de l'identifiant"
    $Identifiant = Read-Host "Entrer le nom d'hôte client "

    #Tant que l'dentifiant est incorrect, redemander l'identifiant
    While (-not (Test-Connection -ComputerName $Identifiant -Count 1 -Quiet)) {
        Write-Host "[Erreur] Identifiant incorrect. Veuillez réessayer" -ForegroundColor Red
        Add-LogEntry -user $Name -event "Identifiant incorrect"
        $Identifiant = Read-Host "Entrer le nom d'hôte "
        }
        Write-Host "[Succès] Identifiant correct. L'ordinateur a été trouvé." -ForegroundColor Green
        Add-LogEntry -user $Name -event "Identifiant correct"
        return $Identifiant          
}

function GetInfoSyst {
    Write-Host "==============================================`nQuelles informations souhaitez-vous récupérer? `n1 - Nom de l'hôte`n2 - Système d'exploitation et sa version`n3 - Adresse IP`n4 - Nombres d'utilisateurs`n5 - Retour au menu précédent`n6 - Quitter"
    Add-LogEntry -user $Name -event "Demande quelles infos sont à récupérer pour l'ordinateur"
   $recupOrdiInfo = Read-Host "Tapez votre choix"

    # Initialisation du contenu informations à sauvegarder
    $infoToSave = ""

    Switch ($recupOrdiInfo) {
        1 {
            $hostname = Invoke-SSHCommand -SessionId $session.SessionId -Command "hostname"
            $infoToSave = "Nom de l'hôte : $($hostname.Output.Trim())"
            SaveToFile $Identifiant $infoToSave
            Write-Host "====================================" -ForegroundColor Cyan
            Write-Host "|     Nom de l'hôte : $($hostname.Output.Trim())     |" -ForegroundColor Cyan
            Write-Host "====================================" -ForegroundColor Cyan
            Add-LogEntry -user $Identifiant -event "Récupération du nom de l'hôte de l'ordinateur '$Identifiant'"
            GetInfoSyst
        }
        2 {
            $os = Invoke-SSHCommand -SessionId $session.SessionId -Command "wmic os get Caption"
            $version = Invoke-SSHCommand -SessionId $session.SessionId -Command "wmic os get Version"
            $infoToSave = "Système d'exploitation : $($os.Output.Trim())`nVersion : $($version.Output.Trim())"
            SaveToFile -targetName $Identifiant -infoContent $infoToSave
            Write-Host "=====================================" -ForegroundColor Cyan
            Write-Host " $($os.Output) " -ForegroundColor Cyan
            Write-Host " $($version.Output)" -ForegroundColor Cyan
            Write-Host "=====================================" -ForegroundColor Cyan          
            Add-LogEntry -user $Identifiant -event "Récupération du système d'exploitation et de sa version pour '$Identifiant'"
            GetInfoSyst
        }
        3 {
            $ipAddresses = Invoke-SSHCommand -SessionId $session.SessionId -Command "ipconfig | findstr IPv4"
            foreach ($ip in $ipAddresses.Output) {
              Write-Host "=========================================================================" -ForegroundColor Cyan
              Write-Host " |  Adresse IP : $ip   |" -ForegroundColor Cyan
              Write-Host "=========================================================================" -ForegroundColor Cyan
              }
            $infoToSave = "$ip"
            SaveToFile -targetName $Identifiant -infoContent $infoToSave
            Add-LogEntry -user $Identifiant -event "Récupération des adresses IP de l'ordinateur '$Identifiant'"
           GetInfoSyst
        }
        4 {
            $utilisateurs = Invoke-SSHCommand -SessionId $session.SessionId -Command "Get-LocalUser"
            $nombreUtilisateurs = $utilisateurs.Output.Count
            $infoToSave = "Nombre d'utilisateur : $nombreUtilisateurs"
            SaveToFile -targetName $Identifiant -infoContent $infoToSave
            Write-Host "========================================" -ForegroundColor Cyan
            Write-Host "|   Nombre total d'utilisateurs : $nombreUtilisateurs   |" -ForegroundColor Cyan
            Write-Host "========================================" -ForegroundColor Cyan
            Add-LogEntry -user $Identifiant -event "Récupération du nombre d'utilisateurs de l'ordinateur '$Identifiant'"
          GetInfoSyst
        }
        5 { ActionsOrdinateur }
        6 {
        Write-Host "==================================" -ForegroundColor Cyan
        Write-Host "|    Fermeture... Au revoir!    |" -ForegroundColor Cyan
        Write-Host "==================================" -ForegroundColor Cyan;
        Add-LogEntry -user $Identifiant -event "Fermeture du script"
            exit }
        default {
            Write-Host "Choix invalide"
            Add-LogEntry -user $Identifiant -event "Choix invalide pour récupération d'informations système"
           return GetInfoSyst
        }
    }
}

function ActionsOrdinateur {
    Write-Host "===========================================`nQue souhaitez-vous faire avec l'ordinateur ?`n1 - Eteindre l'ordinateur`n2 - Redémarrer l'ordinateur`n3 - Récupérer des informations`n4 - Retour au menu précédent`n5 - Quitter"
   Add-LogEntry -user $Name -event "Demande des choix concernant l'ordinateur $Identifiant"
    $actionOrdi = Read-Host "Tapez votre choix"

    Switch ($actionOrdi) {
        1 {
            Invoke-SSHCommand -SessionId $session.SessionId -Command "Shutdown /s /f /t 0"
            Write-Host "Extinction de l'ordinateur..."
        Add-LogEntry -user $Identifiant -event "Extinction de l'ordinateur '$Identifiant'"
       }
        2 {
            Invoke-SSHCommand -SessionId $session.SessionId -Command "Shutdown /r /f /t 0"
            Write-Host "Redémarrage de l'ordinateur..."
        Add-LogEntry -user $Identifiant -event "Redémarrage de l'ordinateur '$Identifiant'"
        }
        3 { GetInfoSyst
        Add-LogEntry -user $Identifiant -event "Récupération des informations système de l'ordinateur '$Identifiant'"
        }
        4 {
            Write-Host "Retour au menu précédent"
            Add-LogEntry -user $Identifiant -event "Retour au menu précédent"
        return menuMain
        }
        5 {
           Write-Host "==================================" -ForegroundColor Cyan
           Write-Host "|    Fermeture... Au revoir!    |" -ForegroundColor Cyan
           Write-Host "==================================" -ForegroundColor Cyan;
           Add-LogEntry -user $Identifiant -event "Sortie du script"
        exit
        }
        default {
            Write-Host "Choix invalide"
            Add-LogEntry -user $Identifiant -event "Choix invalide dans le menu ActionsOrdinateur"
        return menuMain
        }
    }
}

# Connexion à l'hôte distant avec SSH
$username = "wilder"
#$username = Read-Host "========================================`nEntrez le nom de l'utilisateur distant "

$clientIP = "10.2.0.14"
#$clientIP = Read-Host "========================================`nEntrez l'adresse IP du client "

# Demander le mot de passe de l'utilisateur
$password = Read-Host -AsSecureString "========================================`nEntrez le mot de passe du client $username "

#Créer un objet PSCredential
$credential=New-Object System.Management.Automation.PSCredential($username, $password)

# Créer une session SSH
try {
    Write-Host "Tentative de connexion SSH à $clientIP..."
    $session = New-SSHSession -ComputerName $clientIP -Credential $credential -ConnectionTimeout 5 -ErrorAction SilentlyContinue
    if ($session) {
      Write-Host "[Succès] Connexion réussie !" -ForegroundColor Green
    } else {
      throw "$clientIP"
    }
} catch {
    Write-Host "[Erreur] Echec de la connexion à : $_" -ForegroundColor Red
    exit 1
}


# Appel principal du script

while ($True) {
    Write-Host "====================================== `nAvec qui souhaitez-vous intéragir ?`n1 - Avec un utilisateur`n2 - Avec un ordinateur"
    Add-LogEntry -user $Name -event "Demande du choix de la cible"
   $targetChoice = Read-Host "Tapez votre choix"
    menuMain

    # Si la cible est un utilisateur
    If ($targetChoice -eq 1) {
        $Name = IdUser
        Add-LogEntry -user $Name -event "Demande d'identifiant"
        ActionsUser
    }
    # Si la cible est un ordinateur
    elseif ($targetChoice -eq 2) {
        $Identifiant=IdOrdi
        ActionsOrdinateur
        } else {
        Write-Host "Choix invalide, veuillez réessayer" -ForegroundColor Red
    Add-LogEntry -user $Name -event "Choix invalide pour l'ordinateur"
    }
}

# Fermer la session à la fin
Remove-SSHSession -SessionId $session.SessionId    