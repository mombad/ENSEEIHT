package body Ensembles_Tableau is


    procedure Initialiser (E : out T_Ensemble) is
    begin
        E.Taille:=0;
    end Initialiser;


    procedure Detruire (E: in out T_Ensemble) is
        begin
            E.Taille:=0;
    end Detruire;


    function Est_Vide(E:in T_Ensemble) return Boolean is
    begin
        if E.Taille = 0 then
            return True;
        else
            return False;
        end if;
    end Est_Vide;


    function Obtenir_Taille(E:in T_Ensemble) return Integer is
    begin
        return E.Taille;
    end Obtenir_Taille;


    function Est_Present(E:in T_Ensemble; element: in T_Element) return Boolean is
        i : Integer;
    begin
        i:=0;
        loop                                  --on parcourt le tableau à la recherche de l'element
            i:=i+1;
            exit when i>E.Taille or E.Tab(i)=element;
        end loop;
        if i> E.Taille then
            return False;
        else
            return True;
        end if;
    end Est_Present;


    procedure Ajouter(E:in out T_Ensemble; element: in T_Element) is
    begin
        E.Tab(E.Taille+1):=element;         --on ajouter l'element a la i-eme case du tableau
        E.Taille:=E.Taille+1;
    end Ajouter;


    procedure Supprimer(E: in out T_Ensemble; element: in T_Element) is
        i : Integer;
    begin
        i:=0;
        loop
            i:=i+1;
            exit when E.Tab(i)=element;     --on parcourt le tableau a la recherche de l'element
        end loop;
        E.Tab(i):=E.Tab(E.Taille);          --on affecte a l'element courant la valeur du dernier element du tableau
        E.Taille:= E.Taille-1;              --et on diminue la taille de 1
    end Supprimer;


    procedure Appliquer_Sur_Tous(E: in out T_Ensemble) is
    begin
        for i in 1..E.Taille loop
            Operation(E.Tab(i));
        end loop;
    end Appliquer_Sur_Tous;






end Ensembles_Tableau;
