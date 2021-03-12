clear;
close all;
load donnees;
load exercice_1;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

% Seuil de reconnaissance a regler convenablement
s = 1.0e+00;

% Pourcentage d'information 
per = 0.95;

% Tirage aleatoire d'une image de test :

%Ici, on paramètre individu et posture en fonction de la base
%d'apprentissage que l'on a défini dans données : Le but étant de tester
%des individus PRESENT dans la base de d'apprentissage, mais sur des postures QUI NE
%SONT PAS dans la base d'apprentissage

individu = randi(26);  %%Un individu présent dans la base d'apprentissage
posture = 6;  %%Une posture de cette individu non présente dans la base d'apprentissage A RECONNAITRE.

chemin = './Images_Projet_2020';
fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg']
Im=importdata(fichier);
I=rgb2gray(Im);
I=im2double(I);
image_test=I(:)';
 

% Affichage de l'image de test :
colormap gray;
imagesc(I);
axis image;
axis off;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres] :
N = 4;

% N premieres composantes principales des images d'apprentissage :
C = Xc*W;
Cn = C(:,1:N); 

% N premieres composantes principales de l'image de test :
Xc_test = image_test' - individu_moyen;
C_test = transpose(Xc_test)*W;
C_testn = C_test(:,1:N);

% Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
labelA = zeros(1,nb_individus*nb_postures);
for i = 1:nb_individus
    for j= 1:nb_postures
        labelA(nb_postures*i -nb_postures +j) = (numeros_individus(i)-1)*6 + numeros_postures(j);
    end
end

%%EXPLICATION CONSTRUCTION DE labelA
%Chaque individu a 6 postures. J'associe un nombre unique à la posture de
%chaque individu. Ainsi, la posture 5 de l'individu numéro 2 sera associée
%au nombre 11. La posture 5 de l'individu 20 sera associé au nombre 124
%(4*6 + 5 = 125).
        
labelT = [(individu - 1)*6 + posture];

[Partition, confusion] = kppv_alex(Cn, C_testn, labelA, 4, labelA, labelT);

if rem(Partition(1),6) ~= 0
    individu_reconnu = fix(Partition(1)/6) + 1;
else
    individu_reconnu = Partition(1)/6;
end

if rem(labelT,6) ~= 0
    individu_test = fix(labelT/6) + 1 ;
else
    individu_test = labelT/6;
end

%Ainsi, la matrice de confusion qui ressort de la fonction
%kppv ne pourra pas être diagonale, puisque le but de la reconaissance est
%de soumettre des postures qui ne sont pas dans la base d'apprentissage et
%de les associés à un individu (et pas à une autre posture). C'est pourquoi
%nous reconstruisons ensuite une autre matrice de confusion qui permet de
%savoir si les individus tests sont associés au bons individu 

confusion_individus = zeros(nb_individus + 1);

confusion_individus(individu_test, individu_reconnu) = confusion_individus(individu_test, individu_reconnu) + 1; 



%Affichage du resultat

%Si il y a un élément sur la diagonale de la matrice confusion_individus,
%alors la reconnaissance s'est bien effectuée 

if trace(confusion_individus) > 0
        title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
		['Je reconnais l''individu numero ' num2str(individu_reconnu+3)]},'FontSize',20);
else
	title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
		'Je ne reconnais pas cet individu !'},'FontSize',20);
end
