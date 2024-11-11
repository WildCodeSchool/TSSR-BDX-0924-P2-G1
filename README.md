# Documentation Générale

## Mise en contexte

Dans le cadre de notre projet 2 au sein de la Wild Code School, nous avons pour objectif principal d'exécuter un script présent sur un serveur afin qu'il intéragisse, propose des actions à l'utilisateur et récupère des informations sur un client, qu'il soit un utilisateur ou un ordinateur.

## Présentation du projet et objectifs

Le projet consiste donc à créer un script qui s’exécute sur une machine et effectue des tâches sur des machines distantes.
L’ensemble des machines sont sur le même réseau.
Les tâches sont des actions ou des requêtes d’informations. Pour un utilisateur, ces tâches peuvent être :

- Création de compte
- Suppression de compte
- Demandes d'informations telles que son nom, sa date de dernière connexion ou son ID
  Et pour un ordinateur, ces tâches peuvent être :
- Arrêter la machine
- Redémarrer la machine
- Demandes d'informations telles que son nom, son système d'exploitation, sa version ou encore son nombre d'utilisateurs

Deux scripts sont donc à fournir :

- Depuis une machine Windows Server, exécuter un script PowerShell qui cible des ordinateurs Windows
- Depuis une machine Debian, exécuter un script shell qui cible des ordinateurs Ubuntu

## Présentation de l'équipe, rôles par sprint

Le projet a suivi un processus de création selon la méthode **AGILE**. Cette méthode permet de rester flexible et de s’adapter aux changements. L’environnement de travail **SCRUM** a été utilisé pour cadrer et structurer le travail en équipe.

Notre organisation se basait sur une planification de sprint d’une semaine, durant laquelle un membre de l’équipe occupait l’un des deux rôles principaux :

**Scrum Master** : Il facilite le processus SCRUM en aidant à identifier et éliminer les obstacles, afin de maintenir la productivité de l’équipe. Il anime tous les matins les daily, qui permettent à chacun de s’exprimer librement sur des problématiques, l’avancée de leur travail, ou tout autre sujet pertinent dans le cadre du projet. Il anime aussi une rétrospective à la fin de la semaine pour faire un bilan du sprint.
**Product Owner** : Il se concentre sur la gestion du contenu produit. Il priorise les besoins du client et décide des nouvelles fonctionnalités à développer par sprint. C’est lui qui remplit le Trello par sprint et affecte les différents tickets.

### Membres de l'équipe :

- _Mindy Setham_ : Semaine 1 Product-Owner/ Semaine 2 Technicienne / Semaine 3 Technicienne / Semaine 4 Scrum-Master
- _Frédérique Druet_ : Semaine 1 Scrum-Master / Semaine 2 Product-Owner / Semaine 3 Scrum-Master/ Semaine 4 Technicienne
- _Hamza Malki_ : Semaine 1 Technicien / Semaine 2 Scrum-Master / Semaine 3 Product-Owner / Semaine 4 Product-Owner

## Choix techniques

### Serveurs

| **Système**  | **Debian 12.5** | **Windows Server 2022** |
| ------------ | --------------- | ----------------------- |
| **HostName** | SRVLX01         | SRVWIN01                |
| **Login**    | sysadmin        | administrator           |
| **Password** | Azerty1\*       | Azerty1\*               |
| **IP Fixe**  | 172.16.10.46/24 | 172.16.10.40/24         |

### Clients

| **Système**  | **Ubuntu 22.04 LTS 01** | **Windows 10**  |
| ------------ | ----------------------- | --------------- |
| **HostName** | CLILIN01                | CLIWIN01        |
| **Login**    | wilder                  | wilder          |
| **Password** | Azerty1\*               | Azerty1\*       |
| **IP Fixe**  | 172.16.10.45/24         | 172.16.10.43/24 |

## Difficultés rencontrées : problèmes techniques rencontrés
- **Semaine 1** :
   Au cours de la première semaine, il n'y a eu aucun problème notoire, à l'exception de l'installation de la machine serveur Windows,
   qui a nécessité beaucoup de temps.
- **semaine 2** :
   Créez un script Bash qui suit l'arborescence et la structure initiale, capable d'afficher les différents menus et sous-menus
   tout en permettant d'effectuer diverses actions et de demander des informations selon le choix de la machine.
   Établir la connexion ssh entre les machines virtuelles
- **semaine 3** :
   on'a toujours pas réussi a etablir la connexion entre les machines
   Le script bash est toujours en cours de développement mais ne s'exécute pas sur des machines distantes.
- **Semaine 4** :
## Solutions trouvées

- **Semaine 1** :

- **Semaine 2** :
  Nous avons réussi à rédiger une premiére partie du script en suivant le plan de l'arborescence, étape par étape,
  et concernant l'affichage des menus et sous-menus On a utilisé la fonction "switch...case" pour régler le problème.
- **Semaine 3** 
- **Semaine 4**


## Améliorations possibles
