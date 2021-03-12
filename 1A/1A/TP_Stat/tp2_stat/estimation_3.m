function [theta_estime,rho_estime] = estimation_3(x_donnees_bruitees,y_donnees_bruitees,theta_tests)
Xg=mean(x_donnees_bruitees);
Yg=mean(y_donnees_bruitees);
X_nouveau=x_donnees_bruitees-Xg;
Y_nouveau=y_donnees_bruitees-Yg;


Sommes_theta=zeros(length(x_donnees_bruitees),1);

for i=1:length(x_donnees_bruitees)
    s=sum((X_nouveau*cos(theta_tests(i))+Y_nouveau*sin(theta_tests(i))).^2);
    Sommes_theta(i)=s;
end

[theta,ind_theta]=min(Sommes_theta);
theta_estime=tan(theta_tests(ind_theta));

rho_estime=Xg*cos(theta_estime) + Yg*sin(theta_estime);
