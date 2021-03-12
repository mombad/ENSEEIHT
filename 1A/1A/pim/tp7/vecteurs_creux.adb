with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Unchecked_Deallocation;

package body Vecteurs_Creux is


    procedure Free is
            new Ada.Unchecked_Deallocation (T_Cellule, T_Vecteur_Creux);


    procedure Initialiser (V: out T_Vecteur_Creux) is
    begin
        V:=Null;	-- TODO                      : à changer
    end Initialiser;


    procedure Detruire (V: in out T_Vecteur_Creux) is
        A : T_Vecteur_Creux;
    begin
        Initialiser(A);
        V:=A;
    end Detruire;


    function Est_Nul (V: in T_Vecteur_Creux) return Boolean is
    begin
        if V=Null then
            return True;
        else
            return False;
        end if;

    end Est_Nul;


    function Composante_Recursif (V: in T_Vecteur_Creux ; Indice : in Integer) return Float is
    begin
        if V.all.Indice=Indice then
            return V.all.Valeur;
        else
            return Composante_Recursif(V.all.Suivant,Indice);
        end if;

    end Composante_Recursif;


    function Composante_Iteratif (V : in T_Vecteur_Creux ; Indice : in Integer) return Float is
        A:T_Vecteur_Creux;
    begin
        A:=V;
        for i in 1..Indice loop
            A:=A.all.Suivant;
        end loop;
        return A.all.Valeur;
    end Composante_Iteratif;


    procedure Modifier (V : in out T_Vecteur_Creux; Indice : in Integer ; Valeur : in Float ) is
        Nouvelle_Cellule : T_Vecteur_Creux;
    begin
        if V=null then
            Nouvelle_Cellule:= New T_Cellule;
            Nouvelle_Cellule.all.Valeur := Valeur;
            Nouvelle_Cellule.all.Suivant := V;
            Nouvelle_Cellule.all.Indice := Indice;
            V:=Nouvelle_Cellule;
        end if;
        if V.all.Indice=Indice then
            V.all.Valeur:=Valeur;
        else
            Modifier(V.all.Suivant,Indice,Valeur);
        end if;

    end Modifier;


    function Sont_Egaux_Recursif (V1, V2: in T_Vecteur_Creux) return Boolean is
    begin
        if V1=Null and V2=Null then
            return True;
        else
            if V1.all.Valeur=V2.all.Valeur then
                return Sont_Egaux_Recursif(V1.all.Suivant,V2.all.Suivant);
            else
                return False;
            end if;
        end if;
    end Sont_Egaux_Recursif;


    function Sont_Egaux_Iteratif (V1, V2 : in T_Vecteur_Creux) return Boolean is
        V01,V02 : T_Vecteur_Creux;
    begin
        V01:=V1;
        V02:=V2;
        while V01/=Null loop
            if V01.all.Valeur=V02.all.Valeur then
                V01:=V01.all.Suivant;
                V02:=V02.all.Suivant;
            else
                return False;
            end if;
        end loop;
        return True;
    end Sont_Egaux_Iteratif;


    procedure Additionner (V1: in out T_Vecteur_Creux; V2 : in T_Vecteur_Creux) is
        V01,V02: T_Vecteur_Creux;
    begin
        V01:=V1;
        while V01/=null loop
            Modifier(V1, V01.all.Indice,V01.all.Valeur+Composante_Recursif(V2,V01.all.Indice));
            V01:=V01.all.Suivant;
            V02:=V02.all.Suivant;
        end loop;
    end Additionner;


    function Norme2 (V : in T_Vecteur_Creux) return Float is
        N: Float;
        V0: T_Vecteur_Creux;
    begin
        N:=0.0;
        V0:=V;
        while V0/=null loop
            N:=N+(V0.all.Valeur)**2;
            V0:=V0.all.Suivant;
        end loop;
        return N;
    end Norme2;


    Function Produit_Scalaire (V1, V2: in T_Vecteur_Creux) return Float is
        V01,V02: T_Vecteur_Creux;
        ps: Float;
    begin
        V01:=V1;
        V02:=V2;
        ps:=0.0;
        while V01/=null loop
            ps:=ps+V01.all.Valeur*V02.all.Valeur;
            V01:=V01.all.Suivant;
            V02:=V02.all.Suivant;
        end loop;
        return ps;
    end Produit_Scalaire;


    procedure Afficher (V: T_Vecteur_Creux) is
    begin
        if V = Null then
            Put ("--E");
        else
            Put ("-->[ ");
            Put (V.all.Indice, 0);
            Put (" | ");
            Put (V.all.Valeur, Fore => 0, Aft => 1, Exp => 0);
            Put (" ]");
            Afficher (V.all.Suivant);
        end if;
    end Afficher;


    function Nombre_Composantes_Non_Nulles (V : in T_Vecteur_Creux) return Integer is
    begin
        if V = Null then
            return 0;
        else
            return 1 + Nombre_Composantes_Non_Nulles (V.all.Suivant);
        end if;
    end Nombre_Composantes_Non_Nulles;


end Vecteurs_Creux;
