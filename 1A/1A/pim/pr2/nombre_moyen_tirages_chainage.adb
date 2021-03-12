with Ensembles_Chainage;
with Alea;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;


procedure Nombre_Moyen_Tirage_Chainage is
    S,n: Float;         -- S est la somme et n le nombre d'étapes nécessaires pour remplir l'ensemble
    e:Integer;          -- e est le nombre tiré au hasard à chaque étape
    package Ensembles_Entier is new Ensembles_Chainage(Integer);
    use Ensembles_Entier;
    package Mon_Alea is new Alea(10,20);
    use Mon_Alea;
    Ensemble: T_Ensemble;

begin
    S:=0.0;
    for i in 1..100 loop
        n:=0.0;
        Initialiser(Ensemble);
        while Obtenir_Taille(Ensemble)<10 loop
            Get_Random_Number(e);
            n:=n+1.0;
            if Est_Present(Ensemble,e)=False then
                Ajouter(Ensemble,e);
            else
                null;
            end if;
        end loop;
        Detruire(Ensemble);
        S:=S+n;
    end loop;
    S:=S/100.0;
    Put(S);
end Nombre_Moyen_Tirage_Chainage;

