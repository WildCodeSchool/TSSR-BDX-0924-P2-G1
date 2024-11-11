# Guide Aministrateur

## Pré-Requis techniques

**Récapitulatif**
| **Système** | **Server Debian 12** | **Client Ubuntu 24.04 LTS** |
| ------------ | --------------- | ----------------------- |
| **Nom de l'hôte** | SRVLX01 | CLILIN01 |
| **Login** | sysadmin | wilder |
| **Mot de passe** | Azerty1\* | Azerty1\* |
| **IP Fixe** | 172.16.10.10/24 | 172.16.10.30/24 |

| **Système**       | **Windows Server** | **Windows 10**  |
| ----------------- | ------------------ | --------------- |
| **Nom de l'hôte** | SRVWIN01           | CLIWIN01        |
| **Login**         | Administrator      | wilder          |
| **Mot de passe**  | Azerty1\*          | Azerty1\*       |
| **IP Fixe**       | 172.16.10.5/24     | 172.16.10.20/24 |

## Etapes d'installation et de configuration

### Linux

#### Debian Server

**Configurer le nom de l'hôte**

1. Ouvrir le terminal et tapez la commande :

```bash
sudo nano /etc/hostname
```

Remplacer l'ancien nom par **SRVLX01**

2. Taper la commande

```bash
sudo nano /etc/hosts
```

Remplacer l'ancien nom par **SRVLX01**

3. Redémarrer le système pour appliquer le changement avec :

```bash
sudo systemctl restart systemd-logind.service
```

**Configurer le nom de l'utilisateur**
Ouvrir le terminal et tapez la commande :

```bash
sudo usermod -l <sysadmin> <ancien_nom>
```

**Configurer le mot de passe de l'utilisateur**
Pour changer le mot de passe de l'utilisateur actuel, ouvrir le terminal et tapez la commande :

```bash
passwd
```

Vous serez invités à entrer votre mot de passe actuel et à rentrer le nouveau : "Azerty1\*"

**Configurer l'adresse IP fixe**

1. Editer le fichier de configuration _netplan_ :

```bash
sudo nano /etc/network/interfaces
```

2. Rajouter les lignes ci après avec l'adresse IP prévue, "172.16.10.10/24" et sa _gateway_

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-11-06 182536.png" width=500></P>

Faire CTRL+X afin de sauvegarder puis quitter. Redémarrer ensuite le service réseau pour que les modifications soient prises en compte :

```bash
sudo systemctl restart network
```

#### Ubuntu

**Configurer le nom de l'hôte**

1. Ouvrir le terminal et tapez la commande :

```bash
sudo nano /etc/hostname
```

Remplacer l'ancien nom par **CLILIN01**

2. Taper la commande

```bash
sudo nano /etc/hosts
```

Remplacer l'ancien nom par **CLILIN01**

3. Redémarrer le système pour appliquer le changement avec :

```bash
sudo systemctl restart systemd-logind.service
```

**Configurer le nom de l'utilisateur**
Ouvrir le terminal et tapez la commande :

```bash
sudo usermod -l <wilder> <ancien_nom>
```

**Configurer le mot de passe de l'utilisateur**
Pour changer le mot de passe de l'utilisateur actuel, ouvrir le terminal et tapez la commande :

```bash
passwd
```

Vous serez invités à entrer votre mot de passe actuel et à rentrer le nouveau : "Azerty1\*"

**Configurer l'adresse IP fixe**

1. Editer le fichier de configuration _netplan_ :

```bash
sudo nano /etc/netplan/50-cloud-init.yaml
```

2. Remplacer la ligne _addresses_ avec l'adresse IP prévue, "172.16.10.30/24" avec la _gateway_

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-11-06 180732.png" width=500></P>

Faire CTRL+X afin de sauvegarder puis quitter. Redémarrer ensuite le service réseau pour que les modifications soient prises en compte :

```bash
sudo systemctl restart network
```

### Windows

#### Windows Server

