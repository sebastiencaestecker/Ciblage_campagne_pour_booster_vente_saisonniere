## 📌 [Fidéliser les clients Silver via des campagnes ciblées sur des catégories à potentiel – Secteur : Retail / e-commerce](#)

**Objectif** :
Renforcer la **fidélité** et la **valeur client** du segment Silver (score RFM = 6 ou 7), en les incitant à découvrir une catégorie à **fort panier moyen** et **forte marge** 

---

### SITUATION

Le segment **Silver**, défini via une segmentation RFM (score global 6 ou 7), regroupe des clients :

* Récents ou assez réguliers,
* Avec un volume d’achats modéré,
* Mais **actifs et engagés**.

Ils représentent une part importante de la base clients,
mais **leur panier moyen et leur exposition produit sont limités**.
Ils ont donc un **fort potentiel de montée en valeur** via un travail de **cross-sell et d’élargissement de gamme**.

L’analyse RFM croisée avec le catalogue produits montre que la catégorie *Outerwear & Coats* est :

* ✅ à **très forte marge brute moyenne** (>55 %)
* ❌ **peu consommée** par les Silver (ratio de fréquence = 0,25)
* ❌ Avec un **panier moyen Silver plus faible que la moyenne** (135 € vs 151 €)

> ✍️ Nous avons donc identifié un levier de **fidélisation**

---

### TÂCHE

Identifier quelles **catégories de produits** sont :

* Sous-consommées par les Silver,
* Mais à **fort panier moyen** et **potentiel de marge**.

Et construire une **campagne marketing ciblée** sur ces catégories,
avec **groupe témoin aléatoire ayant le même comportement d'achat que le groupe exposé** pour mesurer l’impact réel.

---

### ACTION

####  Analyse menée (100 % SQL – BigQuery)

* Comparaison **panier moyen Silver** vs **panier moyen global** **par catégorie** (`ratio_panier`)
* Comparaison de la **fréquence d’achat Silver** vs globale (`ratio_frequence`)
* Identification des catégories à potentiel pour les silver :
  **Outerwear & Coats**
  ➤ Ratio panier : 0.89
  ➤ Ratio fréquence : 0.25
  ➤ Panier global : >150 € ➤ **forte valeur non exploitée**
* Cibler les clients Silver n’ayant **jamais acheté de manteau**, et leur proposer une offre spécifique :
  ➤172 avaient déjà acheté un manteau ➔ exclus
  ➤ **1 820 clients éligibles**
  ➤ Tirage aléatoire via `RAND()` pour séparer en 2 groupe :
  * **Exposés** : 1 673
  * **Témoins** : 147
    
* **25 € offerts dès 100 € d’achat** sur *Outerwear & Coats*
* Créer un **groupe témoin de 10 %**
* Estimer le **ROI de la campagne** avant lancement
* 
Lors des soldes, une offre générique à -70 % sur cette catégorie n’a généré que **10 achats sur 1 661 Silver**
➔ **Taux de conversion = 0,6 %**

---

#### Simulation du ROI (avant envoi)

| Métrique                  | Valeur |
| ------------------------- | ------ |
| Taux de conversion estimé | 5 %    |
| Panier moyen estimé       | 135 €  |
| Marge brute estimée       | 55 %   |
| Générosité campagne       | 25 €   |

**Calcul :**

* 1 673 exposés × 5 % = 84 acheteurs
* CA total = 84 × 135 = **11 340 €**
* Marge = 11 340 € × 55 % = **6 237 €**
* Coût de générosité = 84 × 25 = **2 100 €**

** ROI estimé : (6 237 - 2 100) / 2 100 = ≈ x1.97**
---

##  Ce que j’ai appris

* Analyser un segment client **au-delà des scores RFM** en croisant avec le **comportement produit**
* Identifier des **pistes de croissance **,
* Construire un groupe témoin via SQL (`RAND()` pour créer un groupe témoin)
* Construire une **campagne mesurable, rentable et ciblée**
* La **marge brute produit** peut être croisée avec le comportement client pour calibrer la générosité offerte
* Une campagne ciblée et mesurable peut être **bien plus rentable qu’une opération de masse**
---

➡️ *Projet 100 % SQL – réalisé sur BigQuery avec le dataset public `thelook_ecommerce`*

PS:J'avais initialement prévu de créer une vue permanente pour conserver cette table, mais cela nécessite un environnement BigQuery payant.
