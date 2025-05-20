## 📌 [Fidéliser les clients Silver via des campagnes ciblées sur des catégories à potentiel – Secteur : Retail / e-commerce](#)

**🎯 Objectif** :
Renforcer la **valeur des clients Silver** en les exposant à des **catégories qu’ils consomment peu**, mais qui présentent un **panier élevé et une marge intéressante** 

---

### SITUATION

Le segment **Silver**, défini via une segmentation RFM (score global 6 ou 7), regroupe des clients :

* Récents ou assez réguliers,
* Avec un volume d’achats modéré,
* Mais **actifs et engagés**.

👉 Ils représentent une part importante de la base clients,
mais **leur panier moyen et leur exposition produit sont limités**.
Ils ont donc un **fort potentiel de montée en valeur** via un travail de **cross-sell et d’élargissement de gamme**.

---

### TÂCHE

Identifier quelles **catégories de produits** sont :

* Sous-consommées par les Silver,
* Mais à **fort panier moyen** et **potentiel de marge**.

Et construire une **campagne marketing ciblée** sur ces catégories,
avec **groupe témoin aléatoire** pour mesurer l’impact réel.

---

### ACTION

#### 🔍 Analyse menée (100 % SQL – BigQuery)

* Comparaison **panier moyen Silver** vs **panier moyen global** **par catégorie** (`ratio_panier`)
* Comparaison de la **fréquence d’achat Silver** vs globale (`ratio_frequence`)
* Identification des catégories à potentiel :
  ✅ **Outerwear & Coats**
  ➤ Ratio panier : 0.89
  ➤ Ratio fréquence : 0.25
  ➤ Panier global : >150 € ➤ **forte valeur non exploitée**

#### 🎯 Ciblage CRM

* 1 992 clients Silver identifiés dans la base
* 172 avaient déjà acheté cette catégorie → exclus
* **1 820 clients ciblés** pour la campagne

#### 🎲 Construction d’un groupe témoin propre

* 10 % des clients tirés au sort via `RAND() <= 0.1`
* Groupe exposé : 1 673 clients
* Groupe témoin : 147 clients

#### 🧮 Simulation ROI

* Offre : **10 € dès 100 € d’achat**
* Marge brute estimée : 40 %
* Panier moyen estimé : 135 €
* Taux de conversion cible : 5 %
* ROI estimé : **x4.4**

---

### 🟣 RÉSULTAT ATTENDU

| Groupe  | Clients | Conversion | Panier moyen | CA total    | ROI attendu |
| ------- | ------- | ---------- | ------------ | ----------- | ----------- |
| Exposés | 1 673   | 5–6 %      | 135 €        | \~113 000 € | x4.4        |
| Témoin  | 147     | 3–4 %      | 130 €        | \~6 000 €   | —           |

---

## 💡 Ce que j’ai appris

* Analyser un segment client **au-delà des scores RFM** en croisant avec le **comportement produit**
* Identifier des **pistes de croissance **,
* Construire un groupe témoin via SQL (`RAND()` pour créer un groupe témoin)
* Construire une **campagne mesurable, rentable et ciblée**
* Structurer des tests pour **mesurer l’impact réel (uplift, CA, conversion)**
---

➡️ *Projet 100 % SQL – réalisé sur BigQuery avec le dataset public `thelook_ecommerce`*

PS:J'avais initialement prévu de créer une vue permanente pour conserver cette table, mais cela nécessite un environnement BigQuery payant.
