function [x,y,M]=matrice_inertie(E_x,E_y,G_norme_E)
x=(1/sum(G_norme_E))*sum(E_x.*G_norme_E);
y=(1/sum(G_norme_E))*sum(E_y.*G_norme_E);

M=zeros(2,2);

M(1,1)=1/sum(G_norme_E)*sum(G_norme_E .* (E_x-x).*(E_x-x));

M(2,2)=(1/sum(G_norme_E))*sum((E_y-y).*(E_y-y).*G_norme_E);

M(1,2)=(1/sum(G_norme_E))*sum((E_y-y).*(E_x-x).*G_norme_E);

M(2,1)=M(1,2);