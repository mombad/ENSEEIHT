function [cos_theta_estime,sin_theta_estime,rho_estime] = estimation_4(x_donnees_bruitees,y_donnees_bruitees)
Xg=mean(x_donnees_bruitees);
Yg=mean(y_donnees_bruitees);
X_nouveau=x_donnees_bruitees-Xg;
Y_nouveau=y_donnees_bruitees-Yg;

C=zeros(length(x_donnees_bruitees),2);
C(:,1)=X_nouveau;
C(:,2)=Y_nouveau;

[Vep,Vap]=eig(transpose(C)*C);
[lambda, ind_lambda]=min(diag(Vap));
Yp=Vep(:,ind_lambda);
cos_theta_estime=Yp(1);
sin_theta_estime=Yp(2);
rho_estime=Xg*cos_theta_estime + Yg*sin_theta_estime;
