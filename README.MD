# Génération automatique de Virtual Host pour Apache 2.4

### Contexte

Afin de faciliter la création des Virtual Hosts, cet outil permet de créer le fichier de configuration, d'activer le Virtual Host et de l'intégrer dans le fichier hosts du système.

### Utilisation

Récupérer le projet

```bash
# On rentre à la racine
cd
# On clone le projet
git clone git@gitlabdev:cpamg/vh-generator.git
```

Lancer le script

```bash
# On entre dans le dossier
cd vh-generator
# on lance le script
sudo ./vh-generator.sh
```

Entrer le nom de l'application dans la première fenêtre et la version de Symfony dans la deuxième. Valider et c'est terminé.
