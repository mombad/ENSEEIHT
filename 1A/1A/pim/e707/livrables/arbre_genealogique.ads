--Spécification du module arbre généalogique
with lien;
use lien;
with registre;
use registre;
--generic
   -- type T_Arbre_Gen is private;

Package Arbre_genealogique is

    type T_Liste is limited private; 
    
    subtype T_Arbre_Gen is T_Arbre_Binaire;

    
    --Initialise l'arbre généalogique
    procedure Initialiser_Arbre_Gen(A : out T_Arbre_Gen;Cle: in Integer);


    --Ajoute un parent dans l'arbre au noeud clé enfant et l'ajoute aussi dans le registre 
    procedure Ajouter_Arbre_Gen(A: in out T_Arbre_Gen;R: in out T_Registre; Cle_parent: in Integer ;Cle_enfant: in Integer; Choix: in boolean);
    --Exception Est_Absent_Cle dans le cas ou Cle_enfant n'existe pas.
    --Exception Est_Present_Cle dans le cas ou le parent existe déja.

    
    --Renvoie le nombre d'ancêtres connus d'un individu lui compris
    function Obtenir_nb_ancetres(A: in T_Arbre_Gen; Cle: in Integer) return Integer;
      --Exception Est_Absent_Cle dans le cas ou Cle n'existe pas.

    --Renvoie le nombre d'ancêtres connus d'un individu à une génération donnée
    function Obtenir_nb_ancetres_Gen(A : in T_Arbre_Gen; Cle: in Integer; Gen : in Integer) return T_Liste;
      --Exception Est_Absent_Cle dans le cas ou Cle n'existe pas.

    --Affiche l'arbre généalogique
    procedure Afficher_Arbre_Gen(A : in T_Arbre_Gen; Cle : in Integer);
      --Exception Est_Absent_Cle dans le cas ou Cle n'existe pas.

    --Supprime un noeud ainsi que tous ses ancêtres
    procedure Supprimer_Noeud_Gen(A : in out T_Arbre_Gen; Cle : in Integer; R: in out T_Registre);
      --Exception Est_Absent_Cle dans le cas ou Cle n'existe pas.

    --Renvoie la liste de tous les individus dont un seul parent est connu
    function Un_Parent(A: in T_Arbre_Gen) return T_Liste;

    --Renvoie la liste de tous les individus dont les 2 parents sont connus
    function Deux_Parents(A:in T_Arbre_Gen) return T_Liste;

    --Renvoie la liste de tous les individus dont aucun parent n'est connu
    function Aucun_Parent(A : in T_Arbre_Gen) return T_Liste;

    --Renvoie la liste de tous les ancêtres connus d'un individu à une génération donnée
    function Ancetres_Gen(A : in T_Arbre_Gen;Cle:in Integer; Gen: in Integer) return T_Liste;

    --Renvoie la liste des ancêtres homonymes de deux individus connus
    function Homonyme(A: in T_Arbre_Gen;R: in T_Registre; n: in Integer; m: in Integer) return T_Liste;

    --Détruit un arbre
    procedure Detruire(A:in out T_Arbre_Gen);   
    
    --Indique si un individu est présent dans l'arbre
    function Est_Present_Gen(A: in T_Arbre_Gen; Cle: in Integer) return Boolean;

    --Renvoie la liste de tous les ancêtres d'un individu
    procedure Obtenir_Tous_Les_Ancetres(A : in T_Arbre_Gen ; L : in out T_Liste);

    
    
    --Manipulation des listes
    
    --Initialise une liste
    procedure Initialiser_Liste(L: out T_Liste);
    
    --Affiche la liste
    procedure Afficher_Liste(L:in T_Liste);
    
    --Ajoute un élément à la liste
    procedure Ajouter_Liste(L: in out T_Liste;Element:in Integer);
    
    --Vide la liste
    procedure Vider_Liste(L:in out T_Liste);
    
    --Indique si un élément est présent dans la liste
    function Est_Present_Liste(L: in T_Liste; Element: in Integer) return Boolean;
    
    --Renvoie la longueur de la liste
    function Longueur_Liste(L:in T_Liste) return Integer;
 
    --Renvoie l'élément de la cellule courante
    function obtenir_element(L: in T_Liste) return Integer;
 
    --Indique si la liste est vide
   function est_vide_liste(L : in T_Liste) return boolean;

    --Fusionne deux listes
    procedure fusionner (L1: in out T_Liste; L2: in T_Liste);

    --Egalise L1 et L2
    procedure egal_liste(L1: in out T_Liste; L2: in T_Liste);

    --function obtenir_Cle_Liste(L : T_Liste) return Integer;

    --Renvoie la sous liste suivante
    function obtenir_suivant_liste(L : T_Liste) return T_Liste;



private
    
    type Cellule;

    type T_Liste is access cellule;
    
    type cellule is 
        record
        Cle: Integer;
        suivant : T_Liste;
        end record; 
    
    
end Arbre_genealogique;

    
            
            
        
