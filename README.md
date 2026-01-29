# 🔤 WordScramble

Une application SwiftUI de jeu de mots où le joueur doit former le plus de mots possibles à partir des lettres d'un mot racine. Utilise la validation d'orthographe native d'iOS et un système de scoring.

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-iOS%2016+-blue.svg)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)

## 📱 Aperçu

<div align="center">
  <img src="assets/wordscramble-demo.gif" alt="WordScramble Demo" width="300"/>
</div>

### Fonctionnalités

WordScramble permet de :
- 🎲 Générer un mot racine aléatoire depuis une liste de 10,000+ mots
- ✍️ Saisir des mots formés à partir des lettres du mot racine
- ✅ Valider automatiquement l'orthographe avec le dictionnaire iOS
- 🔍 Vérifier que les lettres sont disponibles dans le mot racine
- 🚫 Empêcher les doublons et mots trop courts
- 🏆 Calculer un score basé sur la longueur des mots et le nombre trouvé
- 🔄 Recommencer avec un nouveau mot à tout moment
- 📝 Afficher la liste des mots trouvés avec leur longueur

## 🛠️ Technologies utilisées

### Langage & Frameworks
- **Swift** - Langage de programmation moderne d'Apple
- **SwiftUI** - Framework UI déclaratif
- **UIKit** - Framework pour UITextChecker (vérification orthographe)
- **Foundation** - Manipulation de fichiers et strings

### Concepts SwiftUI implémentés

#### State Management
- `@State` - Gestion de multiples états (mots utilisés, mot racine, nouveau mot, score, erreurs)
- **Array management** - Manipulation dynamique de `usedWords`
- **Score tracking** - Calcul et mise à jour du score en temps réel

#### Composants UI
- `NavigationStack` - Navigation moderne avec titre dynamique
- `List` - Affichage de la liste des mots trouvés
- `Section` - Organisation en sections (input, mots trouvés, score)
- `TextField` - Saisie de texte
  - `.textInputAutocapitalization(.never)` - Désactive les majuscules auto
  - `.onSubmit()` - Action lors de la validation (touche Entrée)
- `ForEach` - Itération sur les mots trouvés
- `HStack` - Disposition horizontale (icône + texte)
- `Image(systemName:)` - Icônes SF Symbols dynamiques
- `Alert` - Dialogues d'erreur
- `Toolbar` - Bouton "New Deal" pour recommencer
- `withAnimation` - Animation lors de l'ajout de mots

#### Validation & Logique
- **Guard statements** - Validation en cascade (longueur, originalité, possibilité, orthographe)
- **UITextChecker** - Vérification d'orthographe native iOS
- **String manipulation** - `.lowercased()`, `.trimmingCharacters()`
- **File loading** - Chargement du fichier texte depuis le Bundle
- **Random selection** - `.randomElement()` pour mot aléatoire

#### Gestion de fichiers
- `Bundle.main.url()` - Accès aux ressources du bundle
- `String(contentsOf:encoding:)` - Lecture de fichier texte
- `.components(separatedBy:)` - Parsing du fichier (ligne par ligne)

#### Patterns Swift/SwiftUI
- **Optional handling** - `if let`, `guard`, nil-coalescing (`??`)
- **String processing** - Nettoyage et normalisation
- **Error handling** - `fatalError()` pour erreurs critiques
- **Early returns** - Guards pour validation en cascade
- **Array operations** - `.insert(at:)`, `.contains()`, `.randomElement()`
- **Character iteration** - `for letter in word`
- **Index manipulation** - `.firstIndex(of:)`, `.remove(at:)`

## 🎮 Règles du jeu

### Validation des mots

Un mot est **accepté** si :
1. ✅ Il contient **au moins 3 lettres**
2. ✅ Il est **différent** du mot racine
3. ✅ Il n'a **pas déjà été utilisé**
4. ✅ Il peut être **formé** avec les lettres du mot racine (chaque lettre utilisée une seule fois)
5. ✅ Il existe dans le **dictionnaire anglais**

### Système de scoring
```swift
score += newWord.count + (usedWords.count - 1)
```

**Calcul :**
- Points = **longueur du mot** + **bonus** (nombre de mots trouvés - 1)
- Plus le mot est long, plus il rapporte
- Plus tu trouves de mots, plus les suivants rapportent

**Exemple :**
```
Mot racine : "renaming"

1er mot "name" (4 lettres) → 4 + 0 = 4 points
2ème mot "ring" (4 lettres) → 4 + 1 = 5 points  
3ème mot "gain" (4 lettres) → 4 + 2 = 6 points
4ème mot "mane" (4 lettres) → 4 + 3 = 7 points

Score total : 22 points
```

## 📖 Concepts appris

### Swift
- Lecture et parsing de fichiers texte
- Manipulation avancée de strings
- Guards multiples pour validation en cascade
- Algorithme de vérification de lettres disponibles
- Gestion d'erreurs avec fatalError

