# Mobile - Flutter & Dart: Module 1

Bienvenue dans le dépôt du **Module 1 : Structure et Logique** de Mobile - Flutter & Dart ! Dans ce module, nous continuons le développement d'une application météo en travaillant sur la structure de l'interface utilisateur, notamment le `BottomBar` et le `TopBar`, pour organiser et afficher les informations de manière claire et réactive.

## Structure des Exercices

Ce module comprend deux exercices principaux qui permettent de construire les bases de l'application météo.

### Exercice 00 - BottomBar
- **Objectif** : Créer la structure de l'application avec un `BottomBar` comportant trois onglets : "Currently", "Today", et "Weekly".
- **Contenu** : 
  - Ajout d'une barre de navigation en bas de l'écran avec trois onglets, chacun ayant un nom et une icône.
  - Les onglets doivent pouvoir être sélectionnés en appuyant ou en glissant, et chaque sélection doit changer le contenu de la page pour afficher le nom de l'onglet actif.
  - Au démarrage, l'onglet "Currently" doit être sélectionné par défaut.
- **Widgets recommandés** :
  - `TabBar` pour la création d'onglets en haut de la page.
  - `TabBarView` pour afficher le contenu des onglets.
  - `BottomAppBar` pour la barre de navigation inférieure.

### Exercice 01 - TopBar
- **Objectif** : Ajouter une `TopBar` comprenant un champ de recherche (`TextField`) et un bouton de géolocalisation pour interagir avec l'application.
- **Contenu** : 
  - Le champ de recherche permet de saisir une localisation, tandis que le bouton de géolocalisation affiche la position de l'utilisateur.
  - Si du texte est saisi dans le `TextField`, l'application doit afficher le nom de l'onglet actuel accompagné du texte saisi dans tous les onglets.
  - Si le bouton de géolocalisation est utilisé, l'application affiche le nom de l'onglet actuel accompagné du mot "Geolocation" dans tous les onglets.
- **Détails d'affichage** : Les composants doivent s'adapter à la taille de l'écran pour être pleinement réactifs et permettre une utilisation intuitive sur tout type d'appareil.

## Objectif

Ce dépôt représente les étapes de structuration de l'application météo en Flutter, permettant de poser les fondations logiques et structurelles. Ce module se concentre sur la gestion de la navigation et l'interaction avec l'utilisateur pour une expérience fluide et réactive.

Bonne exploration de Flutter et Dart avec le développement de cette application météo !
