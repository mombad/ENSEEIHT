--Spécification du module arbre binaire
generic
    type T_Cle is private;


Package Arbre_Binaire is

    Est_Absent_Cle : exception;

    Est_Present_Cle :  exception;

    Est_occupe_noeud : exception;

    Type T_Arbre_Binaire is private;


    --Initialise l'arbre binaire
    procedure Initialiser_Arbre(A : out T_Arbre_Binaire; Cle : in T_Cle);


    --Détruit l'arbre binaire
    procedure Detruire_arbre(A: in out T_Arbre_Binaire);


    --Ajoute la clé parent au noeud clé enfant en fonction du choix
    procedure Ajouter(A: in out T_Arbre_Binaire; Cle_parent: in T_Cle; Cle_enfant: in T_Cle; choix: in Boolean);
    --Exception Est_Absent_Cle dans le cas ou Cle_enfant n'existe pas.
    --Exception Est_Present_Cle dans le cas ou le parent existe déja.


    --Supprime un noeud ainsi que tout le sous-arbre associé à ce noeud
    procedure Supprimer_Noeud(A : in out T_Arbre_Binaire; Cle : in T_Cle);
    --Exception Est_Absent_Cle dans le cas ou Cle n'existe pas.


    --Indique si une clé est présente dans l'arbre en renvoyant un booléen
    function Est_Present(A: in T_Arbre_Binaire; Cle: in T_Cle) return Boolean;


    --Procédure générique à instancier permettant d'afficher l'arbre
    generic
        with procedure Afficher(Cle: in T_Cle; esp: in integer);
    procedure Afficher_Arbre(A : in T_Arbre_Binaire);
    --Exception Est_Absent_Cle dans le cas ou Cle n'existe pas.


    --Renvoie le sous-arbre gauche de l'arbre en paramètre
    function gauche (A: in T_Arbre_Binaire) return T_Arbre_Binaire;


    --Renvoie le sous-arbre droit de l'arbre en paramètre
    function droite (A: in T_Arbre_Binaire) return T_Arbre_Binaire;


    --Renvoie la clé du noeud en paramètre
    function Obtenir_Cle (A : in T_Arbre_Binaire) return T_Cle;


    --Affecte à A1 l'arbre A2
    procedure egal (A1: out T_Arbre_Binaire; A2: in T_Arbre_Binaire);


    --Teste l'égalité entre A1 et A2
    function est_egal (A1: in T_Arbre_Binaire; A2: in T_Arbre_Binaire) return Boolean;


    --Affecte à A1 le pointeur null
    function est_egal_null (A1: in T_Arbre_Binaire) return Boolean;


    --Cherche le noeud associé à la clé en paramètre et affecte à Noeud ce noeud
    procedure chercher_noeud (A: in T_Arbre_Binaire; Noeud : in out T_Arbre_binaire; Cle : in T_Cle);


    --Teste l'égalité entre le A et le pointeur null
    procedure egal_null(A:in out T_Arbre_Binaire);


    --Renvoie la clé du noeud
    procedure egal_cle(A: in out T_Arbre_binaire; Cle : in T_Cle);


private

    Type T_Cellule_Arbre;

    Type T_Arbre_Binaire is access T_Cellule_Arbre;

    Type T_Cellule_Arbre is
        record
            Cle: T_Cle;
            gauche: T_Arbre_Binaire;
            droite: T_Arbre_Binaire;
        end record;

end arbre_binaire;
