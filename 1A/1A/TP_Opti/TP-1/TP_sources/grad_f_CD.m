%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ehouarn Simon                                                         %
% mars 2017                                                             %
% INP Toulouse - ENSEEIHT                                               %	
%                                                                       %
% Ce fichier contient les fonctions matlab pour l'exemple               %
% de l'estimation des parametres de la fonction de Cobb-Douglas         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function g=grad_f_CD(beta)
% Calcul du gradient de la fonction f_CD
% beta : parametres de la fonction de Cobb-Douglas
% beta(1)= A; beta(2) = alpha

% TO DO
g=(J_res_CD(beta).')*res_CD(beta);
end
