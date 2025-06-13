# DevOps Days - Application Web

## Description
Application web statique présentant les événements DevOps Days avec une base de données MariaDB pour démonstration des pratiques DevOps.

## Architecture
- **Frontend** : Application HTML/CSS/JavaScript statique
- **Backend** : PHP avec Apache
- **Base de données** : MariaDB avec données de pays
- **Conteneurisation** : Docker et Docker Compose
- **Registry** : GitHub Container Registry (ghcr.io)

## Practices DevOps Implémentées

### Continuous Integration (CI)
- **Déclenchement automatique** : Push sur branches main/master et Pull Requests
- **Build d'image Docker** : Construction automatique de l'image de l'application
- **Pipeline GitHub Actions** : Workflow défini dans `.github/workflows/build-app.yml`
- **Validation du code** : Vérification de la syntaxe et de la structure

**Actions réalisées :**
- Checkout du code source
- Build de l'image Docker
- Tests de base de l'application

### Continuous Delivery (CD)
- **Création d'artefacts** : Images Docker versionnées et taguées
- **Registry centralisé** : Stockage des images sur GitHub Container Registry
- **Gestion des versions** : Tagging automatique des images
- **Distribution** : Images disponibles pour déploiement

**Artefacts produits :**
- Images Docker de l'application web
- Images prêtes pour déploiement
- Historique des versions dans le registry

### Continuous Deployment
- **Déploiement automatique** : Watchtower surveille et met à jour les conteneurs
- **Mise à jour en temps réel** : Déploiement automatique des nouvelles versions
- **Surveillance continue** : Monitoring des nouvelles images dans le registry
- **Rollback possible** : Retour aux versions précédentes si nécessaire

**Mécanismes mis en place :**
- Watchtower configuré pour surveiller le conteneur web
- Intervalle de vérification : 30 secondes
- Mise à jour automatique dès qu'une nouvelle image est disponible

## Structure du Projet
```
devops/
├── .github/workflows/          # Pipelines CI/CD
│   └── build-app.yml
├── app/                        # Application statique
│   ├── index.html
│   ├── style.css
│   └── events.json
├── initdb/                     # Scripts d'initialisation DB
│   └── countries.sql
├── docker-compose.yml          # Orchestration des services
├── Dockerfile                  # Image de l'application
├── connect.php                 # Script de connexion DB
└── index.php                   # Page d'accueil PHP
```

## Utilisation

### Développement local
```bash
# Cloner le repository
git clone <url-du-repo>
cd devops

# Lancer la stack complète
docker-compose up -d

# Accéder à l'application
# Web : http://localhost:8080
# Test DB : http://localhost:8080/connect.php
```

### Déploiement
```bash
# Build manuel de l'image
docker build -t mon-app .

# Tag pour le registry
docker tag mon-app ghcr.io/username/devops-web:latest

# Push vers le registry
docker push ghcr.io/username/devops-web:latest
```

## Services

### Application Web (Port 8080)
- **Image** : `ghcr.io/diacles/devops-web:latest`
- **Fonction** : Serveur web Apache avec PHP
- **Contenu** : Application DevOps Days + script de test DB

### Base de Données (Port 3306)
- **Image** : `mariadb:latest`
- **Base** : `countries`
- **Utilisateur** : `johnny`
- **Données** : 239 pays avec codes ISO

### Watchtower
- **Image** : `containrrr/watchtower`
- **Fonction** : Déploiement continu automatique
- **Surveillance** : Conteneur `con-app-php-apache`

## Processus de Développement

1. **Développement** : Modification du code local
2. **Commit & Push** : Envoi des modifications sur GitHub
3. **CI Pipeline** : Build automatique de l'image
4. **Registry Update** : Nouvelle image disponible
5. **Auto-Deploy** : Watchtower détecte et déploie
6. **Vérification** : Application mise à jour automatiquement

## Monitoring et Maintenance

### Logs des conteneurs
```bash
# Logs de l'application
docker logs con-app-php-apache

# Logs de la base de données
docker logs mariadb-countries

# Logs de Watchtower
docker logs watchtower
```

### Vérification du statut
```bash
# Statut des conteneurs
docker-compose ps

# Utilisation des ressources
docker stats
```

## Évolutions Possibles

- **Tests automatisés** : Ajout de tests unitaires et d'intégration
- **Monitoring avancé** : Prometheus, Grafana pour métriques
- **Sécurité** : Scan de vulnérabilités des images
- **Multi-environnements** : Staging, production séparés
- **Load balancing** : Nginx pour la répartition de charge