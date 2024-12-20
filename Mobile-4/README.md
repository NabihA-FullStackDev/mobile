# Mobile - Flutter & Dart: Module 4

Bienvenue dans le dépôt du **Module 4 : Authentification et Base de Données** de Mobile - Flutter & Dart ! Dans ce module, nous allons créer une application de journal personnel (diary app) permettant aux utilisateurs de se connecter, de stocker et de gérer leurs entrées de journal dans une base de données sécurisée.

## Structure des Exercices

Ce module comporte deux exercices principaux pour mettre en place l'authentification et la gestion de la base de données.

### Exercice 00 - Login Page
- **Objectif** : Créer une page de connexion pour l’application.
- **Contenu** :
  - La page de connexion doit inclure :
    - Un bouton de connexion qui redirige soit vers une page d’authentification soit directement vers la page du journal si l'utilisateur est déjà connecté.
    - La possibilité de se connecter via un compte Google ou GitHub.
  - **Authentification** : Utilisez un service d'authentification tel que Firebase ou AWS pour gérer les utilisateurs de manière sécurisée.
  - **But** : La connexion garantit que seul l'utilisateur authentifié peut accéder aux entrées du journal.

### Exercice 01 - Profile Page
- **Objectif** : Créer une page de profil pour gérer les entrées de journal.
- **Contenu** :
  - La page de profil doit être accessible uniquement si l'utilisateur est connecté.
  - Après la connexion, l’utilisateur est redirigé vers cette page, où il peut voir et gérer ses entrées de journal.
  - **Base de Données** :
    - Configurez une base de données pour stocker :
      - L’adresse email de l’utilisateur.
      - La date de chaque entrée.
      - Le titre de chaque entrée.
      - L’humeur de l’utilisateur pour la journée.
      - Le contenu de chaque entrée.
  - **Fonctionnalités** :
    - Afficher une liste de toutes les entrées du journal.
    - Inclure un bouton pour créer une nouvelle entrée et mettre à jour la liste après ajout.
    - Permettre de lire le contenu d’une entrée en appuyant dessus.
    - Inclure un bouton pour supprimer une entrée, avec une mise à jour en temps réel de la liste après suppression.

## Objectif

Ce dépôt regroupe la mise en place de l’authentification et de la base de données pour une application de journal en Flutter. Ce module établit les fondations d’une application sécurisée avec une interface utilisateur privée et un stockage de données.

Bonne mise en œuvre de l’authentification et de la gestion des données !
