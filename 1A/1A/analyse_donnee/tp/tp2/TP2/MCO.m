function Beta_chapeau = MCO(x, y);
n=length(x);
A=[x.*x x.*y y.*y x y ones(n,1)];
A=[A; 1 0 1 0 0 0];
B=zeros(n,1);
B=[B; 1];

Beta_chapeau=pinv(A)*B;