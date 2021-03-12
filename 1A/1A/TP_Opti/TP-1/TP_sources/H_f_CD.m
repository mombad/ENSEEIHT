%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ehouarn Simon                                                         %
% mars 2017                                                             %
% INP Toulouse - ENSEEIHT                                               %	
%                                                                       %
% Ce fichier contient les fonctions matlab pour l'exemple               %
% de l'estimation des parametres de la fonction de Cobb-Douglas         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function H=H_f_CD(beta)
% Calcul de la matrice Hessienne de la fonction f_CD
% beta : parametres de la fonction de Cobb-Douglas
% beta(1)= A; beta(2) = alpha

global Ki Li Yi

%TO DO
a=length(Yi);
H=zeros(2*a,2);
H(a+1:,1)= log(Ki/Li)*Li*exp(beta(2)*log(Ki/Li));
H(1:a,1)=H(a+1:,1);
H(a+1:,2)=log(Ki/Li)*log(Ki/Li)*Li*exp(beta(2)*log(Ki/Li));
end
