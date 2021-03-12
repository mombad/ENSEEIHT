--Implantation du module registre
with Ada.Unchecked_Deallocation;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

package body Registre is

    procedure Free_Registre is
            new Ada.Unchecked_Deallocation (Object => T_Cellule_Registre, Name => T_Registre);


    procedure Free_Info is
            new Ada.Unchecked_Deallocation (Object => T_Cellule_Info, Name => T_Info);


    procedure Initialiser_R(R : out T_Registre) is
    begin
        R:=Null;
    end Initialiser_R;




    procedure Detruire_R(R:in out T_Registre) is
    begin
        if R/=null then
            Detruire_Information(R.all.Information);
            Detruire_R(R.all.suivant);
            Free_Registre(R);

        else
            null;
        end if;
    end Detruire_R;




    procedure Detruire_Information(I:in out T_Info) is
    begin
        if I/=null then
            Detruire_Information(I.all.infosuivante);
            Free_Info(I);

        else
            null;
        end if;
    end Detruire_Information;




    function Est_Vide_R(R:T_Registre) return Boolean is
    begin
        return R=Null;
    end Est_Vide_R;




    function Est_Present_R(R:in T_Registre;Cle: in Integer) return Boolean is
    begin
        if R=null then
            return False;

        else
            if R.all.Cle=Cle then
                return True;

            else
                return Est_Present_R(R.all.suivant,Cle);
            end if;
        end if;
    end Est_Present_R;




    procedure Ajouter_R_individu(R: in out T_Registre;Cle: in Integer) is
        R0: T_Registre;
    begin

        if Est_Vide_R(R) then
            R:=new T_Cellule_Registre;
            R.all.Cle:=Cle;

        else
            if Est_Present_R(R,Cle) then
                raise Est_Present_Cle;

            else
                R0:=R;
                while R0.all.suivant/=null loop
                    R0:=R0.all.suivant;
                end loop;

                R0.all.suivant:= new T_Cellule_Registre;
                R0.all.suivant.Cle:=Cle;
            end if;
        end if;
    end Ajouter_R_individu;




    procedure Ajouter_R_info(R: in out T_Registre; Cle: in Integer) is
        R0:T_Registre;
        I0:T_Info;
        Infostr: NSTR;
        Longueur:Natural;
    begin
        if Est_Present_R(R,Cle) then

            Put("Veuillez entrez une information. Par exemple 'Age : 20 ans'   ");
            Get_Line(Infostr,Longueur);

            if Longueur<45 then
                for i in (Longueur+1)..45 loop
                    Infostr(i):=' ';
                end loop;

            else
                null;
            end if;
            R0:=R;

            --recherche de la cellule correspondant à la clé
            while R0.all.Cle/=Cle loop
                R0:=R0.all.suivant;
            end loop;

            --si aucune information n'est renseignée
            if R0.all.Information=null then
                I0:= new T_Cellule_Info;
                I0.all.info:=Infostr;
                R0.all.Information:=I0;

            --s'il y a déja des informations renseignées
            else
                I0:=R0.all.Information;

                while I0.all.infosuivante/=null loop
                    I0:=I0.all.infosuivante;
                end loop;

                I0.all.infosuivante:= new T_Cellule_Info;
                I0.all.infosuivante.all.info:= Infostr;
                I0:=null;
                Detruire_Information(I0);
            end if;

        else
            Put("La clé indiquée n'est pas présente dans le registre");
            New_Line;
        end if;
    end Ajouter_R_info;




    procedure Supprimer_R_individu(R:in out T_Registre; Cle:in Integer) is
        R0: T_Registre;
    begin
        if Est_Present_R(R,Cle) then

            if R.all.Cle=Cle then
                R0:=R;
                R:=R.all.suivant;
                Detruire_Information(R0.all.Information);
                Free_Registre(R0);

            else

                if R.all.suivant.Cle=Cle then
                    R0:=R.all.suivant;
                    R.all.suivant:=R.all.suivant.all.suivant;
                    Detruire_Information(R0.all.Information);
                    Free_Registre(R0);

                else
                    Supprimer_R_individu(R.all.suivant,Cle);
                end if;

            end if;


        else
            raise Est_Absent_Cle;
        end if;
    end Supprimer_R_individu;




    procedure Supprimer_R_information(R:in out T_Registre; Cle:in Integer) is
        R0:T_Registre;
        I0:T_Info;
        I1:T_Info;
        choix:Integer;
    begin
        if Est_Present_R(R,Cle) then
            --Recherche de la sous-liste chaînée correspondant à la clé donnée
            R0:=R;

            while R0.all.Cle/=Cle loop
                if R0=null then
                    raise Est_Absent_Cle;
                else
                    R0:=R0.all.suivant;
                end if;
            end loop;


            Afficher_info(R,Cle);
            Put("Quelle information voulez-vous supprimer ?");
            New_Line;
            Put("Veuillez entrer le numéro correspondant à celle-ci (0 pour quitter)");
            New_Line;
            Get(choix);

            if choix=0 then
                null;

            else

                if choix > Nb_info(R,Cle) then
                    Put("Aucune information ne correspond à ce numéro. Echec de la suppression.");

                else
                    I0:=R0.all.Information;

                    if choix=1 then
                        R0.all.Information:=R0.all.Information.all.infosuivante;
                        Free_Info(I0);


                    else


                        if choix=2 then
                            null;

                        else
                            for i in 1..(choix-2) loop
                                I0:=I0.all.infosuivante;
                            end loop;
                        end if;


                        I1:=I0.all.infosuivante;
                        if I1.all.infosuivante/=null then
                            I0.all.infosuivante:=I0.all.infosuivante.all.infosuivante;
                            Free_Info(I1);

                        else
                            Free_Info(I1);
                            I0.all.infosuivante:=null;
                        end if;


                    end if;

                end if;

            end if;

        else
            raise Est_Absent_Cle;
        end if;
        New_Line;
    end Supprimer_R_information;




    procedure Afficher_R(R:in T_Registre) is
    begin
        if R=null then
            null;

        else
            Put(R.all.Cle, Width => 0);
            Put(" : " );
            New_Line;
            Afficher_info(R,R.all.Cle);
            New_Line;
            Afficher_R(R.all.suivant);
        end if;
    end Afficher_R;




    procedure Afficher_info(R:in T_Registre;Cle:in Integer) is
        R0:T_Registre;
        I0:T_Info;
    begin
        R0:=R;

        while R0.all.Cle/=Cle loop
            R0:=R0.all.suivant;
        end loop;

        I0:=R0.all.Information;

        for i in 1..Nb_info(R,Cle) loop
            Put("       ");
            Put(I0.all.info);
            New_Line;
            I0:=I0.all.infosuivante;
        end loop;
    end Afficher_info;




    function Nb_info(R:in T_Registre;Cle:in Integer) return Integer is
        Nb:Integer;
        R0:T_Registre;
        I0:T_Info;
    begin
        R0:=R;

        while R0.all.Cle/=Cle loop
            R0:=R0.all.suivant;
        end loop;

        Nb:=0;
        I0:=R0.all.Information;

        while I0/=null loop
            Nb:=Nb + 1;
            I0:=I0.all.infosuivante;
        end loop;

        return Nb;
    end Nb_info;




    function Obtenir_Nom(R:in T_Registre; Cle:in Integer) return NSTR is
        R0:T_Registre;
        I0:T_Info;
        NOM_individu:NSTR;
        Booleen : Boolean;
    begin
        if Est_Present_R(R,Cle) then
            R0:=R;

            while R0.all.Cle/=Cle loop
                R0:=R0.all.suivant;
            end loop;

            I0:=R0.all.Information;


            Booleen:=False;

            while Booleen=False and I0/=null loop
                if I0.all.info(1)='N' or I0.all.info(1)='n' then
                    if I0.all.info(2)='O' or I0.all.info(2)='o' then
                        if I0.all.info(3)='M' or I0.all.info(3)='m' then
                            Booleen:=True;
                        else
                            null;
                        end if;
                    else
                        null;
                    end if;
                else
                    null;
                end if;

                if Booleen=True then
                    null;
                else
                    I0:=I0.all.infosuivante;
                end if;
            end loop;


            if Booleen=True then
                NOM_individu:=I0.all.info;
            else
                NOM_individu:="Le nom de cet individu n'est pas renseigné  ";
            end if;

            return NOM_individu;

        else
            raise Est_Absent_Cle;
        end if;
    end Obtenir_Nom;




   function suivant(R:in T_registre) return T_registre is
   begin
      return R.all.suivant;
   end suivant;




   function Obtenir_Cle_R(R: in T_Registre) return Integer is
   begin
      return R.all.Cle;
   end Obtenir_Cle_R;




   function est_egal_null_R(R: in T_Registre) return boolean is
   begin
      return R = Null;
   end est_egal_null_R;




   procedure egal_R(R1:in out T_Registre; R2: in T_Registre) is
   begin
      R1 := R2;
   end egal_R;


    function Obtenir_conjoint(R:in T_Registre; Cle:in Integer) return T_Liste_R is
        R0:T_Registre;
        I0:T_Info;
        Liste_Conjoint:T_Liste_R;
        Booleen : Boolean;
        Conjoint: Integer;
        Cle_a_ajouter: String(1..5);
        i:Integer;
    begin
        if Est_Present_R(R,Cle) then
            R0:=R;
            Initialiser_Liste_R(Liste_Conjoint);
            while R0.all.Cle/=Cle loop
                R0:=R0.all.suivant;
            end loop;

            I0:=R0.all.Information;

            Booleen:=False;



            while I0/=null loop
                if I0.all.info(1)='C' or I0.all.info(1)='c' then
                    if I0.all.info(2)='O' or I0.all.info(2)='o' then
                        if I0.all.info(3)='N' or I0.all.info(3)='n' then
                            if I0.all.info(4)='J' or I0.all.info(4)='j' then
                                if I0.all.info(5)='O' or I0.all.info(5)='o' then
                                    if I0.all.info(6)='I' or I0.all.info(6)='i' then
                                        if I0.all.info(7)='N' or I0.all.info(7)='n' then
                                            if I0.all.info(8)='T' or I0.all.info(8)='t' then

                                                Booleen:=True;
                                                i:=1;
                                                while i<6 loop
                                                    Cle_a_ajouter(i):=I0.all.info(i+11);
                                                    i:=i+1;
                                                end loop;

                                                Conjoint:=Integer'Value(Cle_a_ajouter);
                                                Ajouter_Liste_R(Liste_Conjoint,Conjoint);


                                            else
                                                null;
                                            end if;
                                        else
                                            null;
                                        end if;
                                    else
                                        null;
                                    end if;
                                else
                                    null;
                                end if;
                            else
                                null;
                            end if;
                        else
                            null;
                        end if;
                    else
                        null;
                    end if;
                else
                    null;
                end if;
                I0:=I0.all.infosuivante;
            end loop;
            return Liste_Conjoint;
        else
            raise Est_Absent_Cle;
        end if;
    end Obtenir_conjoint;



    function Obtenir_frere(R:in T_Registre; Cle:in Integer) return T_Liste_R is
        R0:T_Registre;
        I0:T_Info;
        Liste_Frere:T_Liste_R;
        Booleen : Boolean;
        Frere: Integer;
        Cle_a_ajouter: String(1..5);
        i:Integer;
    begin
        if Est_Present_R(R,Cle) then
            R0:=R;
            Initialiser_Liste_R(Liste_Frere);
            while R0.all.Cle/=Cle loop
                R0:=R0.all.suivant;
            end loop;

            I0:=R0.all.Information;

            Booleen:=False;

            while I0/=null loop
                if I0.all.info(1)='F' or I0.all.info(1)='f' then
                    if I0.all.info(2)='R' or I0.all.info(2)='r' then
                        if I0.all.info(3)='E' or I0.all.info(3)='e' then
                            if I0.all.info(4)='R' or I0.all.info(4)='r' then
                                if I0.all.info(5)='E' or I0.all.info(5)='e' then

                                    Booleen:=True;
                                    i:=1;

                                    while i<6 loop
                                        Cle_a_ajouter(i):=I0.all.info(i+8);
                                        i:=i+1;
                                    end loop;


                                    Frere:=Integer'Value(Cle_a_ajouter);
                                    Ajouter_Liste_R(Liste_Frere,Frere);


                                else
                                    null;
                                end if;
                            else
                                null;
                            end if;
                        else
                            null;
                        end if;
                    else
                        null;
                    end if;
                else
                    null;
                end if;
                I0:=I0.all.infosuivante;

            end loop;
            return Liste_Frere;
        else
            raise Est_Absent_Cle;
        end if;
    end Obtenir_frere;




   function obtenir_beau_frere( R : in out T_Registre;Cle : in Integer) return T_Liste_R is
      Lc,Liste_conjoint : T_Liste_R;
      Lf,Liste_frere : T_Liste_R;
      Liste_beau_frere : T_Liste_R;

    begin
        Liste_conjoint := obtenir_conjoint(R,Cle);

        for i in 1..Longueur_Liste_R(Liste_conjoint) loop

            Liste_frere:=Obtenir_Frere(R,Liste_Conjoint.all.Cle);

            for i in 1..Longueur_Liste_R(Liste_frere) loop

                Ajouter_Liste_R(Liste_beau_frere,Liste_frere.all.Cle);
                Lf:=Liste_frere;
                Liste_frere:=Liste_frere.all.suivant;
                Lf.all.suivant:=null;
                Vider_Liste_R(Lf);
            end loop;


            Lc:=Liste_Conjoint;
            Liste_Conjoint:=Liste_Conjoint.all.suivant;
            lc.all.suivant:=null;

            Vider_Liste_R(Lc);
            Vider_Liste_R(Liste_frere);


        end loop;
        Vider_Liste_R(Liste_Conjoint);
      return Liste_beau_frere;
   end obtenir_beau_frere;




 procedure Ajouter_R_info_auto(R: in out T_Registre; Cle: in Integer; infostr: in out String) is
        R0:T_Registre;
        I0:T_Info;
        Longueur:Natural;
        Information_a_ajouter:NSTR;
    begin
        if Est_Present_R(R,Cle) then

            Longueur := infostr'length;

            Information_a_ajouter(1..longueur):=infostr;

            if Longueur<45 then
                for i in (Longueur+1)..45 loop
                    Information_a_ajouter(i):=' ';
                end loop;

            else
                null;
            end if;


            R0:=R;

            --recherche de la cellule correspondant à la clé
            while R0.all.Cle/=Cle loop
                R0:=R0.all.suivant;
            end loop;

            --si aucune information n'est renseignée
            if R0.all.Information=null then
                I0:= new T_Cellule_Info;
                I0.all.info:=Information_a_ajouter;
                R0.all.Information:=I0;

            --s'il y a déja des informations renseignées
            else
                I0:=R0.all.Information;

                while I0.all.infosuivante/=null loop
                    I0:=I0.all.infosuivante;
                end loop;

                I0.all.infosuivante:= new T_Cellule_Info;
                I0.all.infosuivante.all.info:= Information_a_ajouter;
                I0:=null;
                Detruire_Information(I0);
            end if;

        else
            raise Est_Absent_Cle;
        end if;
    end Ajouter_R_info_auto;




    procedure frere(Cle1:in Integer;Cle2:in Integer; R: in out T_Registre) is
        info1s : String(1..(8+(integer'image(Cle1)'length)));
        info2s : String(1..(8+(integer'image(Cle2)'length)));
        info1, info2 : NSTR;
        Longueur : Natural;
    begin
        if not Est_Present_R(R,Cle1) then
            Put("La première clé n'est pas présente dans le registre");
            New_Line;

        elsif not Est_Present_R(R,Cle2) then
            Put("La deuxième clé n'est pas présente dans le registre");
            New_Line;

        else

            info1s(1..8):= "Frere : ";

            for i in 1..(integer'image(Cle1)'length) loop
                info1s(i+8):=Integer'image(Cle1)(i);
            end loop;

            info2s(1..8) := "Frere : ";
            for i in 1..(integer'image(Cle2)'length) loop
                info2s(i+8):=Integer'image(Cle2)(i);
            end loop;
            Longueur := info1s'length;

            info1(1..longueur):=info1s;

            if Longueur<45 then
                for i in (Longueur+1)..45 loop
                    info1(i):=' ';
                end loop;

            else
                null;
            end if;


            Longueur := info2s'length;

            info2(1..longueur):=info2s;

            if Longueur<45 then
                for i in (Longueur+1)..45 loop
                    info2(i):=' ';
                end loop;

            else
                null;
            end if;
            ajouter_R_info_auto(R, Cle1, info2);
            ajouter_R_info_auto(R,Cle2, info1);
        end if;

   end frere;




    procedure conjoint(Cle1: in Integer;Cle2: in Integer; R : in out T_Registre) is
        info1s : String(1..(11+(integer'image(Cle1)'length)));
        info2s : String(1..(11+(integer'image(Cle2)'length)));
        info1, info2 : NSTR;
        Longueur : Natural;
    begin
        if not Est_Present_R(R,Cle1) then
            Put("La première clé n'est pas présente dans le registre");
            New_Line;
        elsif not Est_Present_R(R,Cle2) then
            Put("La deuxième clé n'est pas présente dans le registre");
            New_Line;
        else
            info1s(1..11):= "Conjoint : ";
            for i in 1..(integer'image(Cle1)'length) loop
                info1s(i+11):=Integer'image(Cle1)(i);
            end loop;


            info2s(1..11) := "Conjoint : ";
            for i in 1..(integer'image(Cle2)'length) loop
                info2s(i+11):=Integer'image(Cle2)(i);
            end loop;

            Longueur := info1s'length;

            info1(1..longueur):=info1s;

            if Longueur<45 then
                for i in (Longueur+1)..45 loop
                    info1(i):=' ';
                end loop;

            else
                null;
            end if;


            Longueur := info2s'length;

            info2(1..longueur):=info2s;

            if Longueur<45 then
                for i in (Longueur+1)..45 loop
                    info2(i):=' ';
                end loop;

            else
                null;
            end if;
            ajouter_R_info_auto(R, Cle1, info2);
            ajouter_R_info_auto(R,Cle2, info1);
        end if;
    end conjoint;




    --Manipulation de listes



    procedure Initialiser_Liste_R(L: out T_Liste_R) is
    begin
        L:=null;
    end Initialiser_Liste_R;


    procedure Afficher_Liste_R(L:in T_Liste_R) is
        L0: T_Liste_R;
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

    end Afficher_Liste_R;




    procedure Ajouter_Liste_R(L: in out T_Liste_R;Element:in Integer) is
        L0: T_Liste_R;
    begin
        if L=null then
            L:=new T_Cellule_Liste_R;
            L.all.Cle:=Element;

        else
            if Est_PresenT_Liste_R(L,element) then
                null;

            else
                L0:=L;

                while L0.all.Suivant/=null loop
                    L0:=L0.Suivant;
                end loop;

                L0.all.Suivant := new T_Cellule_Liste_R;
                L0.all.Suivant.Cle := element;
                L0:=null;

            end if;

        end if;
        Vider_Liste_R(L0);

    end Ajouter_Liste_R;




    procedure Vider_Liste_R(L:in out T_Liste_R) is
        procedure Free_Liste_R is new Ada.Unchecked_Deallocation (T_Cellule_Liste_R, T_Liste_R);
    begin
        if L /= Null then
            Vider_Liste_R(L.all.Suivant);
            Free_Liste_R(L);

        else
            Null;

        end if;
    end Vider_Liste_R;




    function Est_Present_Liste_R(L: in T_Liste_R; Element: in Integer) return Boolean is
        L0:T_Liste_R;
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

    end Est_Present_Liste_R;




    function Longueur_Liste_R(L:in T_Liste_R) return Integer is
        n : Integer;
        L0: T_Liste_R;
    begin

        L0:=L;
        n:=0;

        while L0/=null loop
            n:=n+1;
            L0:=L0.all.suivant;
        end loop;

        return n;
   end Longueur_Liste_R;





    function obtenir_element_R(L: in T_Liste_R) return Integer is
    begin
        return L.all.Cle;
    end obtenir_element_R;




   function obtenir_suivant_liste_R(L : in T_Liste_R) return T_Liste_R is
   begin
      return L.all.suivant;
   end obtenir_suivant_liste_R;




   function est_vide_liste_R(L : in T_Liste_R) return boolean is
   begin
       return L =null;
   end est_vide_liste_R;




    procedure fusionner_R (L1: in out T_Liste_R; L2: in T_Liste_R) is
        L:T_Liste_R;
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
    end fusionner_R;




    procedure egal_liste_R(L1: in out T_Liste_R; L2: in T_Liste_R) is
    begin
        L1:=L2;
    end egal_liste_R;



end Registre;
