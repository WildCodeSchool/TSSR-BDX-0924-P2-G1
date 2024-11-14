==========================
# Guide Utilisateur
==========================

Voici le mode d'emploi utilisateur afin que vous puissiez exécuter le script, effectuer des actions ou encore récupérer des informations sur une machine cliente distante.

Vous avez un script `bashScript.sh` qui s'exécutera sous la machine Serveur Debian vers la machine cliente Ubuntu.
Vous avez un script `powershScript.ps1` qui s'exécutera sous la machine Serveur Windows Server vers la machine cliente Windows 10.

Nous avons créé un arborescence des possibilités de nos scripts pour plus de compréhension et de visibilité.
Lors de l'exécution de nos scripts, voici ce qui va vous être proposé :

<P ALIGN="center"><IMG src="Captures d'écran USERGUIDE\Capture d'écran 2024-11-11 151650.png" width=1100></P>

Pour exécuter les différents scripts, voici la marche à suivre :

- Sur le serveur Debian 12, ouvrez votre terminal bash en tant qu'administrateur et entrez la commande:

```bash
root@SRVWIN01:<chemin_absolu_du_script> ./bashScript.sh
```

1. Le nom d'utilisateur de la machine cliente va vous être demandé, rentrer : `wilder`
2. L'adresse IP de la machine cliente va vous être demandé, rentrer : `172.16.10.30`
3. Le mot de passe de la machine cliente va alors être demandé pour une connexion SSH sécurisée entre votre machine serveur et machine client. Entrez donc : `Azerty1*`
4. Bonne navigation !!

- Sur le serveur Windows Server, ouvrez votre terminal powershell en tant qu'administrateur et entrez la commande suivante:

```
PS <chemin_absolu_du_script> .\powershScript.ps1
```

1. Le nom d'utilisateur de la machine cliente va vous être demandé, rentrer : `wilder`
2. L'adresse IP de la machine cliente va vous être demandé, rentrer : `172.16.10.20`
3. Le mot de passe de la machine cliente va alors être demandé pour une connexion SSH sécurisée entre votre machine serveur et machine client. Entrez donc : `Azerty1*`
4. Bonne navigation !!

## FAQ : Solutions aux problèmes connus et communs liés à l'installation

**_Question : J'ai une erreur lorsque j'essaie de me connecter en SSH_**<br>
Réponse : Vérifiez bien les différentes données rentrées aux 3 premières question : le nom de l'**utilisateur**, l'**adresse IP**, et le **mot de passe de l'utilisateur**. A noter que pour qu'une connexion SSH soit effectiveet confirmée, la machine client doit être à minima allumée.

**_Question : J'ai une erreur lorsque que je rentre mon identifiant après avoir validé ma cible utilisateur ou ordinateur_**<br>
Réponse : Après votre choix d'intéraction avec l'utilisateur, on vous demande votre identifiant. Saisissez bien votre **nom d'utilisateur**, c'est- à dire `wilder`. Si vous choisissez d'intéragir avec un ordinateur, il vous sera demandé le **nom de l'hôte**, c'est-à dire `cliwin01`.

**_Question : Je ne trouve pas le fichier qui liste toutes les informations que j'ai récupérées dans le script_**<br>
Réponse : Le fichier qui centralise les informations demandées lors de l'exécution du script se situe dans le dossier ** Documents** du compte utilisateur du serveur. Le chemin absolu est celui-ci : `C:\Users\Administrators\Documents`
