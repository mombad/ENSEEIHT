--Implantation du module arbre généalogique
with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;
with registre;
with lien; use lien;
with piles;


package body Arbre_genealogique is

    -----------------------------------------------------------
    -----------------------Nomanina----------------------------
    -----------------------------------------------------------


    Package Piles_Arbre_gen is
            new Piles(T_Element => T_Arbre_Gen);
    use Piles_Arbre_gen;




    procedure afficher(Cle: in integer;esp : in integer) is
    begin
        put(Cle,esp);
    end afficher;


    procedure afficher_arbre is new lien.Afficher_Arbre(afficher);


    procedure Initialiser_Arbre_Gen(A : out T_Arbre_Gen;Cle: in Integer) is
    begin
        Initialiser_Arbre(A,Cle);

    end Initialiser_Arbre_Gen;




    procedure Ajouter_Arbre_Gen(A: in out T_Arbre_Gen;R: in out T_Registre; Cle_parent: in Integer ;Cle_enfant: in Integer; choix: in Boolean) is
    begin
        Ajouter_R_individu(R,Cle_parent);
        Ajouter(A,Cle_parent,Cle_enfant,Choix);
    end Ajouter_Arbre_Gen;




    function Obtenir_nb_ancetres(A: in  T_Arbre_Gen; Cle: in Integer) return Integer is
        A1 : T_Arbre_Gen;
        P: T_Pile;
        A2 : T_Arbre_Gen;
        nb : Integer;
    begin
        chercher_noeud(A,A1,Cle);
        egal(A2,A1);
        initialiser(P);
        empiler(P,A1);
        nb := 1;

        while not est_vide(P) loop
            A2 := sommet(P);
            depiler(P);

            if not est_egal_null(droite(A2)) then
                empiler(P,droite(A2));
                nb:= nb+1;
            else
                null;
            end if;

            if not est_egal_null(gauche(A2)) then
                empiler(P,gauche(A2));
                nb:=nb+1;
            else
                null;
            end if;

        end loop;
        Detruire(P);
        return nb;

    end Obtenir_nb_ancetres;




    function Obtenir_nb_ancetres_Gen(A : in T_Arbre_Gen; Cle: in Integer; Gen : in Integer) return T_Liste is
        L: T_Liste;



        procedure enregistrer_noeud (A : in T_Arbre_Gen; Cle: in Integer; Gen : in Integer;L:in out T_Liste) is

        begin
            if est_egal_null(A) then
                null;
            elsif gen = 0 then
                Ajouter_Liste(L,Obtenir_Cle(A));
            else
                enregistrer_noeud(gauche(A),Cle,gen - 1,L);
                enregistrer_noeud(droite(A),Cle,Gen -1,L);
            end if;
        end enregistrer_noeud;


    begin
        initialiser_Liste(L);
        enregistrer_noeud(A,Cle,Gen,L);
        return L;

    end Obtenir_nb_ancetres_Gen;




    procedure supprimer_noeud_gen( A: in out T_Arbre_Gen; Cle: in Integer; R: in out T_registre) is
        A1 : T_arbre_gen;
        L1,detruire : T_Liste;
    begin

        chercher_noeud(A,A1,Cle);

        -- supprimer la partie registre

        Initialiser_Liste(L1);
        obtenir_tous_les_ancetres(A1,L1);

        while L1/=null loop

            if Est_Present_R(R,L1.all.Cle) then
                Supprimer_R_individu(R,L1.all.Cle);
            else
                null;
            end if;
            detruire := L1;
            L1:=L1.all.suivant;
            Vider_Liste(detruire);


        end loop;

        supprimer_R_individu(R,Cle);


        --supprimer la partie arbre

        supprimer_Noeud(A,Cle);
        Vider_Liste(L1);



    end supprimer_noeud_gen;





    procedure afficher_arbre_gen(A : in T_arbre_gen ;Cle : in Integer) is
        A1 : T_Arbre_gen;
        gen : Integer;
        j:integer;

        function obtenir_generation (A: in T_Arbre_Gen;gen : in out Integer) return Integer is
            L,d : T_Liste;
        begin

            Initialiser_Liste(L);
            L:= Obtenir_nb_ancetres_Gen(A,Cle,1);
            while L /= null loop
                Initialiser_Liste(d);
                gen := gen + 1;
                d:= L;
                L:= Obtenir_nb_ancetres_Gen(A,Cle,Gen);
                Vider_Liste(d);
            end loop;
            Vider_Liste(L);
            return gen;
        end obtenir_generation;

    begin

        gen := 0;
        chercher_noeud(A,A1,Cle);
        gen := obtenir_generation(A,gen);

        for i in 1..gen loop
            j:=i-1;
            Put(j,0);
            Put("   ");
        end loop;

        Put(" ");
        Put ("Generation");
        New_Line;
        Put("-----------------------");
        New_Line;
        afficher_arbre(A1);

     end afficher_arbre_gen;




    function Un_parent(A: in T_Arbre_gen) return T_Liste is
        A1 : T_Arbre_gen;
        P : T_Pile;
        L : T_Liste;

    begin

        A1 :=A;
        initialiser(P);
        empiler(P,A);

        while not est_vide(P) loop
            A1 := sommet(P);
            depiler(P);

            if not est_egal_null(droite(A1)) then
                empiler(P,droite(A1));

                if est_egal_null(gauche(A1)) then
                    ajouter_Liste(L, Obtenir_Cle(A1));
                else
                    null;
                end if;

            else
                null;
            end if;

            if not est_egal_null(gauche(A1)) then
                empiler(P,gauche(A1));

                if est_egal_null (droite(A1)) then
                    ajouter_Liste(L, Obtenir_Cle(A1));
                else
                    null;
                end if;

            else
                null;
            end if;

        end loop;
        Detruire(P);
        return L;
    end Un_parent;




    -----------------------------------------------------------
    -----------------------Mohamed-----------------------------
    -----------------------------------------------------------


    function Deux_Parents(A:in T_Arbre_Gen) return T_Liste is
        L:T_Liste;

        procedure Deux_Parents0(A:in T_Arbre_Gen;L:in out T_Liste) is
        begin
            if est_egal_null(A) then
                null;
            else
                if not est_egal_null(gauche(A)) and not est_egal_null(droite(A)) then
                    Ajouter_Liste(L,obtenir_cle(A));
                    Deux_Parents0(gauche(A),L);
                    Deux_Parents0(droite(A),L);
                else
                    null;
                end if;
            end if;
        end Deux_Parents0;

    begin
        Initialiser_Liste(L);
        Deux_Parents0(A,L);
        return L;
    end Deux_Parents;




    function Aucun_Parent(A:in T_Arbre_Gen) return T_Liste is
        L: T_Liste;

        procedure Aucun_Parent0(A:in T_Arbre_Gen;L : in out T_Liste) is
        begin
            if est_egal_null(A) then
                null;
            else
                if est_egal_null(gauche(A)) then
                    if est_egal_null(droite(A)) then
                        Ajouter_Liste(L,obtenir_cle(A));
                    else
                        null;
                    end if;
                else
                    null;
                end if;
                Aucun_Parent0(gauche(A),L);
                Aucun_Parent0(droite(A),L);
            end if;
        end Aucun_Parent0;

    begin

        Initialiser_Liste(L);
        Aucun_Parent0(A,L);
        return L;

    end Aucun_Parent;



    function Ancetres_Gen(A: in T_Arbre_Gen;Cle:in Integer;Gen:in Integer)return T_Liste is

        Compteur: Integer;
        L: T_Liste;
        A1: T_Arbre_Gen;


        procedure Ancetres_Gen0(A:in T_Arbre_Gen;Gen:in Integer; L:in out T_Liste;Compteur:in Integer) is
        begin

            if Compteur=Gen then
                null;
            else
                if not est_egal_null(gauche(A)) then
                    Ajouter_Liste(L,obtenir_cle(gauche(A)));
                    Ancetres_Gen0(gauche(A),Gen,L,Compteur+1);
                else
                    null;
                end if;
                if not est_egal_null(droite(A)) then
                    Ajouter_Liste(L,obtenir_Cle(droite(A)));
                    Ancetres_Gen0(droite(A),Gen,L,Compteur+1);
                else
                    null;
                end if;
            end if;
        end Ancetres_Gen0;

    begin

        Compteur:=0;
        Initialiser_Liste(L);
        chercher_noeud(A,A1,Cle);
        Ancetres_Gen0(A1,Gen,L,Compteur);
        egal_null(A1);
        Detruire(A1);
        return L;

    end Ancetres_Gen;




    function Homonyme(A:in T_Arbre_Gen;R:in T_Registre; n: in Integer; m: in Integer) return T_Liste is
        An:T_Arbre_Gen;
        Am:T_Arbre_Gen;
        resultat: T_Liste;
        Ln : T_Liste;
        Lm : T_Liste;

        Ln0 : T_Liste;
        Lm0: T_Liste;




    begin

        chercher_noeud(A,An,n);

        chercher_noeud(A,Am,m);

        Initialiser_Liste(Ln);
        Initialiser_Liste(Lm);

        Obtenir_Tous_Les_Ancetres(An,Ln);                        --Ln contient tous les ancêtres de n
        Obtenir_Tous_Les_Ancetres(Am,Lm);                        --Lm contient tous les ancêtres de m

        Initialiser_Liste(resultat);

        Ln0:=Ln;

        for i in 1..Longueur_Liste(Ln) loop                        --On compare 2 à 2 les noms des individus
            Lm0:=Lm;

            for j in 1..Longueur_Liste(Lm) loop

                if Obtenir_Nom(R,Lm0.Cle)/="Le nom de cet individu n'est pas renseigné  " then

                    if Obtenir_nom(R,Ln0.Cle)=Obtenir_Nom(R,Lm0.Cle) then
                        Ajouter_Liste(resultat,Ln0.Cle);
                        Ajouter_Liste(resultat,Lm0.Cle);
                    else
                        null;
                    end if;

                else
                    null;
                end if;

                Lm0:=Lm.suivant;

            end loop;

            Ln0:=Ln.suivant;

        end loop;

        Vider_Liste(Ln);
        Vider_Liste(Lm);
        Vider_Liste(Ln0);
        Vider_Liste(Lm0);



        return resultat;

    end Homonyme;




    function Est_Present_Gen(A:in T_Arbre_Gen;Cle:in Integer) return Boolean is
    begin
        return Est_Present(A,Cle);
    end Est_Present_Gen;




    procedure Obtenir_Tous_Les_Ancetres(A : in T_Arbre_Gen ; L : in out T_Liste) is

        begin
            if est_egal_null(gauche(A)) then
                null;
            else
                Ajouter_Liste(L,Obtenir_Cle(gauche(A)));
                Obtenir_Tous_Les_Ancetres(gauche(A),L);
            end if;

            if est_egal_null(droite(A)) then
                null;
            else
                Ajouter_Liste(L,Obtenir_Cle(droite(A)));
                Obtenir_Tous_Les_Ancetres(droite(A),L);
        end if;

    end Obtenir_Tous_Les_Ancetres;








    --Manipulation des listes




    procedure Initialiser_Liste(L: out T_Liste) is
    begin
        L:=null;
    end Initialiser_Liste;


    procedure Afficher_Liste(L:in T_Liste) is
        L0: T_Liste;
    begin
        if L=null then
            Put("La liste est vide");
        else
            null;
        end if;

        L0:=L;

        while L0/=null loop
            Put(L0.all.Cle);
            L0:=L0.all.suivant;
        end loop;

    end Afficher_Liste;




    procedure Ajouter_Liste(L: in out T_Liste;Element:in Integer) is
        L0: T_Liste;
    begin

        if L=null then
            L:=new Cellule;
            L.all.Cle:=Element;

        else
            if Est_Present_Liste(L,element) then
                null;

            else
                L0:=L;

                while L0.all.Suivant/=null loop
                    L0:=L0.Suivant;
                end loop;

                L0.all.Suivant := new Cellule;
                L0.all.Suivant.Cle := element;
                L0:=null;

            end if;

        end if;

    end Ajouter_Liste;




    procedure Vider_Liste(L:in out T_Liste) is
        procedure Free_Liste is new Ada.Unchecked_Deallocation (Cellule, T_Liste);
    begin
        if L /= Null then
            Vider_Liste(L.all.Suivant);
            Free_Liste(L);
        else
            Null;
        end if;
    end Vider_Liste;




    function Est_Present_Liste(L: in T_Liste; Element: in Integer) return Boolean is
        L0:T_Liste;
        resultat: Boolean;
    begin

        L0:=L;
        resultat:=False;

        while L0/=null loop
            if L0.Cle=Element then
                resultat:=True;

            else
                null;
            end if;

            L0:=L0.suivant;
        end loop;

        return resultat;

    end Est_Present_Liste;




    function Longueur_Liste(L:in T_Liste) return Integer is
        n : Integer;
        L0: T_Liste;
    begin

        L0:=L;
        n:=0;

        while L0/=null loop
            n:=n+1;
            L0:=L0.all.suivant;
        end loop;

        return n;
    end Longueur_Liste;




   procedure Detruire(A:in out T_Arbre_Gen) is
   begin
      Detruire_arbre(A);
   end Detruire;




    function obtenir_element(L: in T_Liste) return Integer is
    begin
        return L.all.Cle;
    end obtenir_element;




   function obtenir_suivant_liste(L : in T_Liste) return T_Liste is
   begin
      return L.all.suivant;
   end obtenir_suivant_liste;




   function est_vide_liste(L : in T_Liste) return boolean is
   begin
       return L =null;
   end est_vide_liste;




    procedure fusionner (L1: in out T_Liste; L2: in T_Liste) is
        L:T_Liste;
    begin
        L:=L1;
        if L1=null then
            L1:=L2;
        else
            while L.all.suivant /= null loop
                L := L.all.suivant;
            end loop;
            L.all.suivant := L2;
        end if;
    end fusionner;




    procedure egal_liste(L1: in out T_Liste; L2: in T_Liste) is
    begin
        L1:=L2;
    end egal_liste;



end Arbre_genealogique;
