Clear-Host

#Importation du module Posh-SSH
Import-Module Posh-SSH

# Définition des fonctions

function MenuPrincipal {
    Switch ($choix) {
        1 { Write-Host "CIBLE UTILISATEUR" }
        2 { Write-Host "CIBLE ORDINATEUR" }
        3 { Write-Host "Quitter" }
        default { Write-Host "Choix invalide" }
    }
}

function Identifiant {
    Write-Host "Quel est votre identifiant?"
    $Name = Read-Host "Tapez votre choix"
}

function TroisiemeChoix {
    Switch ($actions) {
        1 { Write-Host "Choix utilisateur validé" }
        2 { Write-Host "Choix ordinateur validé" }
        default { Write-Host "Choix invalide" }
    }
}

function Supprimer {
    Write-Host "Suppression du compte (oui/non)"
    $delete = Read-Host "Tapez votre choix"
    if ($delete -eq "oui") {
        Invoke-SSHCommand -SessionId $session.SessionId -Command "Remove-LocalUser -Name '$Name'"
    } else {
        Pop-Location
    }
}

function Modifier {
Write-host "Que souhaitez-vous modifier?`n1-Modifier votre nom`n2-Modifier votre mot de passe"
$modif=Read-host
   Switch ($modif) {
    1 {Rename-localuser $Name}
    2 {write-host "Indiquez le nouveau mot de passe"
            $mdp=read-host -AsSecureString
            Set-LocalUser -Name "$Name" -Password (ConvertTo-SecureString "$mdp" -AsPlainText -Force)}  

    default {Write-Host "Choix invalide"}
 
    }      
   
}

function Infos {
Write-Host "Quelles informations souhaitez-vous afficher?`n1-Nom d'utilisateur`n2-Date de derniÃ¨re connexion`n3-SID`n4-Retour"
$choixinfos=read-host

  Switch ($choixinfos) {
 
 1 {Invoke-SSHCommand -SessionId $session.SessionId -Command "Get-localUser | where-object { $_.Name -like "$Name" }"}
 2 {Invoke-SSHCommand -SessionId $session.SessionId -Command "get-localuser -name "$Name"| Select-Object lastlogon"}
      3 {Invoke-SSHCommand -SessionId $session.SessionId -Command "Get-Localuser -name "$Name"| Select-Object SID"}
      4 {Pop-Location}  
     
   }
   Exit #obligé de sortir du script pour afficher les infos
}

function Choixdesactions {
    Switch ($action) {
        1 { Modifier }
        2 { Supprimer }
        3 { Write-Host "Quelles informations souhaitez-vous afficher?`n1-Nom d'utilisateur`n2-Date de dernière connexion`n3-Droits d'accès`n4-Vos groupes`n5-ID`n6-Retour" }
        default { Write-Host "choix invalide" }
    }
}

function IdOrdi {
    Write-Host "==============================`nQuel est votre identifiant ?"
    $Identifiant = Read-Host "Entrer le nom de l'hôte client ou son adresse IP "

    #Tant que l'dentifiant est incorrect, redemander l'identifiant
    While (-not (Test-Connection -ComputerName $Identifiant -Count 1 -Quiet)) {
        Write-Host "[Erreur] Identifiant incorrect. Veuillez réessayer" -ForegroundColor Red
        $Identifiant = Read-Host "Entrer le nom de l'hôte ou son adresse IP "
        }
        Write-Host "[Succès] Identifiant correct. L'ordinateur a été trouvé." -ForegroundColor Green
        return $Identifiant          
}

function GetInfoSyst {
    Write-Host "==============================================`nQuelles informations souhaitez-vous récupérer? `n1 - Nom de l'hôte`n2 - Système d'exploitation et sa version`n3 - Adresse IP`n4 - Nombres d'utilisateurs`n5 - Retour au menu précédent`n6 - Quitter"
    $recupOrdiInfo = Read-Host "Tapez votre choix"

    Switch ($recupOrdiInfo) {
        1 {
            $hostname = Invoke-SSHCommand -SessionId $session.SessionId -Command "hostname"
            Write-Host "====================================" -ForegroundColor Cyan
            Write-Host "|     Nom de l'hôte : $($hostname.Output.Trim())     |" -ForegroundColor Cyan
            Write-Host "====================================" -ForegroundColor Cyan
            GetInfoSyst
        }
        2 {
            $os = Invoke-SSHCommand -SessionId $session.SessionId -Command "wmic os get Caption"
            $version = Invoke-SSHCommand -SessionId $session.SessionId -Command "wmic os get Version"
            Write-Host "=====================================" -ForegroundColor Cyan
            Write-Host " $($os.Output) " -ForegroundColor Cyan
            Write-Host " $($version.Output)" -ForegroundColor Cyan
            Write-Host "=====================================" -ForegroundColor Cyan          
            GetInfoSyst
        }
        3 {
            $ipAddresses = Invoke-SSHCommand -SessionId $session.SessionId -Command "ipconfig | findstr IPv4"
            foreach ($ip in $ipAddresses.Output) {
              Write-Host "=========================================================================" -ForegroundColor Cyan
              Write-Host " |  Adresse IP : $ip   |" -ForegroundColor Cyan
              Write-Host "=========================================================================" -ForegroundColor Cyan
              }
            GetInfoSyst
        }
        4 {
            $utilisateurs = Invoke-SSHCommand -SessionId $session.SessionId -Command "Get-LocalUser"
            $nombreUtilisateurs = $utilisateurs.Output.Count
            Write-Host "========================================" -ForegroundColor Cyan
            Write-Host "|   Nombre total d'utilisateurs : $nombreUtilisateurs   |" -ForegroundColor Cyan
            Write-Host "========================================" -ForegroundColor Cyan
            GetInfoSyst
        }
        5 { ActionsOrdinateur }
        6 {
        Write-Host "==================================" -ForegroundColor Cyan
        Write-Host "|    Fermeture... Au revoir!    |" -ForegroundColor Cyan
        Write-Host "==================================" -ForegroundColor Cyan;
        exit }
        default {
            Write-Host "Choix invalide"
            return GetInfoSyst
        }
    }
}