**Configurer le nom de l'hôte**

1. Aller dans _Control Panel_ ---> _System and Security_
2. Cliquer sur _System_ puis sur _Rename this PC_

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-11-06 150909.png" width=600></P>

3. Entrer le nom du PC "SERVWIN01" puis cliquer sur _Next_
   Il est possible que l'on vous demande de rédémarrer votre PC pour la modification soit prise en compte.

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-11-06 151447.png" width=600></P>

**Configurer le nom de l'utilisateur et son mot de passe**

1. Aller dans _Control Panel_ ---> _System and Security_
2. Cliquer sur _Administrative Tools_ --->_Computer Management_ --->_Local Users and Groups_ ---> _Users_
3. Clic-droit que l'utilisateur à modifier, sélectionner _Rename_, "SRVWIN01", ou _Set Password..._, "Azerty1\*", en fonction de l'action que vous souhaitez effectuer, comme ci-dessus :

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-11-06 154215.png" width=600></P>

**Configurer l'adresse IP fixe**

1. Dans la barre de recherche de Windows, écrire la commande _ncpa.cpl_
2. Clic-droit sur _Ethernet_, sélectionner _Properties_
3. Ouvrir *Internet Protocol Version 4 (TCP/IPv4) puis sélectionner *Use the following IP address\* et rentrer l'adresse IP :

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-11-06 155322.png" width=600></P>

#### Windows 10

**Configurer le nom de l'hôte**

1. Aller dans _Panneau de configuration_ ---> _Systèmes et Sécurité_ ---> _Système_
2. CLiquer sur _Renommer ce PC_

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-11-06 155626.png" width=600></P>

3. Entrer le nom de l'hôte : "CLIWIN01" puis valider.
   Il est possible que l'on vous demande de rédémarrer votre PC pour la modification soit prise en compte.

**Configurer le nom de l'utilisateur**

1. Aller dans _Panneau de configuration_ ---> _Comptes d'utilisateurs_ ---> _Comptes d'utilisateurs_ ---> _Modifier votre nom de compte_

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-11-06 160429.png" width=600></P>

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-11-06 160429.png" width=600></P>

2. Une fois le nouveau nom _wilder_ précisé, valider en cliquant sur _Changer le nom_.

**Configurer le mot de passe de l'utilisateur**

1. Aller dans _Paramètres_ ---> _Comptes_ ---> _Options de connexion_ dans le menu à gauche
2. CLiquer sur _Mot de passe_ ---> _Modifier_

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-11-06 161130.png" width=600></P>

3. Rentrer votre mot de passe actuel, puis préciser le nouveau mot de passe : "Azerty1\*", valider le changement.

**Configurer l'adresse IP fixe**

1. Aller dans _Paramètres_ ---> _Réseau et Internet_ ---> _Propriétés_

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-11-06 161717.png" width=600></P>

2. Cliquer sur _Modifier_ dans les parmaètres IP

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-11-06 161823.png" width=600></P>

3. Cliquer sur _Manuel_ et entrer l'adresse IP : **172.16.10.20**

<P ALIGN="center"><IMG src="Captures d'écran INSTALL\Capture d'écran 2024-11-06 161958.png" width=600></P>

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

### Installation et connexion SSH sous Linux

**Côté Client - Ubuntu**

1. Mettre à jour les paquets

```bash
sudo apt update
```

2. Installer OpenSSH Server

```bash
sudo apt install openssh-server -y
```

3. Vérifier que le service SSH est bien activé et en cours d'exécution :

```bash
sudo systemctl status ssh
```

Si le service n'est pas en cours d'exécution, démarrez-le avec la commande :

```bash
sudo systemctl start ssh
```

Pour s'assurer qu'il démarre automatiquement au démarrage du système :

```bash
sudo systemctl enable ssh
```

#### Connexion

**Côté Serveur - Debian**

1. Se connecter avec la commande dans votre terminal :

```bash
ssh wilder@172.16.10.30
```

## FAQ
