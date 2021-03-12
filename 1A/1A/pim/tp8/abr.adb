with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

package body ABR is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Noeud, Name => T_ABR);


    procedure Initialiser(Abr: out T_ABR) is
    begin
        Abr:=null;	-- TODO : à changer
    end Initialiser;


    function Est_Vide (Abr : T_Abr) return Boolean is
    begin
        if Abr = null then
            return True;
        else
            return False;
        end if;
    end Est_Vide;



    function Taille (Abr : in T_ABR) return Integer is
    begin
        if Abr/=null then
            if Abr.all.Donnee=null then
                return Taille(Abr.all.Sous_Arbre_Gauche)+Taille(Abr.all.Sous_Arbre_Droit);
            else
                return 1+Taille(Abr.all.Sous_Arbre_Gauche)+Taille(Abr.all.Sous_Arbre_Droit);
            end if;
        else
            return 0;
        end if;
    end Taille;


        procedure Inserer (Abr : in out T_ABR ; Cle : in Character ; Donnee : in Integer) is
            A0: T_ABR;
            Nouvelle_Cellule:T_ABR;
	begin
            A0:= Abr;
            while A0.all.Sous_Arbre_Gauche /= null and A0.all.Sous_Arbre_Droit /=null loop
                if A0.all.Cle=Cle then
                    raise Cle_Presente_Exception;
                else
                    null;
                end if;
                if Cle<A0.all.Cle then
                    A0:=A0.all.Sous_Arbre_Gauche;
                else
                    A0:=A0.all.Sous_Arbre_Droit;
                end if;
            end loop;
            Nouvelle_Cellule := new T_Noeud;
            Nouvelle_Cellule.all.Donnee := Donnee;
            Nouvelle_Cellule.all.Cle:=Cle;
            if A0.all.Cle>Cle then
                A0.all.Sous_Arbre_Droit:=Nouvelle_Cellule;
            else
                A0.all.Sous_Arbre_Gauche:=Nouvelle_Cellule;
            end if;
 	end Inserer;


        procedure Modifier (Abr : in out T_ABR ; Cle : in Character ; Donnee : in Integer) is
            a:Boolean;
        begin
            a:=False;
            if Abr/=null then
                if Abr.all.Cle=Cle then
                    Abr.all.Donnee:=Donnee;
                    a:=True;
                else
                    Modifier(Abr.all.Sous_Arbre_Gauche,Cle,Donnee);
                    Modifier(Abr.all.Sous_Arbre_Droit,Cle,Donnee);
                end if;
            else
                if a=False then
                    raise Cle_Absente_Exception;
                else
                    null;
                end if;
            end if;
        end Modifier;


        function La_Donnee (Abr : in T_ABR ; Cle : in Character) return Integer is
        begin
            if Abr/=null then
                if Abr.all.Cle=Cle then
                    return Abr.all.Donnee;
                else
                    La_Donnee(Abr.all.Sous_Arbre_Gauche,Cle);
                    La_Donnee(Abr.all.Sous_Arbre_Droit,Cle);
                end if;
            else
                raise Cle_Absente_Exception;
            end if;
	end La_Donnee;


    procedure Supprimer (Abr : in out T_ABR ; Cle : in Character) is
    begin
        Modifier(Abr,null);
    end Supprimer;


    procedure Vider (Abr : in out T_ABR) is
    begin
        if Abr/=null then
            Vider(Abr.all.Sous_Arbre_Gauche);
            Vider(Abr.all.Sous_Arbre_Droit);
            Free(Abr);
        else
            null;
        end if;
	end Vider;


	procedure Afficher (Abr : in T_Abr) is
	begin
		Null;	-- TODO : à changer
	end Afficher;


	procedure Afficher_Debug (Abr : in T_Abr) is
	begin
		Null;	-- TODO : à changer
	end Afficher_Debug;

end ABR;
