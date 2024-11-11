# Guide Utilisateur

Voici le mode d'emploi utilisateur afin que vous puissiez exécuter le script, effectuer des actions ou encore récupérer des informations sur une machine cliente distante.

Vous avez un script `bashScript.sh` qui s'exécutera sous la machine Serveur Debian vers la machine cliente Ubuntu.
Vous avez un script `powershScript.ps1` qui s'exécutera sous la machine Serveur Windows Server vers la machine cliente Windows 10.

Nous avons créé un arborescence des possibilités de nos scripts pour plus de compréhension et de visibilité.
Lors de l'exécution de nos scripts, voici ce qui va vous être proposé :

<P ALIGN="center"><IMG src="Captures d'écran USERGUIDE\Capture d'écran 2024-11-11 151650.png" width=600></P>

Pour exécuter les différents scripts, voici la marche à suivre :

- Sur le serveur Debian 12, ouvrez votre terminal bash en tant qu'administrateur et entrez la commande:

```bash
root@SRVWIN01:<chemin_absolu_du_script> ./bashScript.sh
```

- Sur le serveur Windows Server, ouvrez votre terminal powershell en tant qu'administrateur et entrez la commande suivante:

```
PS <chemin_absolu_du_script> .\powershScript.ps1
```

Le mot de passe de la machine client va alors être demandé pour une connexion SSH sécurisée entre votre machine serveur et machine client. Entrez donc : `Azerty1*`

## FAQ
