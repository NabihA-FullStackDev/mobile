# Mobile - Flutter & Dart: Module 2

Bienvenue dans le dépôt du **Module 2 : API et Gestion des Données** de Mobile - Flutter & Dart ! Ce module prolonge le développement de l'application météo, en intégrant des APIs pour obtenir des données météorologiques et des informations de géolocalisation, ainsi qu'en gérant l'affichage dynamique de ces données dans l'application.

## Structure des Exercices

Ce module est divisé en plusieurs exercices qui introduisent progressivement l'utilisation d'APIs et la gestion des données dans Flutter.

### Exercice 00 - Where are we?
- **Objectif** : Implémenter la géolocalisation de l'appareil pour obtenir la position actuelle de l'utilisateur.
- **Contenu** :
  - Utiliser le GPS du dispositif pour récupérer les coordonnées de l'utilisateur, avec gestion des autorisations.
  - Si l'utilisateur autorise la géolocalisation, afficher les coordonnées actuelles.
  - Si l'utilisateur refuse, permettre une recherche manuelle d'une ville.
  - **Note** : Utilisez uniquement le GPS de l'appareil pour la géolocalisation, sans recourir à une API externe.

### Exercice 01 - Searcher
- **Objectif** : Ajouter une barre de recherche pour obtenir la météo en fonction du nom de la ville, du pays ou de la région.
- **Contenu** :
  - Utiliser l'API de géocodage pour obtenir les coordonnées d'une ville à partir de son nom et afficher une liste de suggestions de villes (nom, région, pays).
  - La liste de suggestions doit se mettre à jour dynamiquement au fur et à mesure de la saisie.
  - L'utilisateur doit pouvoir sélectionner une ville dans la liste pour afficher les données météo de cette ville.

### Exercice 02 - Fill the Views
- **Objectif** : Afficher les données météo dans les différents onglets de l'application.
- **Contenu** :
  - **Onglet "Current"** : Afficher la ville, la température actuelle, la description météo (nuageux, ensoleillé, etc.), et la vitesse du vent.
  - **Onglet "Today"** : Afficher la météo de la journée sous forme de liste, incluant la température, la description et la vitesse du vent pour chaque heure.
  - **Onglet "Weekly"** : Afficher la météo de la semaine avec les températures minimales et maximales, la description météo, et les dates.
  - **Détails** : 
    - L'application doit démarrer sur l'onglet "Current".
    - Lors d'une recherche, rester sur l'onglet en cours.
    - L'application doit afficher les dernières données météo lorsque l'on change d'onglet.

### Exercice 03 - What’s wrong with you?
- **Objectif** : Gérer les erreurs et les cas particuliers dans l'application.
- **Contenu** :
  - Si l'utilisateur entre un nom de ville inexistant ou si la connexion à l'API échoue, afficher un message d'erreur.
  - Le message d'erreur doit persister jusqu'à ce qu'une ville valide soit entrée ou que la connexion soit rétablie.
  - Ce traitement permet de renforcer la robustesse de l'application face aux erreurs.

## Objectif

Ce dépôt rassemble le travail de gestion des données et des APIs pour enrichir l'application météo avec des informations en temps réel. Ce module couvre les bases de la récupération de données externes et de la gestion des cas d'erreurs dans Flutter.

Bonne exploration et découverte de l'intégration des APIs et de la gestion des données en Flutter !
