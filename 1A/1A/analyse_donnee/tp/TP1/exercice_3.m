%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de données
% TP1 - Espace de représentation des couleurs
% Exercice_1.m
%--------------------------------------------------------------------------

clear
close all
clc

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

%% Décomposition des canaux RVB d'une image couleur

%I = imread('autumn.tif');          % 1er exemple
%I = imread('gantrycrane.png');    % 2nd exemple
%I = imread('pears.png');          % 3ième exemple (dernier exercice)
 I = imread('coloredChips.png');   % 4ième exemple (dernier exercice)

% Découpage de l'image en trois canaux et conversion en flottants
R = single(I(:,:,1));
V = single(I(:,:,2));
B = single(I(:,:,3));

%% Affichage de l'image RVB et de ses canaux

% 1ère fenêtre d'affichage
figure('Name','Separation des canaux RVB',...
       'Position',[0.01*L,0.1*H,0.59*L,0.75*H])

% Affichage de l'image RVB
    subplot(2,2,1)	% La fenêtre comporte 2 lignes et 2 colonnes
    imagesc(I)
    axis off image
    title('Image RVB','FontSize',20)
    
colormap gray % Pour afficher les images en niveaux de gris
              % Affichage avec la palette 'parula' par défaut sinon
    
% Affichage du canal R
    subplot(2,2,2) % 1ère ligne, 2ème colonne
    imagesc(R)
    axis off image
    title('Canal R','FontSize',20)
    
% Affichage du canal V
    subplot(2,2,3) % 2ème ligne, 1ère colonne
    imagesc(V)
    axis off image
    title('Canal V','FontSize',20)
    
% Affichage du canal B
    subplot(2,2,4) % 2ème ligne, 2ème colonne
    imagesc(B)
    axis off image
    title('Canal B','FontSize',20)
    
% Enregistrement des images des canaux
imwrite(uint8(R),'canal_R.png')
imwrite(uint8(V),'canal_V.png')
imwrite(uint8(B),'canal_B.png')

%% Affichage du nuage de pixels dans le repère RVB

% % Deuxième fenêtre d'affichage
figure('Name','Nuage de pixels dans le repere RVB',...
       'Position',[0.61*L,0.1*H,0.38*L,0.6*H])

    plot3(R,V,B,'b.')
    axis equal
    grid on
    xlabel('R','FontWeight','bold')
    ylabel('V','FontWeight','bold')
    zlabel('B','FontWeight','bold')
    title({'Représentation 3D des pixels' ...
           'dans l''espace RVB'},'FontSize',20)
    rotate3d 

%% Calcul des corrélations entre les canaux RVB et des contrastes
    
% Matrice des données
X = [R(:) V(:) B(:)];	% Les trois canaux sont vectorisés et concaténés

% Matrice de variance/covariance
% A REMPLIR %
n=size(X,1);
r_barre=mean(X(:,1));
v_barre=mean(X(:,2));
b_barre=mean(X(:,3));
Xc=X;
Xc(:,1)=Xc(:,1)-r_barre;
Xc(:,2)=Xc(:,2)-v_barre;
Xc(:,3)=Xc(:,3)-b_barre;
sigma=Xc'*Xc/n;

% Coefficients de corrélation linéaire
Rrv=sigma(1,2)/sqrt(sigma(1,1)*sigma(2,2));
Rvb=sigma(2,3)/sqrt(sigma(3,3)*sigma(2,2));
Rrb=sigma(1,3)/sqrt(sigma(1,1)*sigma(3,2));

% Proportions de contraste
Cr=sigma(1,1)/(sigma(1,1)+(sigma(2,2))+(sigma(3,3)));
Cv=sigma(2,2)/(sigma(1,1)+(sigma(2,2))+(sigma(3,3)));
Cb=sigma(3,3)/(sigma(1,1)+(sigma(2,2))+(sigma(3,3)));


%%
[W,D] = eig(sigma);
[D_trie, indices]=sort(diag(D),'descend');
W_trie=W(:,indices);

C=Xc*W_trie;

C1=reshape(C(:,1),size(R));
C2=reshape(C(:,2),size(R));
C3=reshape(C(:,3),size(R));
% Affichage de la nouvelle image RVB et de ses canaux

% 1ère fenêtre d'affichage
figure('Name','Separation des canaux RVB',...
       'Position',[0.01*L,0.1*H,0.59*L,0.75*H])

% Affichage de l'image RVB
    subplot(2,2,1)	% La fenêtre comporte 2 lignes et 2 colonnes
    imagesc(I)
    axis off image
    title('Image RVB','FontSize',20)
    
colormap gray % Pour afficher les images en niveaux de gris
              % Affichage avec la palette 'parula' par défaut sinon
    
% Affichage du canal R
    subplot(2,2,2) % 1ère ligne, 2ème colonne
    imagesc(C1)
    axis off image
    title('Nouveau Canal R','FontSize',20)
    
% Affichage du canal V
    subplot(2,2,3) % 2ème ligne, 1ère colonne
    imagesc(C2)
    axis off image
    title('Nouveau Canal V','FontSize',20)
    
% Affichage du canal B
    subplot(2,2,4) % 2ème ligne, 2ème colonne
    imagesc(C3)
    axis off image
    title('Nouveau Canal B','FontSize',20)
    
% Calcul des corrélations entre les canaux RVB et des contrastes
    
% Matrice des données
nouveau_X = [C1(:) C2(:) C3(:)];	% Les trois canaux sont vectorisés et concaténés

% Matrice de variance/covariance
% A REMPLIR %
n=size(X,1);
nr_barre=mean(nouveau_X(:,1));
nv_barre=mean(nouveau_X(:,2));
nb_barre=mean(nouveau_X(:,3));
nXc=X;
nXc(:,1)=nXc(:,1)-nr_barre;
nXc(:,2)=nXc(:,2)-nv_barre;
nXc(:,3)=nXc(:,3)-nb_barre;
nsigma=nXc'*nXc/n;

% Coefficients de corrélation linéaire
nRrv=nsigma(1,2)/sqrt(nsigma(1,1)*nsigma(2,2));
nRvb=nsigma(2,3)/sqrt(nsigma(3,3)*nsigma(2,2));
nRrb=nsigma(1,3)/sqrt(nsigma(1,1)*nsigma(3,2));

% Proportions de contraste
nCr=nsigma(1,1)/(nsigma(1,1)+(nsigma(2,2))+(nsigma(3,3)));
nCv=nsigma(2,2)/(nsigma(1,1)+(nsigma(2,2))+(nsigma(3,3)));
nCb=nsigma(3,3)/(nsigma(1,1)+(nsigma(2,2))+(nsigma(3,3)));
