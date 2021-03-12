generic
    type T_Element is private;

package Ensembles_Chainage is

    type T_Ensemble is limited private;

    --Initialiser un ensemble
    procedure Initialiser(E:out T_Ensemble) with
        Post => Est_Vide(E);

    --Détruire l'ensemble
    procedure Detruire(E:in out T_Ensemble);

    --Savoir si un ensemble est vide
    function Est_Vide(E:in T_Ensemble) return Boolean;

    --Obtenir la taille d'un ensemble
    function Obtenir_Taille(E:in T_Ensemble) return Integer;

    --Savoir si un élément est présent dans un ensemble
    function Est_Present(E:in T_Ensemble; element: in T_Element) return Boolean;

    --Ajouter un élément dans un ensemble
    procedure Ajouter(E:in out T_Ensemble; element: in T_Element) with
        Pre => Est_Present(E,element)=False;

    --Supprimer un élément d'un ensemble
    procedure Supprimer(E: in out T_Ensemble; element: in T_Element) with
            Pre => Est_Present(E,element) = True;

    --Appliquer une opération sur tous les éléments du tableau
    generic
        with procedure Operation(a:in out T_Element);
    procedure Appliquer_Sur_Tous(E: in out T_Ensemble);


private
    type T_Cellule;
    type T_Ensemble is access T_Cellule;
    type T_Cellule is
    record
        Element: T_Element;
        Suivant: T_Ensemble;
        end record;
end Ensembles_Chainage;
