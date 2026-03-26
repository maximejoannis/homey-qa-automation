# Homey QA Automation
Projet d’automatisation des tests fonctionnels de l’application **Homey** avec **Robot Framework**, **SeleniumLibrary** et **GitHub Actions**.

L’objectif de ce repository est de démontrer une approche professionnelle de l’automatisation QA autour de trois piliers :

- **Learn** : apprendre à automatiser proprement, comprendre les scénarios, stabiliser les tests
- **Build** : structurer un projet maintenable, clair et réutilisable
- **Deploy** : industrialiser l’exécution, le reporting et l’analyse des résultats

---

## 1. Contexte du projet

Ce projet couvre l’automatisation de parcours fonctionnels autour de l’application Homey :

- **US-07 : Faire une demande de réservation**
- **US-08 : Traiter une demande de réservation**
- Parcours complémentaire : **Contacter l’hôte**

Le projet a été conçu pour :
- exécuter les tests localement
- exécuter les tests automatiquement dans GitHub Actions
- générer des rapports Robot Framework
- préparer l’industrialisation du reporting et de l’analyse intelligente des échecs

---

## 2. Stack technique

- **Robot Framework**
- **SeleniumLibrary**
- **Python 3.11**
- **GitHub Actions**
- **Selenium Standalone Chrome**
- **VS Code**

---

## 3. Structure du repository

```text
homey-qa-automation/
├── .github/
│   └── workflows/
│       └── robot.yml
├── tests/
│   ├── us07_faire_demande_reservation.robot
│   └── contact_hote.robot
├── resources/
│   ├── common.resource
│   ├── navigation.resource
│   ├── reservation.resource
│   ├── contact_hote.resource
│   └── assertions.resource
├── variables/
│   ├── env.robot
│   └── data.robot
├── results/
├── requirements.txt
└── README.md
