function [rho_F,theta_F,moy] = estimation_F(rho,theta)
A=[cos(theta),sin(theta)];
X=pinv(A)*rho;
rho_F=sqrt(X(1).^2+X(2).^2);
theta_F=atan2(X(2),X(1));
moy=mean(rho-rho_F*cos(theta-theta_F));