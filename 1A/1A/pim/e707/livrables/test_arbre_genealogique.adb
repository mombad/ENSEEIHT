with arbre_genealogique;
use arbre_genealogique;
with registre;
use registre;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

procedure tests_arbre_genealogique is
    A:T_Arbre_Gen;
    R:T_Registre;
    L,d1,d2,d3,d4,d5,d6:T_Liste;
    infostr:String(1..10);
begin

    initialiser_Liste(L);

    infostr:="Nom : Jojo";
    Initialiser_Arbre_Gen(A,5);
    Initialiser_R(R);
    Ajouter_R_individu(R,5);


    Ajouter_Arbre_Gen(A,R,10,5,True);
    Ajouter_Arbre_Gen(A,R,3,5,False);
    Ajouter_Arbre_Gen(A,R,4,3,False);
    Ajouter_Arbre_Gen(A,R,101,10,True);


    Afficher_Arbre_Gen(A,5);

    ajouter_r_info_auto(R,101,infostr);
    ajouter_r_info_auto(R,4,infostr);


    Put("Liste un parent");
    egal_liste(L,Un_Parent(A));
    afficher_Liste(L);

    New_Line;

    Put("Liste 2 parents");
    egal_liste(d1,L);
    egal_liste(L,Deux_Parents(A));
    vider_Liste(d1);
    Afficher_Liste(L);

    New_Line;


    Put("Liste Aucun parent");
    egal_liste(d2,L);
    egal_liste(L,Aucun_Parent(A));
    Vider_Liste(d2);

    Afficher_Liste(L);

    New_Line;

    Put("Liste ancetres gen(1)");
    egal_liste(d3,L);
    egal_liste(L,Ancetres_gen(A,5,1));
    Vider_Liste(d3);
    Afficher_Liste(L);

    New_Line;

    Put("Nombre d'ancetres de 5 lui compris");
    Put(Obtenir_nb_ancetres(A,5));
    New_Line;
    New_Line;
    New_Line;
    New_Line;
    New_Line;
    New_Line;
    New_Line;
    New_Line;
    New_Line;

    Put("liste des ancetres de 5 appartenant a la premiere gen");
    New_Line;
    egal_Liste(d5,L);
    egal_liste(L,Obtenir_nb_ancetres_Gen(A,5,2));
    Afficher_Liste(L);
    Vider_Liste(d5);


    Afficher_R(R);
    New_Line;
    New_Line;
    New_Line;
    New_Line;

    Put("Nom de 5 : ");
    Put(Obtenir_Nom(R,5));
    New_Line;
    Put("Nom de 4 : ");
    Put(Obtenir_Nom(R,4));
    New_Line;

    put("Liste des ancêtres homonymes");
    egal_liste(d4,L);
    egal_liste(L,Homonyme(A,R,3,10));
    Afficher_Liste(L);

    Vider_Liste(d4);

    New_Line;
    Obtenir_Tous_Les_Ancetres(A,L);



    supprimer_noeud_gen(A,10,R);
    Afficher_Arbre_gen(A,5);
    Afficher_R(R);

    Vider_Liste(L);
    Detruire(A);
    Detruire_R(R);
end tests_arbre_genealogique;
