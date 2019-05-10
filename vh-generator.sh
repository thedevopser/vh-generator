#!/bin/bash
# v1.0.0
# Script de génération de Virtual Host pour APACHE

# Code couleur
rouge='\e[1;31m'
jaune='\e[1;33m' 
bleu='\e[1;34m' 
violet='\e[1;35m' 
vert='\e[1;32m'
neutre='\e[0;m'

if [ "$UID" -ne "0" ]
then
    echo -e "${rouge}Merci de lancer le script en mode administrateur (sudo ./vh-generator.sh).${neutre}"
    exit
fi

MY_DIR=$(dirname $0)
. $MY_DIR/config.sh

CONF_HOSTS_FILE="/etc/hosts"

APP=$(zenity --entry --title="$BGN_TITLE" --text="$BGN_TEXT")
VERSION=$(zenity --entry --title="$VERSION_TITLE" --text="$VERSION_TEXT" $VERSION_28 $VERSION_34 $VERSION_4)
if [ $? -ne 0 ] ; then
	exit
fi

pathToVhost="/etc/apache2/sites-available/${APP}.conf"
domaineDev="${APP}.cnamts.local"
case ${VERSION} in 
    "2.8" )     www_folder="web";;
    "3.4" )     www_folder="web";;
    "4"   )     www_folder="public";;
esac

document_root="/home/projets/${APP}/${www_folder}"

echo -e "${vert}Le vhost sera situé : ${pathToVhost}${neutre}"

echo -e "${bleu}Création du Vhost Apache 2.4${neutre}"
ServerAlias=$false
echo "- ServerName : ${domaineDev}"
echo "- directory : ${document_root}"

touch ${pathToVhost}
echo -e "<VirtualHost *:80>" >> ${pathToVhost}
echo -e "\tServerName ${domaineDev}" >> ${pathToVhost}
echo -e "\tDocumentRoot \"${document_root}\"" >> ${pathToVhost}
echo -e "\t<directory ${document_root}>" >> ${pathToVhost}
echo -e "\t\tOptions -Indexes +FollowSymLinks +MultiViews" >> ${pathToVhost}
echo -e "\t\tAllowOverride All" >> ${pathToVhost}
echo -e "\t\tRequire all granted" >> ${pathToVhost}
echo -e "\t</Directory>" >> ${pathToVhost}
echo -e "</VirtualHost>" >> ${pathToVhost}

echo "----------"
echo -e "${bleu}Ajouter une entrée au fichier HOSTS${neutre}"
echo -e "127.0.0.1\t${domaineDev}" >> ${CONF_HOSTS_FILE}

echo "----------"
echo -e "${bleu}Activation du VirtualHost${neutre}"
echo "----------"

a2ensite ${APP}.conf
service apache2 restart

echo "----------"
echo -e "${vert}Création terminée. Vous pouvez accéder à votre site à l'adresse http://${domaineDev}${neutre}"
echo "----------"

zenity --warning --no-wrap --height 100 --width 300 --title "$MSG_END_TITLE" --text "$MSG_END_TEXT"