### SwiftUI
- TextField avec validation sur submit
- List dynamique avec animations
- Navigation avec titre dynamique
- Toolbar avec actions
- SF Symbols dynamiques (nombre dans l'icône)
- `.onAppear()` pour initialisation
- `.onSubmit()` pour actions clavier

### UIKit Legacy
- UITextChecker pour vérification d'orthographe
- NSRange pour compatibilité Objective-C
- UTF-16 encoding pour comptage de caractères
- NSNotFound comme constante de non-trouvé

### Algorithmes
- **Vérification de disponibilité des lettres** :
  - Copie du mot racine
  - Retrait progressif des lettres utilisées
  - Détection d'impossibilité
- **Validation en cascade** avec guards
- **Scoring progressif** basé sur multiple critères

### Logique de jeu
- Génération aléatoire de défis
- Prévention des doublons
- Reset complet du jeu
- Feedback immédiat à l'utilisateur

## 🚀 Installation
```bash
# Cloner le repository
git clone https://github.com/ton-username/WordScramble.git

# Ouvrir le projet dans Xcode
cd WordScramble
open WordScramble.xcodeproj
```

**Prérequis :**
- Xcode 15+
- iOS 16.0+
- macOS 13+ (pour développement)

**Fichiers nécessaires :**
- `start.txt` - Liste de 10,000+ mots anglais (à placer dans le bundle)

## 💡 Améliorations possibles

- [ ] Support multilingue (français, espagnol...)
- [ ] Mode difficile (mots plus longs, temps limité)
- [ ] Historique des meilleurs scores avec SwiftData
- [ ] Partage du score sur réseaux sociaux
- [ ] Animations lors de l'ajout de mots
- [ ] Son et vibrations pour feedback
- [ ] Hints pour trouver des mots
- [ ] Classement des joueurs (Game Center)
- [ ] Mode multijoueur local
- [ ] Statistiques détaillées (mots les plus longs, temps moyen...)
- [ ] Thèmes visuels personnalisables
- [ ] Mode entraînement avec indices

## 🎨 Design

- **Liste animée** avec `withAnimation`
- **SF Symbols dynamiques** : icônes avec numéros (1.circle, 2.circle...)
- **Sections organisées** : Input, Mots trouvés, Score
- **Titre dynamique** : Le mot racine en haut
- **Toolbar** : Bouton "New Deal" pour recommencer
- **Alertes contextuelles** : Messages d'erreur clairs
- **Désactivation des majuscules auto** : Meilleure UX pour saisie

## 🔍 Fonctions clés expliquées

### `isPossible(word:)` - Vérification des lettres
```swift
func isPossible(word: String) -> Bool {
    var tempWord = rootWord  // Copie du mot racine
    
    for letter in word {
        if let pos = tempWord.firstIndex(of: letter) {
            tempWord.remove(at: pos)  // Retire la lettre utilisée
        } else {
            return false  // Lettre non disponible
        }
    }
    return true  // Toutes les lettres trouvées
}
```

**Logique :**
- Crée une copie temporaire du mot racine
- Pour chaque lettre du mot testé :
  - Si la lettre existe → la retire (utilisée)
  - Sinon → mot impossible
- Chaque lettre ne peut être utilisée qu'**une fois**

**Exemple :**
```
rootWord = "renaming"
word = "name"

Cherche 'n' → trouve à index 2 → "reaming"
Cherche 'a' → trouve à index 2 → "reming"  
Cherche 'm' → trouve à index 2 → "reing"
Cherche 'e' → trouve à index 1 → "ring"
✅ Toutes les lettres trouvées !
```

### `isReal(word:)` - Vérification d'orthographe
```swift
func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(
        in: word,
        range: range,
        startingAt: 0,
        wrap: false,
        language: "en"
    )
    return misspelledRange.location == NSNotFound
}
```

**Logique :**
- Utilise le dictionnaire système iOS
- `NSNotFound` = mot correct
- Sinon = mot invalide ou inexistant

### `startGame()` - Initialisation
```swift
func startGame() {
    score = 0
    usedWords = []
    
    // Charge le fichier de mots
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
        if let startWords = (try? String(contentsOf: startWordsURL, encoding: .utf8)) {
            let allWords = startWords.components(separatedBy: "\n")
            rootWord = allWords.randomElement() ?? "silkworm"
            return
        }
    }
    
    fatalError("Could not load start.txt from bundle.")
}
```

**Étapes :**
1. Reset du score et des mots utilisés
2. Cherche le fichier `start.txt` dans le bundle
3. Charge le contenu du fichier
4. Parse en tableau de mots (séparé par `\n`)
5. Sélectionne un mot aléatoire
6. Si échec → crash avec `fatalError` (fichier critique manquant)

## 👨‍💻 Auteur

**Guillaume Richard**  
🚀 Apprenant développement Swift & SwiftUI | En formation full-stack MERN  
🥽 Exploration du développement spatial avec visionOS  
🤖 Découverte du Machine Learning avec Core ML

## 📝 Notes techniques

### Pourquoi `.utf16.count` ?
```swift
word.utf16.count  // Pas word.count
```

`UITextChecker` vient d'Objective-C qui compte en UTF-16. Important pour les emojis et caractères spéciaux.

### Validation en cascade avec Guards
```swift
guard answer.count >= 3 else { return }
guard answer != rootWord else { return }
guard isOriginal(word: answer) else { return }
// ...
```

**Pattern "early return"** : Arrête dès qu'une condition échoue, garde le code propre.

### Animations
```swift
withAnimation {
    usedWords.insert(answer, at: 0)
}
```

Anime automatiquement l'ajout du mot en haut de la liste.

### SF Symbols dynamiques
```swift
Image(systemName: "\(word.count).circle")
```

Affiche automatiquement l'icône avec le bon chiffre (1.circle, 2.circle, etc.)

## 🎓 Source

Projet basé sur le tutoriel **"Word Scramble"** de Paul Hudson dans la série **100 Days of SwiftUI**.

## 📝 Licence

Ce projet est un projet d'apprentissage personnel.

---

*Projet réalisé dans le cadre de l'apprentissage de SwiftUI - Janvier 2026*
