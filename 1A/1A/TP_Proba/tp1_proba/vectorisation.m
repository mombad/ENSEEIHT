function [X,Y] = vectorisation(I);
G=I(:,1:end-1);
D=I(:,2:end);
X=G(:);
Y=D(:);
