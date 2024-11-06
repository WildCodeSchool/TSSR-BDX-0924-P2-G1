Clear-Host



# Définition des fonctions 

function PremierChoix {
  Switch ($choix) {
	  1 {Write-Host "Cible Utilisateur"}
	  2 {Write-Host "Cible ordinateur"}
    3 {Write-Host "Quitter"}
	  default {Write-Host "Choix invalide"} 
  }
}

function DeuxiemeChoix { 
  Write-Host "Quel est votre identifiant?"
  $Name=Read-host
}

function TroisiemeChoix {
  Switch ($actions) {
	  1 {Write-Host "Choix utilisateur validé"}
	  2 {Write-Host "Choix ordinateur validé"}
	  default {Write-Host "Choix invalide"} 
  }
}

function Supprimer { 
  Write-Host "Suppression du compte (oui/non)"
  $delete=read-host 
        if ($delete -eq "oui") {
        Remove-localuser -Name "$Name"
        } else {
        Pop-Location
        }     
}

function Modifier { 
  $modify=read-host 
  $delete=read-host 

    Switch ($modif) {
	     1 {Write-Host "Choix utilisateur validé"} #ATTENTION CETTE PARTIE
	     2 {Write-Host "Choix ordinateur validé"}
	     default {Write-Host "Choix invalide"} 
 
    }       
}

function ChoixQuatre {
  Switch ($action) {
	  1 {Modifier} 
	  2 {Supprimer}
    3 {Write-Host "Quelles informations souhaitez-vous afficher?`n1-Nom d'utilisateur`n2-Date de dernière connexion`n3-Droits d'accès`n4-Vos groupes`n5-ID`n6-Retour"} #MODIFER
	default {Write-Host "choix invalide"} 
   }
}

function GetInfoSyst {
  Write-Host "Quelles informations souhaitez-vous récupérer? (Tapez le numéro du/des choix séparés d'un espace)`n1 - Nom du serveur`n2 - Système d'exploitation et sa version`n3 - Adresse IP`n4 - Nombres d'utilisateurs`n5 - Retour au menu précédent`n6 - Quitter"
  $recupOrdiInfo = Read-Host

  Switch ($recupOrdiInfo) {
    1 { $hostname = $env:COMPUTERNAME
        Write-Host "Nom de l'hôte : $hostname" 
        GetInfoSyst }
    2 { $osInfo = Get-ComputerInfo
        Write-Host "Système d'exploitation : $($osInfo.WindowsVersion)"
        Write-Host "Version : $($osInfo.WindowsBuildLabEx)" 
        GetInfoSyst }
    3 { $ipAddresses = Get-NetIPAddress -AddressFamily IPv4
        foreach ($ip in $ipAddresses) {
          Write-Host "Adresse IP : $($ip.IPAddress)"} 
          GetInfoSyst }
    4 { $utilisateurs = Get-LocalUser
        $nombreUtilisateurs = $utilisateurs.Count
        Write-Host "Nombre total d'utilisateurs : $nombreUtilisateurs"
        GetInfoSyst }
    5 { ActionsOrdinateur }
    6 { Write-Host "Fermeture... Au revoir!"
        exit }
    default { Write-Host "Choix invalide" 
        return GetInfoSyst }
  }
}
function ActionsOrdinateur {
  Write-Host "Que souhaitez-vous faire avec l'ordinateur ?`n1 - Eteindre l'ordinateur`n2 - Redémarrer l'ordinateur`n3 - Récupérer des informations`n4 - Retour au menu précédent`n5 - Quitter"
  $actionOrdi = Read-Host

  Switch ($actionOrdi) {
    1 { Write-Host "Extinction de l'ordinateur..."
    Shutdown-Computer -Force }
    2 { Write-Host "Redémarrage de l'ordinateur..." 
    Restart-Computer -Force }
    3 { GetInfoSyst }
    4 { Write-Host "Retour au menu précédent"
        return PremierChoix }
    5 { Write-Host "Fermeture... Au revoir!"
        exit }
    default { Write-Host "Choix invalide" 
        return PremierChoix }
  }
}

# Appel principal du script

while($True) {
  Write-host "Avec qui souhaitez-vous intéragir ?`n1 - Avec un utilisateur`n2 - Avec un ordinateur"
  $choix=Read-Host
  PremierChoix


  #Si la cible est un utilisateur
  If ($choix -eq 1) { 
    Write-Host "Quel est votre identifiant?"
    $Name=Read-host

    # Si l'utilisateur est identifié
    If (Get-LocalUser | select-string -Pattern $Name) {            #Where-Object { $_.Name -like $Name }
      Write-host "Utilisateur valide"
      Write-host "Quelles actions souhaitez-vous effectuer?"
      write-host "1- Modifier votre compte`n2- Supprimer votre compte`n3- Afficher les informations du compte"

      #Récupération du choix de l'utilisateur
      $action = Read-Host
      Write-Host "Choix $action validé"

      #Exécuter la fonction en fonction du choix
      ChoixQuatre

    } else {
      write-host "Cet utilisateur est inconnu"
      write-host "Souhaitez-vous le créer? (oui/non)"
      $Response=Read-host

      If ($Response -eq "oui") {
        New-localuser
      } else {
        write-host "Que souhaitez vous faire?`n1- Repréciser votre identifiant`n2- Quitter"
        $choix2=read-host

        Switch ($choix2) {
	        1 {DeuxiemeChoix}
	        2 {exit}
	        default {Write-Host "Choix invalide"} 
        }
      }
    }
  }
  #Si la cible est un ordinateur
  elseif ($choix -eq 2) {
    Write-Host "Quel est votre identifiant? (Entrez le nom de l'hôte ou l'adresse IP de votre machine)"
    $Identifiant = Read-Host

    #Si l'ordinateur est identifié
    If (Test-Connection -ComputerName $Identifiant -Count 1 -Quiet) {            
    Write-Host "Identifiant correct. L'ordinateur a été trouvé."
    ActionsOrdinateur
    } else {
    Write-Host "Identifiant incorrect, veuillez réessayer"
    DeuxiemeChoix
    }
  } else {
    Write-Host "Choix invalide, veuillez réessayer"

  }

} # Fin boucle While True