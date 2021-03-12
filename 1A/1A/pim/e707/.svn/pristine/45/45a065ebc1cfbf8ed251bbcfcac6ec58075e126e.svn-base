with Arbre_genealogique;
use Arbre_genealogique;
with lien;
use lien;
with registre;
use registre;
package foret is

    Est_Absent_Arbre : exception;

    Est_Present_Arbre :  exception;

    type T_foret is limited private;

   -- Initialiser la forêt.
   procedure initialiser_foret(F : out T_foret);


   --Afficher la forêt.
    procedure afficher_Foret(F : in T_foret);


    --Ajouter un arbre dans la foret
    procedure Ajouter_Foret(F: in out T_Foret;Element:in T_Arbre_gen);


    --Vider la foret
    procedure Vider_Foret(F:in out T_Foret);


    --Indique si un arbre est présent dans la foret
   function Est_Present_Foret(F: in T_Foret; Cle: in Integer) return Boolean;


    function longueur_Foret(F:in T_Foret) return Integer;


    function obtenir_Arbre(F: in T_Foret;Cle : in Integer) return T_Arbre_Gen;

private
    type T_Cellule_F;

    type T_Foret is access T_Cellule_F;
    type T_Cellule_F is
        record
        A: T_Arbre_Gen;
        suivant : T_Foret;
        end record;

end foret;
