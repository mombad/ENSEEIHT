with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

-- Auteur: BEN AHMED DAHO Mohamed
-- Gérer un stock de matériel informatique.
--
package body Stocks_Materiel is

    procedure Creer (Stock : out T_Stock) is
        A: T_Stock;
    begin
        Stock:= A;
    end Creer;


    function Nb_Materiels (Stock: in T_Stock) return Integer is
        nb: Integer;
        
    begin
        nb:=0;
        while Stock(nb).Numero_Serie /=0 loop
            nb:= nb+1;
        end loop;
        return(nb);
    end;

    function Nb_Materiels_HS (Stock: in T_Stock) return Integer is
        nb : Integer;
    begin
        nb:=0;
        for i in (1..Nb_Materiels) loop
            if Stock(i).Etat = Ne_Fonctionne_Pas then
                nb:= nb+1;
            else
                null;
            end if;
        end loop;
        return nb;

    procedure Enregistrer (
                           Stock        : in out T_Stock;        
                           Numero_Serie : in     Integer;
                           Nature       : in     T_Nature;
                           Annee_Achat  : in     Integer
                          ) is
        nb: Integer;
    begin        
        nb := Nb_Materiels(Stock);
        Stock(nb+1).Numero_Serie := Numero_Serie;
        Stock(nb+1).Nature := Nature;
        Stock(nb+1).Annee_Achat := Annee_Achat;
        Stock(nb+1).Etat := Fonctionne;
        
            
    end;


end Stocks_Materiel;
