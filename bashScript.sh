echo ==============================================================Scripte-bash=============================================================
echo ===============================================bienvenu veuillez entrer vos information================================================

# Définition des variables globales
CLIENT_IP="10.2.0.15"
REMOTE_USER="wilder"
REMOTE_PASSWORD=""
IP="10.2.0.15"
User="wilder"
MDPASS="Azerty1*"

LOG_FILE="/home/sysadmin/projet2/script-bash.log"

# Vérifier si le fichier de journalisation existe, sinon le créer
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

# Fonction de journalisation
log_message() {
    local log_level="$1"  # Niveau de journalisation (INFO, WARN, ERROR, etc.)
    local log_message="$2"  # Message de journalisation

    local current_time=$(date '+%Y%m%d-%H%M%S')
    local current_user=$(whoami)

    # Formater et écrire le message dans le fichier de journalisation
    echo "$current_time-$current_user-$log_message" >> "$LOG_FILE"
}

# Fonction pour afficher le journal
show_log() {
    echo "Affichage du journal :"
    cat "$LOG_FILE"
}

# Fonction pour enregistrer la dernière connexion
log_last_login() {
    local user="$1"
    log_message "INFO" "Dernière connexion de $user : $(date '+%Y-%m-%d %H:%M:%S')"
}

# Fonction pour redémarrer le serveur distant
computer_reboot(){
    echo "[Reboot] Redémarrage de l'ordinateur $CLIENT_IP"
    log_message "INFO" "Redémarrage de l'ordinateur $CLIENT_IP"
    sshpass -p "$REMOTE_PASSWORD" ssh -t "$REMOTE_USER@$CLIENT_IP" "echo $REMOTE_PASSWORD | sudo -S shutdown -r now"
}

# Fonction pour arrêter le serveur distant
computer_shutdown(){
    echo "[Shutdown] Arrêt de l'ordinateur $CLIENT_IP"
    log_message "INFO" "Arrêt de l'ordinateur $CLIENT_IP"
    sshpass -p "$REMOTE_PASSWORD" ssh -t "$REMOTE_USER@$CLIENT_IP" "echo $REMOTE_PASSWORD | sudo -S shutdown now"
}

# Fonction pour afficher le menu principal
function main_menu {
    echo "Avec qui souhaitez-vous interagir?"
    echo "1 - Utilisateur"
    echo "2 - Ordinateur"
    echo "3 - Quitter"
    read -p "Entrez votre choix : " choix

    case $choix in
        1)
            echo "Cible Utilisateur"
            users_action_menu
            ;;
        2)
            echo "Cible Ordinateur"
            computer_action_menu
            ;;
        3)
            echo "Quitter"
            log_message "INFO" "Script terminé par l'utilisateur"
            exit 0
            ;;
        *)
            echo "Choix invalide"
            main_menu
            ;;
    esac
}

# Fonction pour récupérer les informations d'authentification
function ask_user_params {
    read -p "Entrez l'adresse IP de l'ordinateur distant > " CLIENT_IP
    if [ $CLIENT_IP == $IP ]; then
        echo "adresse IP valide"
else
        echo "adresse invalide"
    exit 1
   
    fi
    read -p "Entrez le nom de l'utilisateur distant > " REMOTE_USER
   
    if [ $REMOTE_USER == $User ]; then
       echo "utilisateur valide"
    else
       echo "utilisateur invalide"
    fi

    read -s -p "Entrez le mot de passe de l'utilisateur distant > " REMOTE_PASSWORD
   
    if [ $REMOTE_PASSWORD == $MDPASS ]; then
    echo "connexion réussi"
else
    echo "mot de passe invalide"
   
    fi    
    log_last_login "$REMOTE_USER"
}

# Fonction pour créer un nouveau compte utilisateur
function create_user {
    read -p "Entrez le nom du nouvel utilisateur : " new_user
    read -s -p "Entrez le mot de passe pour le nouvel utilisateur : " new_password
    echo
    sshpass -p "$REMOTE_PASSWORD" ssh "$REMOTE_USER@$CLIENT_IP" "echo '$new_password' | sudo -S useradd $new_user"
    sshpass -p "$REMOTE_PASSWORD" ssh "$REMOTE_USER@$CLIENT_IP" "echo '$new_user:$new_password' | sudo -S chpasswd"
    echo "Utilisateur $new_user créé avec succès."
    log_message "INFO" "Utilisateur $new_user créé sur $CLIENT_IP"
    users_action_menu
}

# Fonction pour exécuter des actions sur l'utilisateur
function users_action_menu {
    echo "Quelles actions souhaitez-vous effectuer?"
    echo "1 - Créer un nouveau compte utilisateur"
    echo "2 - Modifier votre compte"
    echo "3 - Supprimer votre compte"
    echo "4 - Afficher les informations du compte"
    echo "5 - Retour"
    read -p "Entrez votre choix : " action

    case $action in
        1)
            create_user
            ;;
        2)
            modifier
            ;;
        3)
            supprimer
            ;;
        4)
            afficher_infos
            ;;
        5)
            main_menu
            ;;
        *)
            echo "Choix invalide"
            users_action_menu
            ;;
    esac
}

