%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP4 - Reconnaissance de chiffres manuscrits par k plus proches voisins
% fonction kppv.m
%--------------------------------------------------------------------------
function [Partition, confusion] = kppv(DataA,DataT,labelA,K,ListeClass,labelT)
confusion=zeros(length(ListeClass));
[Na,~] = size(DataA);
[Nt,~] = size(DataT);

Nt_test = Nt; % A changer, pouvant aller de 1 jusqu'à Nt

% Initialisation du vecteur d'étiquetage des images tests
Partition = zeros(Nt_test,1);

disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
disp(['par la methode des ' num2str(K) ' plus proches voisins:'])
taux = 0;
% Boucle sur les vecteurs test de l'ensemble de l'évaluation
for i = 1:Nt_test
    
    disp(['image test n°' num2str(i)])

    % Calcul des distances entre les vecteurs de test 
    % et les vecteurs d'apprentissage (voisins)
    % A COMPLÉTER
    for j=1:Na
    distanceT(j) = norm(DataT(i,:)-DataA(j,:));
    end
    % On ne garde que les indices des K + proches voisins
    % A COMPLÉTER
    [A, I]=mink(distanceT,K);
    
    % Comptage du nombre de voisins appartenant à chaque classe
    % A COMPLÉTER
    Labels = zeros(size(ListeClass));
    for z=1:length(I)
        Labels(labelA(I(z)))=Labels(labelA(I(z))) + 1;
    end
    
    % Recherche de la classe contenant le maximum de voisins
    % A COMPLÉTER
    [maximum,indice] = max(Labels);
    
    % Si l'image test a le plus grand nombre de voisins dans plusieurs  
    % classes différentes, alors on lui assigne celle du voisin le + proche,
    % sinon on lui assigne l'unique classe contenant le plus de voisins 
    % A COMPLÉTER
    if sum(Labels == maximum)>1
        [minimum,indice_min] = min(distanceT);
        etiquette = labelA(indice_min)
    else
        etiquette = indice;
    end
        
    
    % Assignation de l'étiquette correspondant à la classe trouvée au point 
    % correspondant à la i-ème image test dans le vecteur "Partition" 
    % A COMPLÉTER
    Partition(i) = etiquette;
    
    %Matrice de confusion   
        
     %if etiquette~=labelT(i)
             confusion(labelT(i),etiquette) = confusion(labelT(i),etiquette) + 1;     
         
   %  end
     
           
    
end


%taux = taux/Nt_test;
%taux = (sum(sum(confusion)) - sum(diag(confusion)))/Nt_test
end

