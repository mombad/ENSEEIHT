with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

-- Objectif : Afficher un tableau trié suivant le principe du tri par sélection.

procedure Tri_Selection is

    CAPACITE: constant Integer := 10;   -- la capacité du tableau

    type Tableau_Entier is array (1..CAPACITE) of Integer;

    type Tableau is
        record
            Elements : Tableau_Entier;
            Taille   : Integer;         --{ Taille in [0..CAPACITE] }
        end record;


    -- Objectif : Afficher le tableau Tab.
    -- Paramètres :
    --     Tab : le tableau à afficher
    -- Nécessite : ---
    -- Assure : Le tableau est affiché.
    procedure Afficher (Tab : in Tableau) is
    begin
        Put ("[");
        if Tab.Taille > 0 then
            -- Afficher le premier élément
            Put (Tab.Elements (1), 1);

            -- Afficher les autres éléments
            for Indice in 2..Tab.Taille loop
                Put (", ");
                Put (Tab.Elements (Indice), 1);
            end loop;
        end if;
        Put ("]");
    end Afficher;


    Tab1 : Tableau;
    min : Integer;
    P : Integer;
begin
    -- Initialiser le tableau

    Tab1 := ( (1, 3, 4, 2, others => 0), 4);
    for i in 1..Tab1.Taille loop
        min:=i;
        for j in i..Tab1.Taille loop
            if Tab1.Elements(min) > Tab1.Elements(j) then
                min:=j;
            else
                null;
            end if;
        end loop;
        P:=Tab1.Elements(min);
        Tab1.Elements(min):=Tab1.Elements(i);
        Tab1.Elements(i):= P;
    end loop;


    -- Afficher le tableau
    Afficher (Tab1);
    New_Line;

end Tri_Selection;


--Sous programme de test

procedure test(Tab1,Tab2 : Tableau) is
    Tab3: Tableau;
    j: Integer
begin
    --test1
    for i in 1..(Taille-1) loop
        if Tab2.Elements(i)>Tab2.Elements(i+1) then
            Put("Il y a une erreur de tri au ");
            Put(i);
            Put("ème élément du tableau");
        end if;
    end loop;
    --test2a
    if Tab1.Taille /= Tab2.Taille then
        Put("Les tableaux ne sont pas de la même taille");
    end if;
    --test2b
        Tab3:=Tab1;
        for i in 1..Tab2.Taille loop
            j:=0;
            while Tab3.Taille(j)/=Tab2.Taille(i) loop
                j:=j+1;
            end loop;
            if j< Tab2.Taille+1 then
                Tab3.Elements(j):=999999999;
            else
                Put("La valeur ");
                Put(Tab2.Elements(i));
                Put(" n'a pas été trouvée");
            end if;
        --Si le tableau 3 est un tableau rempli de 999999999 alors les tab 1 et 2 contiennent les memes elements.
        end loop;






