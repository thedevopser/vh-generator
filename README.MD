🌐 Créateur de Virtual Host Apache 🌐
--- 

Ce script bash permet de créer automatiquement un vhost Apache2 en fonction des paramètres demandés à l'utilisateur. 🖥️🚀

## 💻 Utilisation
Pour exécuter ce script, vous devez avoir des privilèges sudo. Utilisez la commande suivante pour exécuter le script :

```bash
sudo bash create_vhost.sh
```
Lors de l'exécution, le script vous demandera de fournir les informations suivantes :

- Le nom du serveur (par exemple, monsite.com)
- Le chemin de la racine du document (par exemple, /var/www/monsite)

Ensuite, le script créera un fichier de configuration Apache dans le dossier /etc/apache2/sites-available, activera le site et redémarrera le service Apache.

Après avoir exécuté le script, vous devez ajouter une entrée dans le fichier hosts de votre système d'exploitation pour associer l'adresse IP du serveur au nom du serveur que vous avez entré.

## 🛠️ Dépendances

Ce script dépend de l'outil dialog qui est utilisé pour afficher des boîtes de dialogue dans le terminal. Si dialog n'est pas installé sur votre système, le script tentera de l'installer automatiquement en utilisant apt-get ou yum, selon le gestionnaire de paquets disponible.

---

🌐 Apache Virtual Host Creator 🌐
--- 

This bash script allows you to automatically create an Apache2 vhost based on parameters asked to the user. 🖥️🚀

## 💻 Usage
To run this script, you need to have sudo privileges. Use the following command to run the script:

```bash
sudo bash create_vhost.sh
```

When running, the script will ask you to provide the following information:

- The server name (for example, mysite.com)
- The document root path (for example, /var/www/mysite)

Then, the script will create an Apache configuration file in the /etc/apache2/sites-available directory, enable the site, and restart the Apache service.

After running the script, you should add an entry to the hosts file of your operating system to associate the server's IP address with the server name you entered.

## 🛠️ Dependencies
This script depends on the dialog tool which is used to display dialog boxes in the terminal. If dialog is not installed on your system, the script will attempt to install it automatically using apt-get or yum, depending on the available package manager.
