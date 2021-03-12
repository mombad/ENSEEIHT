with Ensembles_Chainage;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Test_Ensembles_Sujet_Chainage is


	-- Instancier le paquetage Ensembles_Chainage pour avoir un Ensemble
 -- d'entiers
    package Ensembles_Entier is new Ensembles_Chainage(Integer);
    use Ensembles_Entier;


	-- Définir une opération Afficher qui affiche les éléments d'un ensemble
	-- d'entier en s'appuyant sur Appliquer_Sur_Tous.  L'ensemble {5, 28, 10}
	-- sera affiché :
 --           5         28         10
    procedure Operation(a:in out Integer) is
    begin
        Put(a);
    end Operation;


    procedure Afficher is new Ensembles_Entier.Appliquer_Sur_Tous(Operation);


	Ens1 : T_Ensemble;

begin
    -- Créer un ensemble vide Ens1
    Initialiser(Ens1);
    -- Afficher l'ensemble
    Afficher (Ens1);
    New_Line;

    -- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert(Est_Vide(Ens1)=True);
    pragma Assert(Obtenir_Taille(Ens1)=0);
    pragma Assert(Est_Present(Ens1,2)=False);
    pragma Assert(Est_Present(Ens1,5)=False);
    pragma Assert(Est_Present(Ens1,7)=False);
    pragma Assert(Est_Present(Ens1,10)=False);


    -- Ajouter 5 dans Ens1
    Ajouter(Ens1,5);
    -- Afficher l'ensemble
    Afficher (Ens1);
    New_Line;

    -- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert(Est_Vide(Ens1)=False);
    pragma Assert(Obtenir_Taille(Ens1)=1);
    pragma Assert(Est_Present(Ens1,2)=False);
    pragma Assert(Est_Present(Ens1,5)=True);
    pragma Assert(Est_Present(Ens1,7)=False);
    pragma Assert(Est_Present(Ens1,10)=False);


    -- Ajouter 28 puis 10 dans Ens1
    Ajouter(Ens1,28);
    Ajouter(Ens1,10);
    -- Afficher l'ensemble
    Afficher (Ens1);
    New_Line;


    -- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert(Est_Vide(Ens1)=False);
    pragma Assert(Obtenir_Taille(Ens1)=3);
    pragma Assert(Est_Present(Ens1,2)=False);
    pragma Assert(Est_Present(Ens1,5)=True);
    pragma Assert(Est_Present(Ens1,7)=False);
    pragma Assert(Est_Present(Ens1,10)=True);


    -- Ajouter 7 dans Ens1
    Ajouter(Ens1,7);
    -- Afficher l'ensemble
    Afficher (Ens1);
    New_Line;


    -- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert(Est_Vide(Ens1)=False);
    pragma Assert(Obtenir_Taille(Ens1)=4);
    pragma Assert(Est_Present(Ens1,2)=False);
    pragma Assert(Est_Present(Ens1,5)=True);
    pragma Assert(Est_Present(Ens1,7)=True);
    pragma Assert(Est_Present(Ens1,10)=True);


    -- Supprimer 10 en Ens1
    Supprimer(Ens1,10);
    -- Afficher l'ensemble
    Afficher (Ens1);
    New_Line;


    -- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert(Est_Vide(Ens1)=False);
    pragma Assert(Obtenir_Taille(Ens1)=3);
    pragma Assert(Est_Present(Ens1,2)=False);
    pragma Assert(Est_Present(Ens1,5)=True);
    pragma Assert(Est_Present(Ens1,7)=True);
    pragma Assert(Est_Present(Ens1,10)=False);

    -- Supprimer 7 en Ens1
    Supprimer(Ens1,7);

    -- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert(Est_Vide(Ens1)=False);
    pragma Assert(Obtenir_Taille(Ens1)=2);
    pragma Assert(Est_Present(Ens1,2)=False);
    pragma Assert(Est_Present(Ens1,5)=True);
    pragma Assert(Est_Present(Ens1,7)=False);
    pragma Assert(Est_Present(Ens1,10)=False);


    -- Supprimer 5 en Ens1
    Supprimer(Ens1,5);
    -- Afficher l'ensemble
    Afficher (Ens1);
    New_Line;


    -- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert(Est_Vide(Ens1)=False);
    pragma Assert(Obtenir_Taille(Ens1)=1);
    pragma Assert(Est_Present(Ens1,2)=False);
    pragma Assert(Est_Present(Ens1,5)=False);
    pragma Assert(Est_Present(Ens1,7)=False);
    pragma Assert(Est_Present(Ens1,10)=False);

    -- Détruire l'ensemble
    Detruire(Ens1);

end Test_Ensembles_Sujet_Chainage;
