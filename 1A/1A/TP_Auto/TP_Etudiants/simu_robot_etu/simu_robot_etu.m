% ~gergaud/ENS/Automatique/TP19-20/TP_Etudiants/simu_robot/simu_rotot_etu.m
%
%
% Auteur : Gergaud Joseph
% Date : october 2019
% Institution : Université de Toulouse, INP-ENSEEIHT
%               Département Sciences du Numérique
%               Informatique, Mathématiques appliquées, Réseaux et Télécommunications
%               Computer Science department
%
%-----------------------------------------------------------------------------------------
%
% Code Matlab de test pour la simulation du pendule inversé contrôlé. 
%
%-----------------------------------------------------------------------------------------


% Remarque : On ne fait pas de sous programme car Simulink utilise
% l'environnement Matlab
%
clear all; close all;
addpath('../../','./Ressources');
% Pour une figure avec onglet
set(0,  'defaultaxesfontsize'   ,  12     , ...
   'DefaultTextVerticalAlignment'  , 'bottom', ...
   'DefaultTextHorizontalAlignment', 'left'  , ...
   'DefaultTextFontSize'           ,  12     , ...
   'DefaultFigureWindowStyle','docked');
%
% Initialisations
% ---------------
t0 = 0;             % temps initial
xe = [0 0 0 0]';     % (x_e, u_e) point de fonctionnement
ue = 0;             %

% Cas 1
% -----

fich_simulink_etu = './robot_etu'

% Cas 1.1

fich = 'cas1_1';
x0 = [0 0 0 0]';
tf = 2;             % temps final
K = [0 0 0 0];
algorithme = 'ode45';
RelTol = '1e-3';

simu_robot


% Cas 1.2

fich = 'cas1_2';

tf = 2;             % temps final

% A compléter

 x0 = [0 pi/10 0 0]'; % initial point
 K = [0.6700,19.9055,1.0747,1.9614];


delta_t =0.1;          % si nécessaire 
algorithme = 'ode45';
RelTol = '1e-3';

simu_robot

% On crée des tableaux contenant les différentes valeurs à tester
% x0_Tab=[[0 pi/6 0 0];[0 pi/3 0 0];[0 pi/5 0 0];[0 pi/4 0 0]];
% K_Tab=[[0.6700,19.9055,1.0747,1.9614]; 2*[0.6700,19.9055,1.0747,1.9614] ;3*[0.6700,19.9055,1.0747,1.9614]; 4*[0.6700,19.9055,1.0747,1.9614]];
% delta_t_tab=[0.001 0.002 0.003 0.004];
% 
% 
% Test de la sensibilité à x0
% figure;
% subplot(2,1,1);
% K=K_Tab(1,:);               % on fait varier K
% delta_t=delta_t_tab(1);     % on fait varier delta_t
% 
% for i =1:4
%     x0=x0_Tab(i,:);         % on fait varier x0  
%     x0=x0';
%     Out = sim(fich_simulink_etu,[t0 tf],options_sim);
%     X=Out.X;
%     U=Out.U;
%     plot(X.Time,X.Data);
%     plot(U.Time,U.Data);
% end
% 
% Test de la sensibilité à K
% figure;
% subplot(2,1,1);
% x0=x0_Tab(1,:);             % on fixe x0
% delta_t=delta_t_tab(1);     % on fixe delta_t
% 
% for i =1:4
%     K=K_Tab(i,:);           % on fait varier K 
%     Out = sim(fich_simulink_etu,[t0 tf],options_sim);
%     X=Out.X;
%     U=Out.U;
%      plot(X.Time,X.Data);
%      plot(U.Time,U.Data);
%  
%  end
%  
%  %Test de la sensibilité à delta_t
%  figure;
%  subplot(2,1,1);
%  x0=x0_Tab(1,:);         % on fixe x0
%  K=K_Tab(1,:);           % on fixe K
%  for i =1:4
%      delta_t=delta_t_tab(i);         % on fait varier delta_t 
%      Out = sim(fich_simulink_etu,[t0 tf],options_sim);
%      X=Out.X;
%      U=Out.U;
%      plot(X.Time,X.Data);
%      plot(U.Time,U.Data);
%  end
% 
% 
