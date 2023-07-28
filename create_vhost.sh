#!/bin/bash

# Vérifiez si le script est exécuté avec des privilèges sudo
if [ "$EUID" -ne 0 ]
  then echo -e "\033[31mVeuillez exécuter ce script avec des privilèges sudo.\033[0m"
  exit
fi

# Vérifiez si l'outil dialog est installé
if ! command -v dialog &> /dev/null
then
    echo "L'outil dialog n'est pas installé. Tentative d'installation..."
    if [ "$(uname)" == "Linux" ]; then
        # Si le système est Linux, utilisez le gestionnaire de paquets approprié
        if command -v apt-get &> /dev/null
        then
            # Si apt-get est disponible, utilisez-le pour installer dialog
            apt-get install -y dialog
        elif command -v yum &> /dev/null
        then
            # Si yum est disponible, utilisez-le pour installer dialog
            yum install -y dialog
        else
            echo -e "\033[31mImpossible d'installer dialog. Veuillez l'installer manuellement.\033[0m"
            exit
        fi
    else
        echo -e "\033[31mCe script est destiné à être exécuté sur Linux. Veuillez installer dialog manuellement.\033[0m"
        exit
    fi
fi

# vérifier le système d'exploitation et définir le répertoire apache
if [ -f /etc/debian_version ]; then
    APACHE_SITES_AVAILABLE_DIR=/etc/apache2/sites-available
elif [ -f /etc/redhat-release ]; then
    APACHE_SITES_AVAILABLE_DIR=/etc/httpd/sites-available
else
    echo "Ce script ne supporte que Debian/Ubuntu et CentOS/RedHat."
    exit 1
fi

# Demandez le nom du serveur
SERVER_NAME=$(dialog --stdout --inputbox "Entrez le nom du serveur :" 0 0)

# Demandez le chemin du document racine
DOCUMENT_ROOT=$(dialog --stdout --inputbox "Entrez le chemin du document racine :" 0 0)

# Chemin vers le fichier de configuration Apache2
CONFIG_FILE="/etc/$APACHE_SITES_AVAILABLE_DIR/sites-available/$SERVER_NAME.conf"

# Créez le fichier de configuration à partir des valeurs entrées
cat > $CONFIG_FILE <<- "EOF"
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName SERVER_NAME
    DocumentRoot DOCUMENT_ROOT
    <Directory DOCUMENT_ROOT>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Remplacez les valeurs de modèle par les valeurs d'entrée
sed -i "s|SERVER_NAME|$SERVER_NAME|g" $CONFIG_FILE
sed -i "s|DOCUMENT_ROOT|$DOCUMENT_ROOT|g" $CONFIG_FILE

# Activez le site
a2ensite $SERVER_NAME.conf

# Redémarrez le service Apache2 pour que les modifications prennent effet
service apache2 restart

# Affichez le récapitulatif des informations
echo -e "\033[32mLe vhost a été créé avec succès !\033[0m"
echo -e "\033[34mRécapitulatif :\033[0m"
echo -e "\033[33mEmplacement du fichier vhost : \033[1m$CONFIG_FILE\033[0m"
echo -e "\033[33mNom du serveur : \033[1m$SERVER_NAME\033[0m"
echo -e "\033[33mRacine du document : \033[1m$DOCUMENT_ROOT\033[0m"
echo -e "\033[33mURL de l'application : \033[1mhttp://$SERVER_NAME\033[0m"
echo -e "\033[31mN'oubliez pas d'ajouter une entrée dans le fichier hosts de votre système d'exploitation pour faire pointer l'adresse IP vers le nom de domaine.\033[0m"
