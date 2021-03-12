with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
function dates (Mois : in Integer) return Integer with
            Pre =>  Mois > 0 and Mois < 13,
        Post => dates'result > 27 and dates'result < 32 is
            a : Integer;
    begin
        Get(a);
        if Mois mod 2 = 0 then
            if Mois = 2 then
                return(28);
            else
                return(31);
            end if;
        else
            return(30);
        end if;
end dates;
