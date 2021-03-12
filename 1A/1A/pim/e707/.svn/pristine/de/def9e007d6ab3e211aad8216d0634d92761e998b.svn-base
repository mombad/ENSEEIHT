with arbre_genealogique;
use arbre_genealogique;
with registre;
use registre;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with foret;
use foret;

procedure tester_foret is
   F:T_Foret;
   A, A1,A2 : T_Arbre_Gen;
   R : T_Registre;
begin

    Initialiser_R(R);
    Initialiser_Arbre_Gen(A,5);

    Ajouter_R_individu(R,5);


    New_Line;
    Ajouter_Arbre_Gen(A,R,10,5,True);
    New_Line;

    Ajouter_Arbre_Gen(A,R,3,5,False);
    New_Line;

    Ajouter_Arbre_Gen(A,R,4,3,False);
    New_Line;

    Ajouter_Arbre_Gen(A,R,101,10,True);
    New_Line;

    Ajouter_Arbre_Gen(A,R,100,10,False);


    Afficher_Arbre_Gen(A,5);
    New_Line;
    New_Line;
    New_Line;
    New_Line;

    Initialiser_Arbre_Gen(A1,200);
    Ajouter_R_individu(R,200);


    Initialiser_Arbre_Gen(A2,300);
    Ajouter_R_individu(R,300);


    initialiser_foret(F);
    Ajouter_Foret(F,A);
    Ajouter_Foret(F,A1);
    Ajouter_Foret(F,A2);



    New_Line;
    New_Line;
    New_Line;

    Afficher_R(R);


    New_Line;
    New_Line;
    New_Line;


    afficher_Foret(F);
    Detruire_R(R);
    Vider_Foret(F);

end tester_foret;
