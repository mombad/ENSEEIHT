%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ehouarn Simon                                                         %
% mars 2017                                                             %
% INP Toulouse - ENSEEIHT                                               %	
%                                                                       %
% Ce fichier contient les fonctions matlab pour l'exemple               %
% de l'estimation des parametres de la fonction de Cobb-Douglas         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y=f_CD(beta)
% Evaluation de la fonction des moindres carres
% beta : parametres de la fonction de Cobb-Douglas
% beta(1)= A; beta(2) = alpha

%TO DO
y=0;
y=sum( (1/2) * res_CD(beta).^2);
end
