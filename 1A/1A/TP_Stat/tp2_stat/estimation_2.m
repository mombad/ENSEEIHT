function [a_estime,b_estime] = estimation_2(x_donnees_bruitees,y_donnees_bruitees)

A(:,1)=x_donnees_bruitees;
A(:,2)=1;
B=y_donnees_bruitees';

pseudo_inv=inv(transpose(A)*A)*transpose(A);
X=pseudo_inv*B;

a_estime=X(1);
b_estime=X(2);
