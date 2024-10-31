#!/bin/bash

# Menu principal pour choisir entre utilisateur et ordinateur
echo "Avec qui souhaitez-vous interagir?"
echo "1. Utilisateur"
echo "2. Ordinateur"
read -p "Entrez votre choix (1-2) : " choix_principal

case $choix_principal in
  1)
    # Menu d'interaction avec l'utilisateur
    echo "Quel est votre identifiant?"
    read -p "Entrez l'identifiant : " user_id
    if id "$user_id" &>/dev/null; then
      echo "Quelle action souhaitez-vous effectuer?"
      echo "1. Modifier le compte"
      echo "2. Supprimer le compte"
      echo "3. Afficher les informations du compte"
      read -p "Entrez votre choix (1-3) : " action_utilisateur

      case $action_utilisateur in
        1)
          echo "Modifier le compte"
          echo "1. Modifier le nom"
          echo "2. Modifier le mot de passe"
          read -p "Entrez votre choix (1-2) : " modifier_action
          case $modifier_action in
            1)
              read -p "Entrez le nouveau nom : " new_name
              sudo usermod -l "$new_name" "$user_id"
              ;;
            2)
              read -p "Entrez le nouveau mot de passe : " new_password
              echo "$user_id:$new_password" | sudo chpasswd
              ;;
            *)
              echo "Choix invalide"
              ;;
          esac
          ;;
        2)
          read -p "Confirmez-vous la suppression du compte? (yes/no) : " confirm
          if [ "$confirm" == "yes" ]; then
            sudo userdel -r "$user_id"
            echo "L'utilisateur $user_id a été supprimé."
          else
            echo "Suppression annulée."
          fi
          ;;
        3)
          echo "Quelles informations souhaitez-vous afficher? (Tapez vos choix)"
          echo "1. Nom d'utilisateur"
          echo "2. Date de dernière connexion"
          echo "3. Droits d'accès"
          echo "4. Groupes"
          echo "5. ID"
          read -p "Entrez vos choix séparés par des espaces : " info_choices
          for choice in $info_choices; do
            case $choice in
              1) id -un "$user_id" ;;
              2) lastlog -u "$user_id" ;;
              3) id -G "$user_id" ;;
              4) id -Gn "$user_id" ;;
              5) id -u "$user_id" ;;
              *) echo "Choix invalide" ;;
            esac
          done
          ;;
        *)
          echo "Choix invalide"
          ;;
      esac
    else
      echo "L'utilisateur $user_id n'existe pas."
      read -p "Souhaitez-vous le créer? (yes/no) : " create_user
      if [ "$create_user" == "yes" ]; then
        read -p "Entrez le nom de l'utilisateur à créer : " new_user
        sudo adduser "$new_user"
        echo "L'utilisateur $new_user a été créé."
      else
        echo "Action annulée."
      fi
    fi
    ;;
  2)
    # Menu d'interaction avec l'ordinateur
    echo "Quel est votre identifiant? (nom complet ou adresse IP)"
    read -p "Entrez l'identifiant : " ordinateur_id
    if ping -c 1 "$ordinateur_id" &>/dev/null; then
      echo "Quelle action souhaitez-vous effectuer?"
      echo "1. Arrêter l'ordinateur"
      echo "2. Redémarrer l'ordinateur"
      echo "3. Afficher les informations système"
      read -p "Entrez votre choix (1-3) : " action_ordinateur

      case $action_ordinateur in
        1)
          ssh "$USER@$ordinateur_id" "sudo shutdown now"
          echo "L'ordinateur $ordinateur_id est en cours d'arrêt."
          ;;
        2)
          ssh "$USER@$ordinateur_id" "sudo reboot"
          echo "L'ordinateur $ordinateur_id est en cours de redémarrage."
          ;;
        3)
          ssh "$USER@$ordinateur_id" "hostname; uname -a"
          ;;
        *)
          echo "Choix invalide"
          ;;
      esac
    else
      echo "L'ordinateur $ordinateur_id n'est pas accessible."
    fi
    ;;
  *)
    echo "Choix invalide"
    exit 1
    ;;
esac
