# UNLocBoX - Présentation sur la Toolbox d'Optimisation Non-Lisse

## Aperçu

Ce document présente **UNLocBoX** (UNconstrained L0C convex Optimization toolBOX), une boîte à outils MATLAB pour l'optimisation convexe non lisse, développée à l'EPFL de Lausanne.

## 👥 Auteurs

- **ESSUTHI MBANGUE ANGE ARMEL** (24F2456)
- **TAGNE TALLA IDRISS CHANEL** (19M2351)
- **DJATCHE-NKAMGANG SYLVANO** (22W2163)
- **GOUJOU GUIMATSA ZIDANE** (21T2899)

**Encadrement :** Pr. MELATAGIA  
**Institution :** Université de Yaoundé I - Département d'Informatique

## Contenu de la Présentation

### 1. Introduction à UNLocBoX
- Boîte à outils MATLAB pour l'optimisation convexe non lisse
- Compatible avec GNU Octave (alternative open source)
- Implémente les méthodes de splitting proximal
- Version Python disponible : PyUNLocBoX

### 2. Contexte Mathématique
- Méthodes proximales adaptées aux problèmes à grande échelle
- Applications : reconstruction d'images, apprentissage machine, traitement du signal

### 3. Structure de UNLocBoX
- **Solvers** : Cœur de la toolbox (FISTA, Douglas-Rachford, etc.)
- **Opérateurs proximaux** : Implémentation des prox pour diverses fonctions
- **Fonction principale** : `solvep` avec sélection automatique du solveur

### 4. Solveurs Disponibles
- **Solveurs spécifiques** : Forward-Backward, Douglas-Rachford, ADMM, Chambolle-Pock
- **Solveurs généraux** : Generalized Forward-Backward, PPXA, SDMM

### 5. Définition des Fonctions
- Structure modulaire pour définir les fonctions objectifs
- Support des fonctions différentiables et non-différentiables

### 6. Exemple Pratique
- Reconstruction d'image avec régularisation TV
- Code MATLAB/Octave complet fourni

## 🛠️ Installation et Utilisation

### Environnements Supportés
- **MATLAB** (versions récentes)
- **GNU Octave** (alternative open source)

### Téléchargement
- GitHub : https://github.com/epfl-lts2/unlocbox
- Site officiel : https://lts2.epfl.ch/unlocbox/

### Dépendances Optionnelles
- LTFAT (pour certaines démonstrations)
- GSPBox (pour le traitement sur graphes)

## Avantages

- Interface simple et intuitive
- Large choix de solveurs et d'opérateurs
- Documentation complète
- Code open source
- Compatible MATLAB et GNU Octave

## Applications Typiques

- Reconstruction d'images et signaux
- Problèmes de régularisation
- Apprentissage machine
- Vision par ordinateur
- Traitement du signal

---

*Présentation réalisée dans le cadre du cours INF4127 : Optimisation 2 - Année académique 2024-2025*