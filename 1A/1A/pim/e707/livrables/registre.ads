--Spécification du module registre
With lien;
use lien;
Package Registre is
    
    subtype NSTR is String(1..45);

    type T_Info is limited private;
    
    Type T_Liste_R is limited private;

    Type T_Registre is limited private;

    
    -- Initialiser le registre.
    procedure Initialiser_R(R: out T_Registre);


     --Détruit un registre.
    procedure Detruire_R(R:in out T_Registre);


    --Supprime toutes les informations connues pour un individu donné.
    procedure Detruire_Information(I:in out T_Info);


    --Vérifier si le registre est vide
    function Est_Vide_R(R:in T_Registre) return Boolean;


    --Indique si une clé est présente ou non dans le registre.
    function Est_Present_R(R:in T_Registre; Cle:in Integer) return Boolean;


    --Ajouter un individu.
    procedure Ajouter_R_individu(R: in out T_Registre;Cle: in Integer);
    --Exception Est_Present_Cle si l'individu existe déjà.


    --Ajouter une information.
    procedure Ajouter_R_info(R: in out T_Registre;Cle: in Integer);
    -- Exception Est_Absent_Cle si la cle n'est pas dans le registre.


    --Supprimer un individu.
    procedure Supprimer_R_individu(R:in out T_Registre; Cle:in Integer);
    -- Exception Est_Absent_Cle si la clé n'existe pas.


    --Supprimer une information.
    procedure Supprimer_R_information(R:in out T_Registre; Cle:in Integer);
    -- Exception Est_Absent_Cle si la clé n'existe pas.


    --Afficher toutes les clés des individus présents dans le registre.
    procedure Afficher_R(R:in T_Registre);


    --Afficher toutes les informations d'un individu donné.
    procedure Afficher_info(R:in T_Registre; Cle:in Integer);


    --Retourne le nombre d'informations connues pour un individu donné
    function Nb_info(R:in T_Registre; Cle:in Integer) return Integer;
   
    
    --Renvoie le nom d'un individu donné
    function Obtenir_Nom(R:in T_Registre; Cle:in Integer) return NSTR;
    -- Exception Est_Absent_Cle si la clé n'existe pas.

       
    --Renvoie l'individu suivant la cellule courante du registre   
    function suivant(R: in T_Registre) return T_Registre;

    
    --Renvoie la clé de la cellule courante du registre   
    function Obtenir_Cle_R(R: in T_Registre) return Integer;
  
   
    --Test l'égalité entre un pointeur T_Registre et le pointeur nul
    function est_egal_null_R(R: in T_Registre) return boolean;
    
   
    --Affecte à R1 la valeur R2
    procedure egal_R(R1:in out T_Registre; R2: in T_Registre);

    
    --Ajoute une info directement dans le registre
    procedure Ajouter_R_info_auto(R: in out T_Registre; Cle: in Integer; infostr: in out String);
  
    
    --Renvoie la liste des conjoints
    function Obtenir_conjoint(R:in T_Registre; Cle:in Integer) return T_Liste_R ;

    
    --Renvoie la liste des frères ou soeurs d'un individus
    function Obtenir_frere(R:in T_Registre; Cle:in Integer) return T_Liste_R;

    
    --Relier deux arbres par la relation de conjugalité   
    procedure conjoint(Cle1 : in Integer;Cle2: in Integer; R : in out T_Registre );

       
    --Relier deux arbres par la relation de fraternité
    procedure frere(Cle1 : in Integer;Cle2: in Integer; R : in out T_Registre );
    
    
    --Renvoie la liste des beaux-frères ou belles soeurs d'un individu
    function obtenir_beau_frere( R : in out T_Registre; Cle : in Integer) return T_Liste_R;

    
    
    --Manipulation des listes
    
    
    --Initialise une liste
    procedure Initialiser_Liste_R(L: out T_Liste_R);
    
    --Affiche la liste
    procedure Afficher_Liste_R(L:in T_Liste_R);
    
    --Ajoute un élément à la liste
    procedure Ajouter_Liste_R(L: in out T_Liste_R;Element:in Integer);
    
    --Vide la liste
    procedure Vider_Liste_R(L:in out T_Liste_R);
    
    --Indique si un élément est présent dans la liste
    function Est_Present_Liste_R(L: in T_Liste_R; Element: in Integer) return Boolean;
    
    --Renvoie la longueur de la liste
    function Longueur_Liste_R(L:in T_Liste_R) return Integer;
 
    --Renvoie l'élément de la cellule courante
    function obtenir_element_R(L: in T_Liste_R) return Integer;
 
    --Indique si la liste est vide
   function est_vide_liste_R(L : in T_Liste_R) return boolean;

    --Fusionne deux listes
    procedure fusionner_R (L1: in out T_Liste_R; L2: in T_Liste_R);

    --Egalise L1 et L2
    procedure egal_liste_R(L1: in out T_Liste_R; L2: in T_Liste_R);

    --Renvoie la sous liste suivante
    function obtenir_suivant_liste_R(L : T_Liste_R) return T_Liste_R;


    
    
    
    
private

    Type T_Cellule_Registre;

    Type T_Registre is access T_Cellule_Registre;

    Type T_Cellule_Registre is
        record
            Cle: Integer;
            Information : T_Info;
            suivant: T_Registre;
        end record;

    Type T_Cellule_Info;

    Type T_Info is access T_Cellule_Info;

    Type T_Cellule_Info is
        record
            info: NSTR;
            infosuivante : T_Info;
        end record;
    
    
      type T_Cellule_Liste_R;

    type T_Liste_R is access T_Cellule_Liste_R;
    
    type T_Cellule_Liste_R is 
        record
        Cle: Integer;
        suivant : T_Liste_R;
        end record; 
    

end Registre;

