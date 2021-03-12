clear;
close all;
load donnees;
load exercice_1;
%figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

% Seuil de reconnaissance a regler convenablement
s = 1.0e+00;

% Pourcentage d'information 
per = 0.95;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres] :
N = 1;

nb_p = nb_postures+1;   %nombre de postures possibles pour un individu (+ 1 pour l'image à tester)

% Tirage aleatoire d'une image de test :
%individu = randi(37);
%posture = randi(6);
individus_test = [2 4 6 37 2 4 6 37 2 4];
dataTest = zeros(4,N);
for i=1:10
    
individu = individus_test(i);
posture = randi(2)+nb_p-1;
labelTest(i) = mod(5*i+1,nb_p*nb_individus);
chemin = './Images_Projet_2020';
fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg']
Im=importdata(fichier);
I=rgb2gray(Im);
I=im2double(I);
image_test=I(:)';
 

% % Affichage de l'image de test :
% colormap gray;
% imagesc(I);
% axis image;
% axis off;


% N premieres composantes principales des images d'apprentissage :
C = Xc*W;
Cn = C(:,1:N);

% N premieres composantes principales de l'image de test :
Xc_test = image_test' - individu_moyen;
C_test = transpose(Xc_test)*W;

CtestN = C_test(:,1:N);
dataTest(i,:)=CtestN;
end

% Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
labelA = [1 2 3 4 6 7 8 9 11 12 13 14 16 17 18 19];

listeClass = [1:nb_individus*(nb_p)];
%(find(numeros_individus == individu)-1)*nb_p + posture)
[etiquette, confusion] = kppv(Cn,dataTest,labelA,1,listeClass,labelTest);

%Decision de l'individu reconnu
individu_reconnu = numeros_individus(1+fix(etiquette/nb_p));
posture_reconnue = mod(etiquette,nb_p);
%Matrice de confusion des individus
confusion_individu = zeros(nb_individus);

for i=1:10
    x = find(numeros_individus == individus_test(i));
    y = find(numeros_individus == individu_reconnu(i));
    confusion_individu(x,y) = confusion_individu(x,y) + 1;
end

taux = (sum(sum(confusion_individu)) - sum(diag(confusion_individu)))/length(individus_test);




figure

axis image;
axis off;
% Affichage du resultat :
if (individus_test==individu_reconnu) 
    fichier_reconnu = [chemin '/' num2str(individu_reconnu(4)+3) '-' num2str(posture_reconnue(4)) '.jpg'];
    Im_reconnu = importdata(fichier_reconnu);
    I_reconnu=rgb2gray(Im_reconnu);
    I_reconnu=im2double(I_reconnu);
    colormap gray;
    imagesc(I_reconnu);

	title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
        ['Je reconnais l''individu numero ' num2str(individu_reconnu(4)+3)]},'FontSize',20);
else
	title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
        ['Je ne reconnais pas cet individu !']},'FontSize',20);
end
