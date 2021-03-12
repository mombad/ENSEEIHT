--------------------------------------------------------------------------------
--  Auteur   : BEN AHMED DAHO Mohamed ; groupe N
--  Objectif : Permettre à l'utilisateur de s'exercer les tables de multiplications.
--L'utilisateur choisit la table à réviser et le programme lui pose 10 questions.Le programme
--conseille l'utilisateur sur les tables à retravailler en fonction du nombre d'erreurs et 
--du temps de réponse.
--------------------------------------------------------------------------------

with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Calendar;          use Ada.Calendar;
with Alea;

procedure Multiplications is
    --Définition des variables entières
    Numero_table, Bonnes_reponses, Nb_droite, nb_d, reponse, resultat: Integer;   --nb_d est la variable qui stocke le nombre tiré aléatoirement
                                                                                  --et NB_droite est la variable qui stocke le nombre de droite de la question pour laquelle on a un temps de réponse maximal.
    Rejouer: Boolean;
    Tmax, Ttot, t: Duration;
    Debut, Fin: Time;
    Oui: Character;
--Préparation du package alea
    package Mon_Alea is
            new Alea (1, 10);
    use Mon_Alea;

begin
    

    
    loop
        --Initialisation des variables
        Ttot :=0.0;
        Tmax :=0.0;
        Numero_table :=0;
        Bonnes_reponses :=0;
        Rejouer:= True;
        --Choix de la table de multiplication
        loop
            Put_Line("Veuillez entrer un nombre entre 1 et 10 ");
            Get(Numero_table);
            exit when Numero_table>0 and Numero_table<11;
        end loop;
        Put("Vous avez choisi la table de ");
        Put(Numero_table, Width =>0);
        New_Line;
        --Début de la série de questions 
        for i in 1..10 loop
            --Choisir aléatoirement un calcul et afficher la question
            Get_Random_Number (nb_d);
            resultat := Numero_table * nb_d;
            Put("Combien font ");
            Put(Numero_table, Width => 0);
            Put(" x ");
            Put(nb_d, Width => 0);
            Put_Line(" ?");
            --Calcul du temps de réponse
            Debut := Clock;
            Get(reponse);
            Fin := Clock;
            t :=Fin - Debut;
            Ttot := Ttot + t;
            if t > Tmax then
                Tmax :=t;
                Nb_droite:=nb_d;
            else
                null;
            end if;
            --Correction
            if reponse = resultat then
                Bonnes_reponses := Bonnes_reponses + 1;
                Put_Line("Bravo !");
            else
                Put("Mauvaise réponse ! La bonne réponse est ");
                Put(resultat, Width => 0);
                New_Line;
            end if;
        end loop;
        New_Line;
        --Conseiller l'utilisateur
             --par rapport au nombre de bonnes réponses
        case Bonnes_reponses is
            when 10 =>
                Put_Line("Aucune erreur. Excellent");
                New_Line;
            when 9 =>
                Put_Line("Une seule erreur. Très bien");
                New_Line;
            when 0 =>
                Put_Line("Tout est faux. Volontaire ?");
                New_Line;
            when 1..4 =>
                Put("Seulement ");
                Put(Bonnes_reponses, Width => 0);
                Put(" bonnes réponses. Il faut apprendre la table de ");
                Put(Numero_table, Width => 0);
                New_Line;
            when others =>
                Put(10-Bonnes_reponses, Width =>0);
                Put(" erreurs. Il faut encore travailler la table de ");
                Put(Numero_table, Width => 0);
                New_Line;
        end case;
             --par rapport au temps de réponse
        if Tmax > (Ttot/10)+1.0 then
            Put("Vous pouvez aussi réviser la table de ");
            Put(Nb_droite, Width => 0);
            New_Line;
        else
            null;
        end if;
        --On demande à l'utlisateur s'il veut rejouer
        Put_Line("Voulez-vous retenter ?");
        New_Line;
        Put_Line("Entrez n pour quitter");
        Put_Line("Entrez n'importe quelle autre lettre pour retenter");
        Get(Oui);
        if Oui = 'n'then
            Put_Line("Au revoir");
            Rejouer:=False;
        else
            New_Line;
            Put_Line("On recommence");
        end if;
            exit when Rejouer=False;
        end loop;
                    
end Multiplications;
