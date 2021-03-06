with Arbre_genealogique;
use Arbre_genealogique;
with lien;
use lien;
with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;
with registre;
use registre;


package body foret is

    procedure initialiser_foret(F : out T_foret) is
    begin
        F := null;
    end initialiser_foret;





    procedure Ajouter_Foret(F: in out T_Foret;Element : in T_Arbre_gen) is
        F0 : T_Foret;
    begin

        if F=null then
            F:=new T_Cellule_F;
            F.all.A:=Element;

        else
            if Est_Present_Foret(F,Obtenir_Cle(element)) then
                null;

            else
                F0:=F;
                while F0.all.Suivant/=null loop
                    F0:=F0.Suivant;
                end loop;
                F0.all.Suivant := new T_Cellule_F;
                F0.all.Suivant.A := element;

                F0:=null;

            end if;
        end if;
    end Ajouter_Foret;




    function Est_Present_Foret(F: in T_Foret; Cle: in Integer) return Boolean is
        F0: T_foret;
        resultat: Boolean;
    begin
        F0:=F;
        resultat:=False;
        while F0/=null loop
            if Obtenir_Cle(F0.A)=Cle then
                resultat:=True;
            else
                null;
            end if;
            F0:=F0.suivant;
        end loop;
        return resultat;
    end Est_Present_Foret;




    procedure afficher_Foret(F : in T_foret) is
        F0 : T_Foret;
        A1 : T_Arbre_Gen;
    begin
        if F=null then
            Put("La foret est vide");
        else
            null;
        end if;
        F0:=F;
        while F0/=null loop
            A1 := F0.all.A;
            Put(Obtenir_Cle(A1));
            F0:=F0.all.suivant;
        end loop;
    end afficher_Foret;




    procedure Vider_Foret(F : in out T_Foret) is
        procedure Free_Foret is new Ada.Unchecked_Deallocation (T_Cellule_F, T_Foret);
    begin
        if F /= Null then
            Vider_Foret(F.all.Suivant);
            detruire_arbre(F.all.A);
            Free_Foret(F);
        else
            Null;
        end if;
    end Vider_Foret;




    function Longueur_Foret(F : in T_Foret) return Integer is
        n : Integer;
        F0 : T_Foret;
    begin

        F0:=F;
        n:=0;

        while F0/=null loop
            n:=n+1;
            F0:=F0.all.suivant;
        end loop;
        F0:=null;

        return n;
    end Longueur_Foret;



    function obtenir_Arbre(F : in T_Foret;Cle : in Integer) return T_Arbre_Binaire is
        F0 : T_Foret;
    begin
        F0:=F;
        while Obtenir_Cle(F0.all.A)/=Cle loop
            F0:=F0.all.suivant;
        end loop;

        return F0.all.A;
    end Obtenir_Arbre;


end foret;


