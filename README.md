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

- _Mindy Setham_ : Semaine 1 Product-Owner
- _Frédérique Druet_ : Semaine 1 Scrum-Master
- _Hamza Malki_ : Semaine 1 Technicien

## Choix techniques

### Serveurs

| **Système**  | **Debian 12** | **Windows Server 2022** |
| ------------ | --------------- | ----------------------- |
| **HostName** | SRVLX01         | SRVWIN01                |
| **Login**    | sysadmin        | Administrator           |
| **Password** | Azerty1\*       | Azerty1\*               |
| **IP Fixe**  | 172.16.10.10/24 | 172.16.10.5/24         |

### Clients

| **Système**  | **Ubuntu 24.04 LTS** | **Windows 10**  |
| ------------ | ----------------------- | --------------- |
| **HostName** | CLILIN01                | CLIWIN01        |
| **Login**    | wilder                  | wilder          |
| **Password** | Azerty1\*               | Azerty1\*       |
| **IP Fixe**  | 172.16.10.30/24         | 172.16.10.20/24 |

## Difficultés rencontrées : problèmes techniques rencontrés

## Solutions trouvées

## Améliorations possibles
