with registre;
use registre;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

procedure tests_registre is 
    R: T_Registre;
    info: String(1..3);
    L: T_Liste_R;
begin
    info:="lol";
    Initialiser_R(R);   
    
    Ajouter_R_individu(R,1);    
    Ajouter_R_info_auto(R,1,info);
    
    Ajouter_R_individu(R,2);
    Ajouter_R_info_auto(R,2,info);
    
    
    Ajouter_R_individu(R,4);
    

    Ajouter_R_individu(R,3);

    Conjoint(1,2,R);
    frere(2,3,R);
    frere(2,4,R);
    
    Afficher_R(R);
    
    New_Line;
    New_Line;
    New_Line;
    
    initialiser_Liste_R(L);
    egal_liste_R(L,Obtenir_beau_frere(R,1));
    Afficher_Liste_R(L);    
    Detruire_R(R);
    Vider_Liste_R(L);
    
  
  
    
end tests_registre;
            
        

