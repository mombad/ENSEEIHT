--Implantation du module arbre binaire

with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;
with Piles;

Package body arbre_binaire is

    Package Piles_Arbre is
            new Piles(T_Element => T_Arbre_Binaire);
    use Piles_Arbre;


    procedure Free is
            new Ada.Unchecked_Deallocation (Object => T_Cellule_Arbre, Name => T_Arbre_Binaire);




    Procedure Initialiser_Arbre (A: out T_Arbre_Binaire;Cle : in T_Cle) is
    begin
        A := New T_Cellule_Arbre;
        --arbre n'est pas à null à l'initialisation.
        A.all.gauche := Null;
        A.all.droite := Null;
        A.all.Cle := Cle;
    end Initialiser_Arbre;




    procedure Detruire_arbre(A: in out T_Arbre_Binaire) is
    begin
        if A = Null then
            Null;

        else
            detruire_arbre(A.all.gauche);
            detruire_arbre(A.all.droite);
            Free(A);
        end if;
    end Detruire_arbre;




    procedure Ajouter(A: in out T_Arbre_Binaire; Cle_parent: in T_Cle; Cle_enfant: in T_Cle; choix: in Boolean) is
        P: T_Pile;
        Noeud : T_Arbre_Binaire;
        A1 : T_Arbre_Binaire;
    begin
        Noeud := new T_Cellule_Arbre;
        Noeud.all.Cle := Cle_parent;
        Noeud.all.gauche := null;
        Noeud.all.droite := null;
        A1 :=A;
        initialiser(P);
        empiler(P,A);

        if est_present(A,Cle_parent) then
            raise Est_Present_Cle;
        end if;


        while not est_vide(P) and A1.all.Cle /= Cle_enfant loop
            A1 := sommet(P);
            depiler(P);
            if A1.all.droite /= null then
                empiler(P,A1.all.droite);
            else
                null;
            end if;

            if A1.all.gauche /= null then
                empiler(P,A1.all.gauche);

            else
                null;
            end if;

        end loop;

        if A1.all.Cle = Cle_enfant then
            if choix then
                if A1.all.gauche = null then
                    A1.all.gauche := Noeud;
                else
                    raise Est_occupe_noeud;
                end if;
            else
                if A1.all.droite = null then
                    A1.all.droite := Noeud;
                else
                    raise Est_occupe_noeud;
                end if;
            end if;
        else
            raise Est_Absent_Cle;
        end if;
        Detruire(P);
    end Ajouter;




    procedure chercher_noeud (A: in T_Arbre_Binaire; Noeud : in out T_Arbre_binaire; Cle : in T_Cle) is
        A1 : T_Arbre_Binaire;
        P: T_Pile;
    begin
        A1 :=A;
        initialiser(P);
        empiler(P,A);

        while not est_vide(P) and A1.all.Cle /= Cle loop
            A1 := sommet(P);
            depiler(P);

            if A1.all.droite /= null then
                empiler(P,A1.all.droite);
            else
                null;
            end if;

            if A1.all.gauche /= null then
                empiler(P,A1.all.gauche);
            else
                null;
            end if;

        end loop;


        if A1.all.Cle = Cle then
            Noeud := A1;
        else
            raise Est_Absent_Cle;
        end if;
        Detruire(P);
    end chercher_noeud;




    procedure Afficher_Arbre (A : in T_Arbre_Binaire) is

        procedure Indenter(Decalage : in Integer) is
        begin
            for I in 1..Decalage loop
                Put (' ');
            end loop;
        end Indenter;

        -- Afficher un arbre à la profondeur Profondeur et qui à du côté
        -- indiqué (< pour Gauche et > pour droit, - pour la racine).

        procedure Afficher_Profondeur (A : in T_Arbre_Binaire ; Profondeur : in Integer ; Cote : in String) is
        begin
            if A = Null then
                Null;

            else
                Afficher_Profondeur (A.all.Gauche, Profondeur + 1, "père");
                Indenter (Profondeur * 4);
                Put (Cote & ' ');
                afficher (A.all.Cle,0);
                Put (" : ");
                New_Line;
                Afficher_Profondeur (A.all.Droite, Profondeur + 1, "mère");
            end if;

        end Afficher_Profondeur;

    begin
        Afficher_Profondeur (A, 0, "-");
    end Afficher_Arbre;




    procedure Supprimer_Noeud(A : in out T_Arbre_Binaire; Cle : in T_Cle) is
        A_detruire : T_Arbre_Binaire;
        A1 : T_Arbre_Binaire;
        P: T_Pile;
        b: boolean;
    begin
        A1 :=A;
        initialiser(P);
        empiler(P,A);
        b:= True;
        while not est_vide(P) and b loop

            A1 := sommet(P);
            depiler(P);

            if A1.all.droite /= null and then A1.all.droite.all.Cle /= Cle  then
                empiler(P,A1.all.droite);

            elsif  A1.all.droite /= null and then A1.all.droite.all.Cle = Cle then
                b:= False;
            end if;

            if A1.all.gauche /= null and then A1.all.gauche.all.Cle /= Cle  then
                empiler(P,A1.all.gauche);

            elsif A1.all.gauche /= null and then A1.all.gauche.all.Cle = Cle then
                b := False;
            else
                null;
            end if;

        end loop;

        if  A1.all.gauche /= null and then A1.all.gauche.all.Cle = Cle then
            A_detruire := A1.all.gauche;
            A1.all.gauche := null;
            detruire_arbre(A_detruire);

        else

            if A1.all.droite /= null and then A1.all.droite.all.Cle = Cle then
                A_detruire := A1.all.droite;
                A1.all.droite := Null;
                Detruire_arbre(A1.all.droite);
            else
                raise Est_Absent_Cle;
            end if;

        end if;
        Detruire(P);
    end Supprimer_Noeud;




    function Est_Present(A: in T_Arbre_Binaire; Cle: in T_Cle) return boolean is
        Noeud : T_Arbre_Binaire;
        b : boolean;

        procedure test_exception (A: in T_Arbre_Binaire; Cle: in T_Cle; b:out boolean) is
        begin
            chercher_noeud(A,Noeud,Cle);
            b:=True;
        exception
            when Est_Absent_Cle => b := False;
        end test_exception;

    begin
        test_exception(A,Cle,b);
        return b;

    end Est_present;




    function gauche (A : in  T_Arbre_Binaire) return T_Arbre_Binaire is
    begin
        return A.all.gauche;
    end gauche;




    function Droite (A: in T_Arbre_Binaire) return T_Arbre_Binaire is
    begin
        return A.all.droite;
    end droite;




    function Obtenir_Cle (A: in T_Arbre_Binaire) return T_Cle is
    begin
        return A.all.Cle;
    end Obtenir_Cle;




    procedure egal (A1: out T_Arbre_Binaire ; A2: in T_Arbre_Binaire) is
    begin
        A1 := A2;
    end egal;




    function Est_egal (A1: in T_Arbre_Binaire; A2: in T_Arbre_Binaire) return Boolean is
    begin
        return (A1 = A2);
    end Est_egal;




    function est_egal_null (A1: in T_Arbre_Binaire) return Boolean is
    begin
        return (A1 = Null);
   end est_egal_null;




   procedure egal_null(A: in out T_Arbre_Binaire) is
   begin
      A:= Null;
   end egal_null;




  procedure egal_cle(A: in out T_Arbre_binaire; Cle : in T_Cle) is
   begin
      A.all.Cle := Cle;
   end egal_cle;









end arbre_binaire;
