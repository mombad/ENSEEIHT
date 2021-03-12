with Ensembles_Tableau;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Test_Ensembles_Tableau is

    package Ensembles_Entier is new Ensembles_Tableau(10,Integer);

    use Ensembles_Entier;

    procedure Operation(a:in out Integer) is
    begin
        Put(a);
    end Operation;

    procedure Afficher is new Appliquer_Sur_Tous(Operation);
    E: T_Ensemble;
begin
    Initialiser(E);


    if Est_Vide(E)=True then          --Premier test est vide
        Put("Est_Vide 1 OK");
    else
        Put("Est_Vide 1 ERREUR");
    end if;
    New_Line;

    for i in 1..5 loop     --Création de l'ensemble {1,2,3,4,5}
        Ajouter(E,i);
    end loop;

    if Est_Vide(E)=False then          --Deuxième test est vide
        Put("Est_Vide 2 OK");
    else
        Put("Est_Vide 2 ERREUR");
    end if;
    New_Line;


    if Est_Present(E,4)=True then        --Test Est_Present
        Put("Est_Present OK");
    else
        Put("Est_Present ERREUR");
    end if;
    New_Line;



    Afficher(E);            --On l'affiche
    New_Line;

    Supprimer(E,3);         --Suppression de 3

    Afficher(E);

    Detruire(E);


end Test_Ensembles_Tableau;
