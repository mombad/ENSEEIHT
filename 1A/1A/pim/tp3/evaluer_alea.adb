with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Alea;

-- Évaluer la qualité du générateur aléatoire dans plusieurs
-- configurations.
procedure Evaluer_Alea is

    -- Évaluer la qualité du générateur de nombre aléatoire Alea sur un
    -- intervalle donné en calculant les fréquences absolues minimales et
    -- maximales des entiers obtenus lors de plusieurs tirages aléatoire
    -- ainsi que la fréquence moyenne théorique.
    --
    -- Paramètres :
    --    Borne: in Entier  -- le nombre aléatoire est dans 1..Borne
    --    Taille: in Entier -- nombre de tirages à faire (taille de l'échantillon)
    --    Min, Max: out Entier -- fréquence minimale et maximale
    --    Moyenne: out Float   -- fréquence moyenne théorique
    --
    -- Nécessite :
    --    Borne > 1
    --    Taille > 1
    --
    -- Assure : -- poscondition peu intéressante !
    --    0 <= Min Et Min <= Taille
    --    0 <= Max Et Max <= Taille
    --    Min + Max <= Taille
    --    Moyenne = Réel(Taille) / Réel(Borne)
    --    Min <= Moyenne Et Moyenne <= Max
    --
    -- Remarque : On ne peut ni formaliser les 'vraies' postconditions,
    -- ni écrire de programme de test car on ne maîtrise pas le générateur
    -- aléatoire.  Pour écrire un programme de test, on pourrait remplacer
    -- le générateur par un générateur qui fournit une séquence connue
    -- d'entiers et pour laquelle on pourrait déterminer les données
    -- statistiques demandées.
    -- Ici, pour tester on peut afficher les nombres aléatoires et refaire
    -- les calculs par ailleurs pour vérifier que le résultat produit est
    -- le bon.
    procedure Calculer_Statistiques (
        Borne    : in Integer;  -- Borne supérieur de l'intervalle de recherche
        Taille   : in Integer;  -- Taille de l'échantillon
        Min, Max : out Integer; -- min et max des fréquences de l'échantillon
        Moyenne  : out Float    -- moyenne des fréquences
    ) with
        Pre => Borne > 1 and Taille > 1,
        Post => 0 <= Min and Min <= Taille
            and 0 <= Max and Max <= Taille
            and Min + Max <= Taille
            and Moyenne = Float (Taille) / Float (Borne)
            and Float (Min) <= Moyenne and Moyenne <= Float (Max)
    is
        package Mon_Alea is
            new Alea (1, Borne);
        use Mon_Alea;

        type Tabn is array (1..Taille) of Integer;
        tab1: Tabn;
        type Tabf is array (1..Borne) of Integer;
        tab2 : Tabf;
        Nombre : Integer;

    begin
        --Construction du tableau de l'échantillon et des fréquences
        for i in 1..Taille loop
            Get_Random_Number(Nombre);
            tab1(i):=Nombre;
        end loop;
        for i in 1..Borne loop
            tab2(i):=0;
            for j in 1..Taille loop
                if tab1(j)= i then
                    tab2(i):=tab2(i)+1;
                end if;
            end loop;
        end loop;
        Max:= tab2(1);
        Min:= tab2(1);
        Moyenne:=Float(Taille) / Float(Borne);
        for i in 1..Borne loop
            if tab2(i) > Max then
                Max:= tab2(i);
            end if;
            if tab2(i) < Min then
                Min:= tab2(i);
            end if;
        end loop;


    end Calculer_Statistiques;


    -- Afficher les données statistiques
    -- Paramètres:
    --   Min, Max : in Entier -- le min et le max
    --   Moyenne : in Réel -- la moyenne
    procedure Afficher_Statistiques (Min, Max: Integer; Moyenne: in Float) is
    begin
        Put_Line ("Min     =" & Integer'Image (Min));
        Put_Line ("Max     =" & Integer'Image (Max));
        Put ("Moyenne = ");
        Put (Moyenne, 1, 2, 0);
            -- Put d'un réel accepte trois paramètres supplémentaires
            -- le nombre de positions à utiliser avant le '.' (ici 1)
            -- le nombre de positions pour la partie décimale (ici 2)
            -- le nombre de positions pour l'exposant (ici 0)
        New_Line;
    end Afficher_Statistiques;


    Min, Max: Integer; -- fréquence minimale et maximale d'un échantillon
    Moyenne: Float;    -- fréquences moyenne de l'échantillon
begin
    -- Calculer les statistiques pour un dé à 6 faces et un petit échantillon
    --Calculer_Statistiques (6,20, Min, Max, Moyenne);
    --Afficher_Statistiques (Min, Max, Moyenne);
    --New_Line;

    --Calculer les statistiques pour un dé à 6 faces et un échantillon grand
    --Calculer_Statistiques (6, 10000, Min, Max, Moyenne);
    --Afficher_Statistiques (Min, Max, Moyenne);
    --New_Line;

  --Calculer les statistiques pour un dé à 6 faces et un échantillon
  -- très grand
  --Calculer_Statistiques (6, 10e6, Min, Max, Moyenne);                     On a une erreur de stockage.
    --Afficher_Statistiques (Min, Max, Moyenne);
    --New_Line;
--
--  -- Calculer les statistiques pour un dé à 6 faces et un échantillon
    -- très, très grand
    Calculer_Statistiques (6, 10e8, Min, Max, Moyenne);
    Afficher_Statistiques (Min, Max, Moyenne);
    New_Line;
end Evaluer_Alea;





