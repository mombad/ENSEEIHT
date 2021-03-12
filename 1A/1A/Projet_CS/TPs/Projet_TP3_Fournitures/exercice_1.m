clear;
close all;

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
load donnees;
figure('Name','Individu moyen et eigenfaces','Position',[0,0,0.67*L,0.67*H]);

%La matrice X contient les images brutes et est de taille 16*307200 
%C'est à dire nb_images*nb_pixels_par_image (les pixels étant représentés
%par leur niveau de gris)
% Calcul de l'individu moyen :

individu_moyen = (1/n)*transpose(X)*ones(n,1);

% Centrage des donnees :
Xc = X - ones(n,1)*transpose(individu_moyen);

% Calcul de la matrice Sigma_2 (de taille n x n) [voir Annexe 1 pour la nature de Sigma_2] :
Sigma2 = Xc*transpose(Xc)*(1/n);

% Calcul des vecteurs/valeurs propres de la matrice Sigma_2 :
[V,D] = eig(Sigma2);

% Tri par ordre decroissant des valeurs propres de Sigma_2 :
[D_tri,M] = sort(diag(D),'descend');

% Tri des vecteurs propres de Sigma_2 dans le meme ordre :
V_tri = V(:,M);

% Elimination du dernier vecteur propre de Sigma_2 :
V_tri_sans_dernier = V_tri(:,1:(n-1));


% Vecteurs propres de Sigma (deduits de ceux de Sigma_2) :

%%Attention, la dimension de W est de (p*(n-1)), elle n'a pas du tout la
%%même dimension que la matrice des vecteurs propres de Sigma2 !!!
W = ones(p,(n-1));

%%CF Annexe : "SI Y est un Vec propre de Sigma2 associé à la vp lambda,
%%alors transpose(Xc)*Y est un Vec propre de Sigma associé à la vp lambda" 
W(:,1:(n-1)) = transpose(Xc)*V_tri_sans_dernier(:,1:(n-1));
    
% Normalisation des vecteurs propres de Sigma
% [les vecteurs propres de Sigma_2 sont normalisés
% mais le calcul qui donne W, les vecteurs propres de Sigma,
% leur fait perdre cette propriété] :
W = normalize(W,'norm');

%Affichage de l'individu moyen et des eigenfaces sous forme d'images :
colormap gray;
img = reshape(individu_moyen,nb_lignes,nb_colonnes);
subplot(nb_individus,nb_postures,1);
imagesc(img);
axis image;
axis off;
title('Individu moyen','FontSize',15);
for k = 1:n-1
	img = reshape(W(:,k),nb_lignes, nb_colonnes);
	subplot(nb_individus,nb_postures,k+1);
	imagesc(img);
	axis image;
	axis off;
	title(['Eigenface ',num2str(k)],'FontSize',15);
end

save exercice_1;
