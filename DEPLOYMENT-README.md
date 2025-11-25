# Déploiement GPT-OSS sur Render

## 🚀 Déploiement Rapide

### Étape 1 : Préparer le repo
1. Commitez et pushez vos changements sur GitHub/GitLab
2. Assurez-vous que `render.yaml`, `Dockerfile` et `requirements.txt` sont dans le repo

### Étape 2 : Déployer sur Render
1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur "New +" → "Blueprint"
3. Connectez votre repo Git
4. Render détectera automatiquement le `render.yaml`
5. Cliquez "Deploy Blueprint"

### Étape 3 : Configuration
- **Service Name** : `gpt-oss-api`
- **Plan** : Starter (gratuit pour commencer)
- **Region** : Choisissez Europe (Frankfurt) pour la latence

## 🔧 Configuration Avancée

### Variables d'Environnement
Ajoutez dans Render Dashboard → Environment :
```
PORT=8000
```

### Backend d'Inference
Par défaut, utilise `stub` (pas d'inférence réelle). Pour changer :
```bash
--inference-backend triton  # Pour Triton
--inference-backend metal   # Pour Metal (macOS)
--inference-backend vllm    # Pour vLLM
```

### Modèle Checkpoint
Pour charger un vrai modèle :
```bash
--checkpoint /path/to/model
```
Téléchargez votre modèle SafeTensors et montez-le comme volume.

## 🌐 Utilisation de l'API

Une fois déployé, votre API sera disponible sur :
```
https://gpt-oss-api.onrender.com/v1/responses
```

### Exemple de requête :
```bash
curl -X POST https://gpt-oss-api.onrender.com/v1/responses \
  -H "Content-Type: application/json" \
  -d '{
    "input": "Hello, how are you?",
    "max_output_tokens": 100
  }'
```

## 📊 Monitoring

- **Logs** : Render Dashboard → Logs
- **Métriques** : Render Dashboard → Metrics
- **Health Check** : `GET /` (retourne 404, mais confirme que l'API tourne)

## 🆘 Dépannage

### Build qui échoue
- Vérifiez les logs de build dans Render
- Assurez-vous que toutes les dépendances système sont dans le Dockerfile

### API qui ne répond pas
- Vérifiez que le port 8000 est exposé
- Vérifiez les variables d'environnement

### Performance
- Upgrade vers un plan payant pour plus de RAM/CPU
- Utilisez un backend d'inference optimisé

## 💡 Alternatives

Si Render ne convient pas :
- **Railway** : `railway up` (encore plus simple)
- **DigitalOcean** : App Platform avec Docker
- **AWS/GCP** : ECS/EKS pour production

---

**🎉 Votre API GPT-OSS sera déployée et accessible mondialement !**
