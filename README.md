# Projet VHDL — ST2SEA
## Implémentation structurelle d'un processeur à jeu d'instructions réduit

---

## Partie 1 : Design et simulation

### Entités requises

| Entité | Quantité | Statut |
|---|---|---|
| Registre synchrone | ×10 | ☐ |
| Multiplexeur | ×1 | ☐ |
| Additionneur / Soustracteur | ×1 | ☐ |
| Unité de contrôle FSM | ×1 | ☐ |

---

### Registre synchrone (reg9.vhd)

|Type |Signal | Taille | Description |
|---|---|---|---|
|In| `clk` | 1 bit | Écriture du registre sur front d'horloge montant |
|In| `en` | 1 bit | Activation de l'entrée du registre |
|In| `rst` | 1 bit | reset du registre |
|In| `In` | 9 bits | Valeur d'entrée |
|Out| `Out` | 9 bits | Valeur de sortie |