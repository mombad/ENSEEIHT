function [C_estime , R_estime] = estimation_1(x_donnees_bruitees,y_donnees_bruitees,C_tests,R_tests)
lc=length(C_tests);
d=zeros(length(x_donnees_bruitees),1);
for i=1:lc
    dist=sqrt((x_donnees_bruitees-C_tests(i,1)).^2+(y_donnees_bruitees-C_tests(i,2)).^2);
    d(i)=sum((dist-R_tests(i)).^2);
end
[C_min, ind]=min(d);
C_estime=C_tests(ind,:);
R_estime=R_tests(ind);