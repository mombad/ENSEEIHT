%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ehouarn Simon                                                         %
% mars 2017                                                             %
% INP Toulouse - ENSEEIHT                                               %	
%                                                                       %
% Ce fichier contient les fonctions matlab pour l'exemple               %
% de l'estimation des parametres de la fonction de Cobb-Douglas         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Jres=J_res_CD(beta)
% Calcul de la matrice Jacobienne du vecteur des residus
% beta : parametres de la fonction de Cobb-Douglas
% beta(1)= A; beta(2) = alpha

global Ki Li Yi
Jres=zeros(length(Ki),2);
% TO DO
for i=1:length(Ki)
    Jres(i,1)=(Ki(i).^beta(2)) * Li(i).^(1-beta(2));
    Jres(i,2)=log(Ki(i)/Li(i))*beta(1)*Li(i)*exp(beta(2)*log(Ki(i)/Li(i)));
%Jres=[(Ki.^beta(2)) .* Li.^(1-beta(2)) , (log(Ki)-log(Li)).*beta(1)*Li.*exp(beta(2)*(log(Ki)-log(Li)))];
end
