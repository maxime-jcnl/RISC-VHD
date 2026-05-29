# Projet VHDL — ST2SEA

## Implémentation structurelle d'un processeur à jeu d'instructions réduit

## Partie 1 : Design et simulation

On souhaite intégrer les instructions suivantes:

- `mv RX,RY`: copie la valeur du registre RY dans le registre RX
- `mvi RX,#D`: copie la valeur #D dans le registre RX
- `add RX,RY`: additionne les valeurs des registres RX et RY et stock le résultat dans le registre RX
- `sub RX,RY`: soustraie les valeurs des registres RX et RY et stock le résultat dans le registre RX

### Entités requises

| Entité | Quantité | Statut |
|---|---|---|
| Registre synchrone | ×10 | fait |
| Multiplexeur | ×1 | fait |
| Additionneur / Soustracteur | ×1 | fait |
| Unité de contrôle FSM | ×1 | fait |

### Registre synchrone (reg9.vhd)

|Type |Signal | Taille | Description |
|---|---|---|---|
|In| `clk` | 1 bit | Écriture du registre sur front d'horloge montant |
|In| `en` | 1 bit | Activation de l'entrée du registre |
|In| `rst` | 1 bit | reset du registre |
|In| `In` | 9 bits | Valeur d'entrée |
|Out| `Out` | 9 bits | Valeur de sortie |

```vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg9 is
    Port(
        clk : in STD_LOGIC;
        en : in STD_LOGIC;
        rst : in STD_LOGIC;
        reg_in : in STD_LOGIC_VECTOR(8 downto 0);
        reg_out : out STD_LOGIC_VECTOR(8 downto 0)
    );
end entity reg9;

Architecture Behavioral of reg9 is
    begin
        process(clk, rst)
        begin
            if rst = '1' then
                reg_out <= (others => '0');
            elsif rising_edge(clk) then
                if en = '1' then
                    reg_out <= reg_in;
                end if;
            end if;
        end process;
end architecture Behavioral;
```

### Multiplexeur
|Type |Signal | Taille | Description |
