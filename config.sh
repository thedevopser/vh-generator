#!
# include file by the my.... command series (post installation scripts)
#


MY_PROG=LangueFR

f_get_msg() {
    no_msg_file="Erreur : fichier non trouvé ou problème de permission d'accès !"
    lang=${LANG:=english}
    case ${lang} in
            [Ee][Nn][Gg]*   )   all_msg=${MY_DIR}/${MY_PROG}.fr
                                DOWNLOAD_DIR=~/Téléchargements;;
            [Ff][Rr]*       )   all_msg=${MY_DIR}/${MY_PROG}.fr
                                DOWNLOAD_DIR=~/Téléchargements;;
            *               )   all_msg=${MY_DIR}/${MY_PROG}.fr
                                DOWNLOAD_DIR=~/Téléchargements;;
    esac
    if [ -f ${all_msg} -a -r ${all_msg} ]
	then
		. ${all_msg}
	else
		echo ${no_msg_file}
		exit 3
	fi

}





#Get Language message
f_get_msg

notify-send  --icon=dialog-error "$NS_WATCH_OUT" "$NS_PWD_ASKED" -t 10000
