function [mu, Sigma] = estimation_mu_Sigma(X)

n=size(X,1);

mu=X'*ones(n,1)/n;
Xc= X-ones(n,1)*mu';
Sigma=(Xc')*Xc/n;