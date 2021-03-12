with Ada.Unchecked_Deallocation;

package body Ensembles_Chainage is

    procedure Free is
            new Ada.Unchecked_Deallocation (T_Cellule, T_Ensemble);

    procedure Initialiser (E : out T_Ensemble) is
	begin
        E := Null;
    end Initialiser;


    procedure Detruire(E: in out T_Ensemble) is
    begin
        if E /= Null then
            Detruire (E.all.Suivant);
            Free (E);
        else
            Null;
        end if;
	end Detruire;



    function Est_Vide(E : in T_Ensemble) return Boolean is
    begin
        return E = Null;
    end Est_Vide;


    function Obtenir_Taille(E:in T_Ensemble) return Integer is
        E0:T_Ensemble;
        n:Integer;
    begin
        E0:=E;
        n:=0;
        while E0/=null loop
            n:=n+1;
            E0:=E0.all.Suivant;
        end loop;
        return n;
    end Obtenir_Taille;


    function Est_Present(E:in T_Ensemble; element: T_Element) return Boolean is
    begin
        if E=null then
            return False;                        --on a atteint la fin de l'ensemble sans avoir trouvé l'element
        else
            if E.all.Element=element then
                return True;                        --on a trouvé l'élément
            else
                return Est_Present(E.all.Suivant, element);            --on a ni trouvé l'élément ni atteint la fin de l'ensemble
            end if;                                                    --donc on appelle la fonction sur le pointeur suivant
        end if;
    end Est_Present;


    procedure Ajouter(E: in out T_Ensemble; element: in T_Element) is
        E0: T_Ensemble;
    begin
        if Est_Vide(E) then                        --si E est vide on crée une cellule contenant l'élément 
            E:=new T_Cellule;
            E.all.Element:=element;
        else
            if Est_Present(E,element) then
                null;
            else
                E0:=E;
                while E0.all.Suivant/=null loop       --sinon on va à la derniere cellule et on cree une nouvelle cellule contenant l'element
                    E0:=E0.Suivant;                  --puis on l'associe a l'ensemble
                end loop;
                E0.all.Suivant := new T_Cellule;
                E0.all.Suivant.Element := element;
                E0:=null;
                Detruire(E0);
            end if;
        end if;
    end Ajouter;


    procedure Supprimer(E:in out T_Ensemble; element: in T_Element) is
        E1: T_Ensemble;
    begin
        if E.all.Suivant/=null then                          --si on n'est pas à la fin de l'ensemble
            if E.all.Suivant.all.Element/=element then       --et que l'element suivant n'est pas l'element recherche
                if E.all.Element=element then                --on regarde si on l'element courant est l'element recherche
                    E1 := E;                                 --si oui on le supprime
                    E := E.all.Suivant;
                    Free(E1);
                else
                    Supprimer(E.all.Suivant,element);        --sinon on regarde l'element suivant
                end if;
            else
                E1 := E.all.Suivant;                         --dans le cas où l'element recherche est l'element suivant l'element courant
                E.all.Suivant := E.all.Suivant.all.Suivant;  --on associe l'element courant a l'element suivant l'element recherche
                Free(E1);                                    --on supprime enfin l'element recherche
            end if;
        else
            null;
        end if;
    end Supprimer;


    procedure Appliquer_Sur_Tous(E:in out T_Ensemble) is
    begin
        if E/=null then
            Operation(E.all.Element);               --on applique l'operation sur l'element courant et on appelle la fonction sur l'element suivant
            Appliquer_Sur_Tous(E.all.Suivant);
        else
            null;
        end if;
    end Appliquer_Sur_Tous;



end Ensembles_Chainage;
