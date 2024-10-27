# Guide Aministrateur

## Pré-Requis techniques

## Etapes d'installation et de configuration

### Installation et connexion SSH sous Windows

#### Installation

**Côté Client - Windows 10**

1. Installation de OpenSSH Server

C'est le client qui doit avoir OpenSSH Server pour pouvoir accepter les connexions SSH et recevoir les commandes à exécuter. Le serveur n'a besoin que d'OpenSSH Client pour se connecter au client et envoyer les instructions pour exécuter le script.

- Aller dans _Paramètres_ --> _Applications_ --> _Fonctionnalités facultatives_ --> _Ajouter une fonctionnalité_ --> dans la barre de recherche, écrire "serveur openssh"

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-10-26 175746.png" width=600></P>

- Cocher l'application trouvée puis cliquer sur _Installer (1)_
- Patienter quelques instants, le temps de l'installation.

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-10-26 180012.png" width=600></P>

2. Démarrer et Activer le Service OpenSSH

- Ouvrir les _Services_
- Trouver le service _OpenSSH SSH Server_
- Faire un clic droit
- Cliquer sur _Démarrer_

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-10-26 180211.png" width=600></P>

Pour un démarrage automatique, refaire un clic droit et choisir _Propriétés_ --> dans _Type de démarrage_, choisir _Automatique_ puis valider.

**Côté Serveur - Windows Server**

Vérifier que OpenSSH Client est bien installé sur votre machine Windows Server avec cette commande. Vous devriez avoir ce résultat :

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-10-26 161114.png" width=600></P>

S'il n'est pas installé, il est possible de procéder à l'installation.
Entrez cette commande dans PowerShell :

```
Add-WindowsCapability -Online -Name OpenSSH.Client
```

#### Connexion

1. S'assurer que le service OpenSSH Server est installé et actif sur le client. Pour vérifier et démarrer le service si nécessaire, exécuter les commandes suivantes dans PowerShell en tant qu'administrateur :

```
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
```

2. Vérifier que le Serveur SSH accepte les connexions par mot de Passe, taper cette commande :

```
notepad C:\ProgramData\ssh\sshd_config
```

3. Assurez-vous que les lignes suivantes sont présentes et non commentées (elles ne doivent pas commencer par #) :

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-10-26 172347.png" width=600></P>

4. Enregistrer le fichier, puis redémarre le service pour appliquer les changements :

```
Restart-Service sshd
```

5. Ajouter une règle de pare-feu pour permettre les connexions SSH, rentrer la commande suivante :

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-10-26 182505.png" width=600></P>

6. Sur le serveur, lancer le script :

```
powershell -ExecutionPolicy Bypass -File "C:\Users\Administrator\Desktop\Scripts\scriptWin.ps1"
```

## FAQ