function ActionsOrdinateur {
    Write-Host "===========================================`nQue souhaitez-vous faire avec l'ordinateur ?`n1 - Eteindre l'ordinateur`n2 - Redémarrer l'ordinateur`n3 - Récupérer des informations`n4 - Retour au menu précédent`n5 - Quitter"
    $actionOrdi = Read-Host "Tapez votre choix"

    Switch ($actionOrdi) {
        1 {
            Invoke-SSHCommand -SessionId $session.SessionId -Command "Shutdown /s /f /t 0"
            Write-Host "Extinction de l'ordinateur..."
        }
        2 {
            Invoke-SSHCommand -SessionId $session.SessionId -Command "Shutdown /r /f /t 0"
            Write-Host "Redémarrage de l'ordinateur..."
        }
        3 { GetInfoSyst }
        4 {
            Write-Host "Retour au menu précédent"
            return MenuPrincipal
        }
        5 {
            Write-Host "Fermeture... Au revoir!"
            exit
        }
        default {
            Write-Host "Choix invalide"
            return MenuPrincipal
        }
    }
}

# Connexion à l'hôte distant avec SSH
$username = "wilder"
$clientIP = "10.2.0.14"

# Demander le mot de passe de l'utilisateur
$password = Read-Host -AsSecureString "========================================`nEntrez le mot de passe du client $username `n======================================="

#Créer un objet PSCredential
$credential=New-Object System.Management.Automation.PSCredential($username, $password)

# Créer une session SSH
try {
    Write-Host "Tentative de connexion SSH à $clientIP..."
    $session = New-SSHSession -ComputerName $clientIP -Credential $credential -ConnectionTimeout 15
    Write-Host "[Succès] Connexion réussie !" -ForegroundColor Green
} catch {
    Write-Host "[Erreur] Echec de la connexion à : $_" -ForegroundColor Red
}


# Appel principal du script

while ($True) {
    Write-Host "====================================== `nAvec qui souhaitez-vous intéragir ?`n1 - Avec un utilisateur`n2 - Avec un ordinateur"
    $choix = Read-Host "Tapez votre choix"
    MenuPrincipal

    # Si la cible est un utilisateur
    If ($choix -eq 1) {
        Write-Host "====================================== `nQuel est votre identifiant ?"
        $Name = Read-Host

        # Si l'utilisateur est identifié
        If (Invoke-SSHCommand -SessionId $session.SessionId -Command "Get-LocalUser | Where-Object { \$_.Name -eq '$Name' }") {
            Write-Host "Utilisateur valide"
            Write-Host "Quelles actions souhaitez-vous effectuer?"
            Write-Host "1- Modifier votre compte`n2- Supprimer votre compte`n3- Afficher les informations du compte"

            # Récupération du choix de l'utilisateur
            $action = Read-Host
            Write-Host "Choix $action validé"

            # Exécuter la fonction en fonction du choix
            Choixdesactions
        } else {
            Write-Host "Cet utilisateur est inconnu"
            Write-Host "Souhaitez-vous le créer? (oui/non)"
            $Response = Read-Host

            If ($Response -eq "oui") {
                Invoke-SSHCommand -SessionId $session.SessionId -Command "New-LocalUser -Name '$Name'"
            } else {
                Write-Host "Que souhaitez-vous faire?`n1- Repréciser votre identifiant`n2- Quitter"
                $choix2 = Read-Host

                Switch ($choix2) {
                    1 { Identifiant }
                    2 { exit }
                    default { Write-Host "Choix invalide" }
                }
            }
        }
    }
    # Si la cible est un ordinateur
    elseif ($choix -eq 2) {
        $Identifiant=IdOrdi
        ActionsOrdinateur
        } else {
        Write-Host "Choix invalide, veuillez réessayer" -ForegroundColor Red
    }
}

# Fermer la session à la fin
Remove-SSHSession -SessionId $session.SessionId