# Fonction pour modifier un compte utilisateur
function modifier {
    read -p "Entrez le nouveau nom : " new_name
    sshpass -p "$REMOTE_PASSWORD" ssh "$REMOTE_USER@$CLIENT_IP" "echo $REMOTE_PASSWORD | sudo -S usermod -l $new_name $REMOTE_USER"
    echo "Modification du compte effectuée"
    log_message "INFO" "Utilisateur $REMOTE_USER modifié en $new_name sur $CLIENT_IP"
    users_action_menu
}

# Fonction pour supprimer un compte utilisateur
function supprimer {
    read -p "Suppression du compte (oui/non)? " delete
    if [ "$delete" == "oui" ]; then
        sshpass -p "$REMOTE_PASSWORD" ssh "$REMOTE_USER@$CLIENT_IP" "echo $REMOTE_PASSWORD | sudo -S deluser $REMOTE_USER"
        echo "Suppression du compte effectuée"
        log_message "INFO" "Utilisateur $REMOTE_USER supprimé sur $CLIENT_IP"
    fi
    users_action_menu
}

# Fonction pour afficher les informations d'un compte utilisateur
function afficher_infos {
    sshpass -p "$REMOTE_PASSWORD" ssh "$REMOTE_USER@$CLIENT_IP" "id $REMOTE_USER"
    log_message "INFO" "Informations du compte $REMOTE_USER affichées sur $CLIENT_IP"
    users_action_menu
}

# Fonction pour récupérer les informations système
function get_info_syst {
    echo "Quelles informations souhaitez-vous récupérer? (Tapez le numéro du/des choix séparés d'un espace)"
    echo "1 - Nom du serveur"
    echo "2 - Système d'exploitation et sa version"
    echo "3 - Adresse IP"
    echo "4 - Nombre d'utilisateurs"
    echo "5 - Retour au menu précédent"
    echo "6 - Quitter"
    read -p "Tapez votre choix : " recupOrdiInfo

    case $recupOrdiInfo in
        1)
            hostname=$(sshpass -p "$REMOTE_PASSWORD" ssh "$REMOTE_USER@$CLIENT_IP" "hostname")
            echo "Nom de l'hôte : $hostname"
            log_message "INFO" "Nom de l'hôte récupéré : $hostname"
            get_info_syst
            ;;
        2)
            os_info=$(sshpass -p "$REMOTE_PASSWORD" ssh "$REMOTE_USER@$CLIENT_IP" "lsb_release -a")
            echo "$os_info"
            log_message "INFO" "Informations sur le système d'exploitation récupérées : $os_info"
            get_info_syst
            ;;
        3)
            ip_addresses=$(sshpass -p "$REMOTE_PASSWORD" ssh "$REMOTE_USER@$CLIENT_IP" "hostname -I")
            echo "Adresse IP : $ip_addresses"
            log_message "INFO" "Adresse IP récupérée : $ip_addresses"
            get_info_syst
            ;;
        4)
            utilisateurs=$(sshpass -p "$REMOTE_PASSWORD" ssh "$REMOTE_USER@$CLIENT_IP" "getent passwd | wc -l")
            echo "Nombre total d'utilisateurs : $utilisateurs"
            log_message "INFO" "Nombre total d'utilisateurs : $utilisateurs"
            get_info_syst
            ;;
        5)
            computer_action_menu
            ;;
        6)
            echo "Fermeture... Au revoir!"
            log_message "INFO" "Script terminé"
            exit 0
            ;;
        *)
            echo "Choix invalide"
            get_info_syst
            ;;
    esac
}

# Fonction pour exécuter des actions sur l'ordinateur
function computer_action_menu {
    echo "Que souhaitez-vous faire avec l'ordinateur ?"
    echo "1 - Eteindre l'ordinateur"
    echo "2 - Redémarrer l'ordinateur"
    echo "3 - Consulter le journal"
    echo "4 - Récupérer des informations"
    echo "5 - Retour au menu précédent"
    echo "6 - Quitter"
    read -p "Entrez votre choix : " actionOrdi

    case $actionOrdi in
        1)
            computer_shutdown
            ;;
        2)
            computer_reboot
            ;;
        3)
            show_log
            ;;
        4)
            get_info_syst
            ;;
        5)
            main_menu
            ;;
        6)
            echo "Fermeture... Au revoir!"
            log_message "INFO" "Script terminé"
            exit 0
            ;;
        *)
            echo "Choix invalide"
            computer_action_menu
            ;;
    esac
}

# Récupération des paramètres SSH
ask_user_params

# Appel principal du script
main_menu
echo=================================================================fin du Script-bash===============================================================

