function [a_estime,b_estime] = estimation_1(x_donnees_bruitees,y_donnees_bruitees,psi_tests)
Xg=mean(x_donnees_bruitees);
Yg=mean(y_donnees_bruitees);
X_nouveau=x_donnees_bruitees-Xg;
Y_nouveau=y_donnees_bruitees-Yg;

Sommes_a=zeros(length(x_donnees_bruitees),1);
for i=1:length(x_donnees_bruitees)
    s=sum((Y_nouveau-tan(psi_tests(i))*X_nouveau).^2);
    Sommes_a(i)=s;
end
[psi,ind_psi]=min(Sommes_a);
a_estime=tan(psi_tests(ind_psi));
b_estime=Yg-a_estime*Xg;